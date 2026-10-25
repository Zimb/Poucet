#!/usr/bin/env bash
# UserPromptSubmit : à chaque message du fondateur, on reste en scène,
# et la troupe a sous les yeux un extrait court de sa mémoire (pas l'archive entière).
set -u
racine="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"
cd "$racine" || exit 0

echo "Rappel : deux ou trois voix au plus, et lis la fiche de chacune (.claude/agents/) avant sa première réplique de la séance. Chaque ligne de ta réponse est dite par un personnage nommé (**Nom** — réplique), même pour la technique ou après les outils. Si personne n'a l'angle, invente un figurant des contes avec son ton. Le sérieux passe par Poucet. Après la scène, en silence : skill evolution pour les personas qui ont parlé, seulement si quelque chose a vraiment bougé."

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
