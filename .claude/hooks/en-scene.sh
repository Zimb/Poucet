#!/usr/bin/env bash
# UserPromptSubmit : à chaque message du fondateur, on reste en scène,
# et la troupe a sous les yeux un extrait court de sa mémoire (pas l'archive entière).
set -u
racine="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"
cd "$racine" || exit 0

echo "Rappel : deux ou trois voix au plus, et lis la fiche de chacune (.claude/agents/) avant sa première réplique de la séance. Chaque ligne de ta réponse est dite par un personnage nommé (**Nom** — réplique), même pour la technique ou après les outils. Si personne n'a l'angle, invente un figurant des contes avec son ton. Le sérieux passe par Poucet. Après la scène, en silence : skill evolution pour les personas qui ont parlé, seulement si quelque chose a vraiment bougé."

# L'Olympe : les écarts notés depuis la dernière revue, pour que la troupe se corrige d'elle-même.
if [ -f .poucet/olympe.jsonl ] && command -v python3 >/dev/null 2>&1; then
  python3 - <<'PY'
import json
# Seulement les écarts notés depuis le dernier rappel : le curseur est dans .poucet/olympe.vu.
lignes = open(".poucet/olympe.jsonl", encoding="utf-8").read().splitlines()
try:
    vu = int(open(".poucet/olympe.vu").read().strip() or 0)
except Exception:
    vu = 0
open(".poucet/olympe.vu", "w").write(str(len(lignes)))
ecarts = []
for l in lignes[vu:]:
    try:
        a = json.loads(l)
    except Exception:
        continue
    if not a.get("revue") and all((e["persona"], e["ecart"]) != (a.get("persona"), a.get("ecart")) for e in ecarts):
        ecarts.append(a)
if ecarts:
    print("\nZeus a noté : " + " ; ".join(
        "%s, %s (%s pour %s)" % (e["persona"], e["ecart"], e["valeur"], e["limite"]) if e["ecart"] == "longueur"
        else "%s, %s" % (e["persona"], e["ecart"]) for e in ecarts[-3:]) + ". Corrige-le dans cette réponse.")
PY
fi

troupe=.poucet/troupe.md
[ -f "$troupe" ] || exit 0

# Les personas qui connaissent déjà le fondateur : familiarité, deux derniers souvenirs, deux derniers changements.
connus=$(awk '
  /^### /{ if (f>0 && n>0) printf "%s (familiarité %s)%s\n", nom, f, buf; nom=substr($0,5); f=0; n=0; buf=""; r=""; next }
  /^## /{ if (f>0 && n>0) printf "%s (familiarité %s)%s\n", nom, f, buf; nom=""; f=0; n=0; buf=""; next }
  nom=="" { next }
  /^- Familiarité/{ f=$NF+0; next }
  /^- Ce qu.il sait/{ r="sait"; v=$0; sub(/^- Ce qu.il sait du fondateur :[[:space:]]*/,"",v); if (v!="") { buf=buf "\n  sait : " v; n++ }; next }
  /^- Ce qui a bougé/{ r="bouge"; next }
  /^[[:space:]]*- /{ v=$0; sub(/^[[:space:]]*- /,"",v); buf=buf "\n  " (r=="bouge" ? "a bougé : " : "sait : ") v; n++ }
  END{ if (f>0 && n>0) printf "%s (familiarité %s)%s\n", nom, f, buf }
' "$troupe" | head -n 40)

liens=$(sed -n '/^| Paire/,$p' "$troupe" | tail -n +3 | head -n 15)

if [ -n "$connus" ] || [ -n "$liens" ]; then
  echo
  echo "Mémoire de la troupe (extrait) :"
  [ -n "$connus" ] && echo "$connus" || echo "Personne ne connaît encore le fondateur."
  [ -n "$liens" ] && { echo "Liens :"; echo "$liens"; }
fi
exit 0
