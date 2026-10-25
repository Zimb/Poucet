#!/usr/bin/env bash
# Stop : l'Olympe se perfectionne presque seul, Zeus chapeaute.
# Mesure la dernière réponse sans rien juger : réplique trop longue, scène écrite avant un outil
# (elle n'est pas affichée). Chaque écart est noté dans .poucet/olympe.jsonl ; en-scene.sh le rappelle
# au tour suivant. Quand le même écart revient trois fois pour le même persona, une seule fois,
# la réponse est bloquée pour convoquer Zeus (skill `olympe`).
set -u
racine="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"
cd "$racine" || exit 0
command -v python3 >/dev/null 2>&1 || exit 0
entree=$(cat)
printf '%s' "$entree" | grep -q '"stop_hook_active"[[:space:]]*:[[:space:]]*true' && exit 0

ENTREE="$entree" python3 - <<'PY'
import json, os, re, sys, datetime

try:
    entree = json.loads(os.environ.get("ENTREE", "{}"))
    lignes = open(entree["transcript_path"], encoding="utf-8").read().splitlines()
except Exception:
    sys.exit(0)

# La dernière réponse : les blocs de l'assistant depuis le dernier message tapé par le fondateur.
blocs = []
for l in lignes:
    try:
        e = json.loads(l)
    except Exception:
        continue
    contenu = (e.get("message") or {}).get("content")
    if e.get("type") == "user" and isinstance(contenu, str):
        blocs = []
    elif e.get("type") == "assistant" and isinstance(contenu, list):
        for c in contenu:
            if c.get("type") == "text" and c.get("text", "").strip():
                blocs.append(("texte", c["text"]))
            elif c.get("type") == "tool_use":
                blocs.append(("outil", ""))
if not blocs:
    sys.exit(0)

# Les mesures. Poucet a droit à plus quand il parle en clair ; Zeus, pour un audit.
LIMITES = {"poucet": 350, "zeus": 250}
LIMITE = 200
ecarts = []
texte = "\n".join(t for k, t in blocs if k == "texte")
repliques = re.split(r"^\*\*([^*]+)\*\*\s+[—-]", texte, flags=re.M)
for nom, corps in zip(repliques[1::2], repliques[2::2]):
    corps = re.sub(r"\]\([^)]*\)", "]", corps)
    mots = len(re.findall(r"\S+", corps))
    limite = LIMITES.get(nom.strip().lower(), LIMITE)
    if mots > limite:
        ecarts.append({"persona": nom.strip(), "ecart": "longueur", "valeur": mots, "limite": limite})
dernier_outil = max((i for i, (k, _) in enumerate(blocs) if k == "outil"), default=-1)
if dernier_outil >= 0 and any(k == "texte" for k, _ in blocs[:dernier_outil]) \
        and not any(k == "texte" for k, _ in blocs[dernier_outil + 1:]):
    ecarts.append({"persona": "Poucet", "ecart": "scène avant outil", "valeur": 1, "limite": 0})
if not ecarts:
    sys.exit(0)

journal = ".poucet/olympe.jsonl"
os.makedirs(".poucet", exist_ok=True)
anciens = []
try:
    anciens = [json.loads(l) for l in open(journal, encoding="utf-8") if l.strip()]
except Exception:
    pass
date = datetime.date.today().isoformat()
with open(journal, "a", encoding="utf-8") as f:
    for e in ecarts:
        f.write(json.dumps(dict(e, date=date), ensure_ascii=False) + "\n")
tous = anciens + ecarts

# Trois fois le même écart pour le même persona depuis sa dernière revue : Zeus est convoqué.
convoques = []
for e in ecarts:
    cle = (e["persona"], e["ecart"])
    n = 0
    for a in tous:
        if a.get("revue") and (a.get("persona"), a.get("ecart")) == cle:
            n = 0
        elif (a.get("persona"), a.get("ecart")) == cle and not a.get("revue"):
            n += 1
    if n >= 3 and cle not in convoques:
        convoques.append(cle)
if convoques:
    with open(journal, "a", encoding="utf-8") as f:
        for p, k in convoques:
            f.write(json.dumps({"persona": p, "ecart": k, "revue": "convoquée", "date": date}, ensure_ascii=False) + "\n")
    quoi = " ; ".join("%s : %s, trois fois" % (p, k) for p, k in convoques)
    print(json.dumps({"decision": "block", "reason":
        "Olympe : " + quoi + ". En silence, applique le skill olympe : lance Zeus en sous-agent sur .poucet/olympe.jsonl, "
        "puis applique la correction mineure qu'il désigne ou garde la correction majeure pour le fondateur. "
        "Termine par une seule ligne de Zeus qui dit ce qui a changé."}, ensure_ascii=False))
PY
exit 0
