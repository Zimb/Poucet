---
name: trace
description: Note une décision du fondateur dans .poucet/trace.json avec sa raison, les options écartées et les pistes, ou marque un retour en arrière. À utiliser chaque fois qu'une décision tombe, en discutant comme en codant.
---

# Tenir le fil

Ajoute une étape à `.poucet/trace.json` (ne réécris jamais les anciennes, sauf pour les marquer) :

```json
{
  "n": 1,
  "sujet": "angle | probleme | cible | mvp | technique | prix | nom | risques | …",
  "decision": "ce que le fondateur a décidé, en une phrase",
  "raison": "pourquoi, avec ses mots",
  "ecartees": [{ "option": "…", "raison": "…" }],
  "pistes": [{ "piste": "…", "raison": "…" }],
  "abandonnee": false
}
```

- **Décision par défaut** (« décide pour moi ») : ajoute-la aussi à `decisions_par_defaut`, avec l'étape.
- **Question laissée ouverte** : champ `question_ouverte` ; la refermer plus tard par une étape qui la cite.
- **Retour en arrière** : les étapes après le point de retour passent à `abandonnee: true`, avec `raison_abandon`.
- **Décision remplacée** : `remplacee_par: { "etape": n, "sur": "ce qui change" }`.
- **Critère de succès** : dans `criteres`, mesurable (« 5 personnes sur 10 ont déjà payé pour une alternative »).
- Ne cite que ce que le fondateur a dit ; une déduction de l'équipe va dans `pistes`, pas dans `decision`.
- Ne l'annonce pas à chaque fois : c'est un carnet, pas un rituel.
