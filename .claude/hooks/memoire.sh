#!/usr/bin/env bash
# Stop : Poucet tient la mémoire de la troupe.
# Dans un fork, il committe et pousse .poucet/ sur main à chaque fin de réponse,
# et rappelle le skill evolution quand la troupe n'a pas bougé depuis trois réponses.
# Dans le modèle (Zimb/Poucet), il ne fait rien : main reste l'état où personne ne se connaît.
set -u
racine="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"
cd "$racine" || exit 0
entree=$(cat)
git remote get-url origin 2>/dev/null | grep -qi 'Zimb/Poucet' && exit 0

compteur="$(git rev-parse --git-dir 2>/dev/null)/poucet-sans-memoire"
n=$(cat "$compteur" 2>/dev/null || echo 0)

if git diff --quiet HEAD -- .poucet/troupe.md 2>/dev/null; then
  n=$((n + 1))
else
  n=0
fi

if [ -n "$(git status --porcelain -- .poucet 2>/dev/null)" ]; then
  git add .poucet && git commit -q -m "Poucet : mémoire de la troupe" >/dev/null 2>&1
  { git fetch -q origin main && git merge -q --no-edit origin/main && git push -q origin HEAD:main; } >/dev/null 2>&1 || true
fi

if [ "$n" -ge 3 ] && ! printf '%s' "$entree" | grep -q '"stop_hook_active"[[:space:]]*:[[:space:]]*true'; then
  echo 0 > "$compteur"
  echo '{"decision":"block","reason":"Poucet : la troupe n'\''a rien noté depuis trois réponses. Applique en silence le skill evolution sur les dernières scènes. Si rien n'\''a vraiment bougé, ne change rien. Termine sans écrire un mot de plus."}'
  exit 0
fi
echo "$n" > "$compteur"
exit 0
