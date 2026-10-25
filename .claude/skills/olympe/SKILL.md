---
name: olympe
description: Boucle de perfectionnement de la troupe, chapeautée par Zeus - le hook olympe.sh note les écarts mesurables (réplique trop longue, scène écrite avant un outil), Zeus les juge quand ils se répètent, la correction mineure s'applique seule, la majeure passe par le fondateur. À utiliser quand le hook convoque Zeus, ou quand le fondateur demande où en est la troupe.
---

# L'Olympe

Le hook mesure, Zeus juge, Marraine et Brique réparent, le fondateur garde les grandes décisions.

1. **Noter.** `olympe.sh` (Stop) écrit chaque écart dans `.poucet/olympe.jsonl`, sans rien juger. `en-scene.sh` rappelle les derniers écarts au tour suivant : la troupe se corrige d'elle-même.
2. **Convoquer.** Le même écart trois fois pour le même persona : le hook bloque une fois. Lance alors Zeus en sous-agent, avec une consigne complète : objectif (« trouve pourquoi cet écart revient »), limites (lecture seule), sources (`.poucet/olympe.jsonl`, la fiche du persona, `CLAUDE.md`), format de retour (cause en une phrase, correction proposée avec fichier et texte exact, mineure ou majeure).
3. **Trancher la taille.**
   - *Mineure* : la forme, sans toucher à l'identité. Mesure de longueur, moments d'entrée, consigne de format, coquille, incohérence entre fichiers. Marraine (fiche) ou Brique (hook, skill) l'applique sans attendre, et l'écrit dans `.poucet/olympe.jsonl` avec `"revue": "appliquée"` et le changement.
   - *Majeure* : l'angle, la personnalité, la mission, le droit de dire non, un persona en plus ou en moins, une règle d'or. Zeus la présente au fondateur en une réplique ; rien ne change sans son accord.
4. **Rendre compte.** Une ligne de Zeus, dans la scène suivante : ce qui a changé, et pourquoi. Pas de rapport.
5. **Revue d'ensemble.** Quand le fondateur la demande, ou après une recrue : Zeus audite toute la troupe (fiches, hooks, skills, `CLAUDE.md`, `README.md`) et classe ce qu'il trouve en mineur et majeur, selon la même règle.

Un hook ne juge jamais : il compte. Le jugement revient à un vrai sous-agent, et seulement quand un écart se répète, parce qu'un sous-agent coûte cher (hypothèse d'ordre de grandeur : Anthropic mesure environ quinze fois plus de jetons pour un système multi-agent que pour une conversation, [source](https://www.anthropic.com/engineering/multi-agent-research-system)).
