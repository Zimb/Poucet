#!/usr/bin/env bash
# Stop : avant de jouer un persona, Poucet lit sa fiche, et une scène n'a pas plus de trois voix.
# Lit la transcription : les voix de la dernière réponse (**Nom** —), et les fiches déjà lues dans la séance
# (par un outil ou données par le hook d'ouverture). Si une fiche manque, ou s'il y a plus de trois voix,
# demande la lecture en silence pour la scène suivante.
set -u
racine="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"
cd "$racine" || exit 0
command -v python3 >/dev/null 2>&1 || exit 0
entree=$(cat)
printf '%s' "$entree" | grep -q '"stop_hook_active"[[:space:]]*:[[:space:]]*true' && exit 0

ENTREE="$entree" python3 - <<'PY'
import json, os, re, glob, sys

try:
    entree = json.loads(os.environ.get("ENTREE", "{}"))
    lignes = open(entree["transcript_path"], encoding="utf-8").read().splitlines()
except Exception:
    sys.exit(0)

# Les fiches : le nom tel qu'il est écrit dans « Tu es **Nom** ».
fiches = {}
for f in glob.glob(".claude/agents/*.md"):
    m = re.search(r"Tu es \*\*(.+?)\*\*", open(f, encoding="utf-8").read())
    if m:
        fiches[m.group(1).lower()] = (m.group(1), f)

def textes(contenu):
    if isinstance(contenu, str):
        yield contenu
    elif isinstance(contenu, list):
        for c in contenu:
            if isinstance(c, dict):
                for cle in ("text", "content", "input"):
                    if cle in c:
                        yield from textes(c[cle] if cle != "input" else json.dumps(c[cle], ensure_ascii=False))
            else:
                yield from textes(c)
    elif isinstance(contenu, dict):
        yield json.dumps(contenu, ensure_ascii=False)

lu = ""          # tout ce que la séance a vu, hors répliques de l'assistant
derniere = ""    # le texte de la dernière réponse
for l in lignes:
    try:
        e = json.loads(l)
    except Exception:
        continue
    msg = e.get("message") or {}
    contenu = msg.get("content")
    if e.get("type") == "user" and isinstance(contenu, str):
        derniere = ""
    if e.get("type") == "assistant" and isinstance(contenu, list):
        for c in contenu:
            if c.get("type") == "text":
                derniere += c.get("text", "") + "\n"
            elif c.get("type") == "tool_use":
                lu += json.dumps(c.get("input", {}), ensure_ascii=False) + "\n"
    else:
        lu += "\n".join(textes(contenu if contenu is not None else e.get("content", ""))) + "\n"
        lu += json.dumps(e, ensure_ascii=False)[:20000] + "\n"

voix = []
for nom in re.findall(r"^\*\*([^*]+)\*\*\s+[—-]", derniere, re.M):
    if nom not in voix:
        voix.append(nom)

manquantes = [fiches[n.lower()][1] for n in voix
              if n.lower() in fiches and ("Tu es **%s**" % fiches[n.lower()][0]) not in lu]
raisons = []
if manquantes:
    raisons.append("Fiches pas encore lues dans cette séance : %s. Lis-les maintenant avec Read, en silence, et joue ces personas d'après elles à la prochaine scène." % ", ".join(manquantes))
if len(voix) > 3:
    raisons.append("La dernière scène avait %d voix (%s) : la prochaine en aura trois au plus." % (len(voix), ", ".join(voix)))
if raisons:
    print(json.dumps({"decision": "block", "reason": "Poucet : " + " ".join(raisons) + " Termine sans écrire un mot de plus."}, ensure_ascii=False))
PY
exit 0
