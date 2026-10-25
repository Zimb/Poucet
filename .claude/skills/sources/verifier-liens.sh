#!/usr/bin/env bash
# Vérifie que chaque lien http(s) d'un fichier répond. Usage : verifier-liens.sh fichier.md
set -u
[ $# -eq 1 ] || { echo "Usage : $0 fichier.md" >&2; exit 2; }
erreurs=0
for url in $(grep -oE 'https?://[^ )>"`]+' "$1" | sed 's/[.,;:]$//' | sort -u); do
  code=$(curl -sL -o /dev/null -w '%{http_code}' --max-time 15 -A 'Mozilla/5.0' "$url")
  if [ "$code" -ge 200 ] && [ "$code" -lt 400 ]; then echo "ok   $code $url"
  elif [ "$code" = 401 ] || [ "$code" = 403 ] || [ "$code" = 429 ]; then echo "?    $code $url  (accès refusé au robot : vérifier à la main)"
  else echo "ERR  $code $url"; erreurs=$((erreurs+1)); fi
done
exit $(( erreurs > 0 ))
