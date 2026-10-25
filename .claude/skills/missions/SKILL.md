---
name: missions
description: Donne à chaque persona sa mission pour la séance, liée à son angle, suit sa satisfaction de 0 à 3 dans .poucet/trace.json, et mesure la viabilité de l'idée - satisfaire le plus de personas possible. À utiliser quand l'idée arrive, après chaque scène qui fait avancer une mission, et avant la validation.
---

# Les missions

Chaque persona a une mission, écrite dans sa fiche et liée à son angle. Une idée est viable quand elle satisfait le plus de personas possible.

## Au départ

Quand l'idée et le mode sont connus, adapte chaque mission à cette idée, en une phrase, dans `missions` de `.poucet/trace.json` :

```json
{ "persona": "tracassin", "mission": "…adaptée à l'idée…", "poids": 1, "satisfaction": 0, "pourquoi": "", "sans_objet": false }
```

Donne aussi à chaque mission un poids, 1 ou 2, selon le mode et l'idée : en mode « pour moi », la Fourmi, Boucle d'or et Tracassin (l'intérêt personnel) pèsent 2 ; en mode business, le Chat Botté, Tracassin et le Loup pèsent 2. Le fondateur peut changer les poids, et ça va dans la trace.

Si l'angle d'un persona ne s'applique pas à l'idée, prends la variante de repli de sa fiche : un projet non lucratif donne à Tracassin un intérêt personnel à trouver, un projet qui ne sert qu'à une personne donne au Joueur de flûte une phrase pour le dire. Ne marque `sans_objet` que si aucune variante n'a de sens.

## En cours

Après une scène qui fait avancer une mission, mets à jour sa satisfaction : **0** rien n'est fait · **1** entamée · **2** en grande partie · **3** accomplie. Écris le pourquoi avec ce qui le prouve (une source, une décision, un essai). La satisfaction peut redescendre si une décision défait ce qui était acquis.

Dans la scène, ça ne s'annonce pas en chiffres : ça se sent. Un persona satisfait lâche du lest ; un persona frustré insiste, marchande, ou propose un compromis pour faire avancer sa mission. Les missions se tirent parfois dans des sens opposés (Tracassin et Titania, la Fourmi et le Chat Botté) : c'est là que l'idée trouve son équilibre.

## Avant la validation

Ariane dresse le tableau des missions. L'idée est prête pour l'Ogre quand aucune mission active n'est à 0, et que les missions à 2 ou plus font au moins les deux tiers du poids total. Sinon, Poucet propose la scène qui fera monter les missions les plus basses. Le fondateur peut passer outre : il tranche, et la trace le note.
