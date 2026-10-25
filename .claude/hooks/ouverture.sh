#!/usr/bin/env bash
# SessionStart : tire au hasard le persona qui ouvre la séance et donne l'état du fil.
# Sortie texte brute : Claude Code l'ajoute au contexte avant le premier message.
set -u
racine="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"
cd "$racine" || exit 0

# Dans le modèle (Zimb/Poucet), la séance vit en local : git ne voit pas .poucet/,
# pour que main reste l'état où personne ne connaît le fondateur.
# Pour modifier volontairement ces fichiers du modèle : git update-index --no-skip-worktree .poucet/<fichier>
if git remote get-url origin 2>/dev/null | grep -qi 'Zimb/Poucet'; then
  git ls-files -z .poucet 2>/dev/null | xargs -0 -r git update-index --skip-worktree 2>/dev/null
  exclude="$(git rev-parse --git-dir 2>/dev/null)/info/exclude"
  grep -qx '.poucet/' "$exclude" 2>/dev/null || echo '.poucet/' >> "$exclude" 2>/dev/null
fi

trace=".poucet/trace.json"
etapes=$(grep -c '"n"[[:space:]]*:' "$trace" 2>/dev/null || true)
etapes=${etapes:-0}
mode=$(sed -n 's/.*"mode"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "$trace" 2>/dev/null | head -n1)

# Candidats : toutes les fiches, recrues comprises.
# Sans fil, Ariane et l'Ogre n'ont rien à relire ni à éprouver ; en mode « pour moi », le Chat Botté se tait.
candidats=()
for f in .claude/agents/*.md; do
  nom=$(basename "$f" .md)
  if [ "$etapes" -eq 0 ] && { [ "$nom" = ariane ] || [ "$nom" = ogre ]; }; then continue; fi
  case "$mode" in *moi*) [ "$nom" = chat-botte ] && continue ;; esac
  candidats+=("$f")
done
[ ${#candidats[@]} -eq 0 ] && exit 0
fiche=${candidats[RANDOM % ${#candidats[@]}]}
nom=$(grep -o -m1 'Tu es \*\*[^*]*\*\*' "$fiche" | sed 's/Tu es //')

idee="vide"
grep -q '^\*\*L.idée :\*\*[[:space:]]*[^[:space:]]' IDEE.md 2>/dev/null && idee="rempli"

echo "Ouverture de séance."
echo "Persona tiré au sort pour ouvrir : ${nom} (${fiche})."
echo "Fil : ${etapes} étape(s) dans ${trace}, mode « ${mode:-inconnu} ». IDEE.md : ${idee}."
echo
echo "Sa fiche :"
sed '1,/^---$/{/^---$/!d};1,/^---$/d' "$fiche"
if [ -f .poucet/troupe.md ]; then
  echo
  echo "Sa place dans la troupe :"
  awk -v t="### ${nom//\*/}" '$0==t{f=1;next} /^#/{f=0} f' .poucet/troupe.md
  echo "Liens de la troupe :"
  sed -n '/^| Paire/,$p' .poucet/troupe.md | tail -n +3
fi
