---
name: embauche
description: Procédure de Marraine pour recruter un persona - fiche courte, épreuve d'embauche, évaluation, correction - et pour corriger la fiche d'un persona recadré. À utiliser quand un besoin n'est couvert par aucun persona.
---

# Recruter

1. **Vérifie le besoin.** Lis `.poucet/registre.md` et les fiches : si un persona couvre déjà l'angle, propose-le au lieu de recruter.
2. **Écris la fiche** dans `.claude/agents/<nom>.md`, sur le modèle des fiches existantes : frontmatter (`name`, `description` qui dit le métier en clair et quand l'appeler, `tools` au strict nécessaire, `model: sonnet`), puis l'angle, les obsessions, la voix, ce qu'il ne fait pas, les règles communes, et une section « Ce qui a bougé » vide (skill `evolution`). Moins de 30 lignes. Un archétype appuyé et une façon de parler qu'aucun autre persona n'a (voir « Les voix » dans `CLAUDE.md`, à compléter) ; jamais de phrase fétiche. Nom tiré des contes, fables ou mythes.
3. **Conçois l'épreuve** : une vraie petite tâche du projet, 3 à 5 critères vérifiables. Garde la grille d'évaluation **hors du dépôt** pendant l'épreuve (le candidat lit le dépôt).
4. **Fais-la passer** : la session principale lance le candidat comme sous-agent.
5. **Évalue** critère par critère, avec la phrase qui prouve. Un échec : corrige la fiche sur ce point seulement et repasse. Deux échecs : dis au fondateur que le besoin est peut-être mal posé.
6. **Le fondateur embauche.** Ajoute alors une ligne au registre (nom, angle, fichier, date, raison) et une étape à la trace.

# Entretien annuel

Quand le fondateur a dû recadrer un persona : lis sa fiche, trouve ce qui manquait (limite floue, décision non citée, critère de fin absent) et propose une correction précise. Ne réécris pas tout.
