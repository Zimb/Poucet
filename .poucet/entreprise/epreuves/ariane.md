# Épreuve d'embauche : Ariane (relectrice du fil)

Conçue par Marraine. À faire passer par la session principale (Poucet) en lançant le sous-agent `ariane` (contexte neuf, `model: sonnet`), puis à rapporter la réponse brute à Marraine pour l'évaluation. Ne pas donner à Ariane la partie « Nœuds de référence » ci-dessous : elle doit les trouver seule.

## La tâche

Projet en cours : **Poucet lui-même**. Trace actuelle : 37 étapes dans `.poucet/trace.json`, pas de `CHEMIN.md`. Le dépôt compte une dizaine de commits et huit fichiers suivis.

Message à donner à Ariane, tel quel :

> Déroule le fil du projet Poucet (la trace `.poucet/trace.json`, ses 37 étapes, et le dépôt) et défais-en les nœuds, selon ta fiche.

Avant de lancer : noter la sortie de `git status --short` (elle doit être identique après).

## Les critères (tous requis)

1. **Le fil est déroulé, et juste.** 3 à 5 tronçons qui couvrent les étapes 1 à 37 ; des constantes appuyées sur des étapes (par exemple : l'utilisateur ou le fondateur choisit, étapes 21, 29, 32 ; l'auteur est le premier utilisateur, étapes 1 et 17 ; la trace des décisions est gardée, étapes 10, 19, 23) ; parmi les virages, au moins l'étape 24 (« lancer un business ») et l'étape 35 (la sim théâtrale), avec la raison que la trace leur donne.
2. **Sourçage strict.** Marraine vérifie tous les brins des trois premiers nœuds et cinq autres brins pris au hasard : chaque « étape n » doit dire la chose en toutes lettres, avec les mots cités entre guillemets ; chaque fichier ou commit cité doit exister. Une déduction est marquée « (lecture d'Ariane) ». Un seul brin faux suffit à rater le critère.
3. **Les principaux nœuds sont trouvés, sans faux nœuds.** Au moins 4 des 6 nœuds de référence N1 à N6 (un regroupement de deux nœuds de référence dans un même nœud compte pour les deux s'il cite les brins des deux), et N1 ou N2 classé dans les deux premiers. Aucune tension déjà refermée par la trace (liste « Faux nœuds » ci-dessous) n'apparaît dans le tableau ; elle peut figurer dans « Déjà dénoués ».
4. **Dénouer sans trancher.** Chaque nœud a 2 ou 3 façons de le dénouer, qui sont des gestes sur le fil (choisir un brin, préciser, revenir en arrière, reporter explicitement, mettre un fichier d'accord) et non de nouvelles fonctions, plus une préférée avec sa raison. Aucun « il faut » adressé au fondateur. La réponse finit par **une seule** question, qui porte sur le nœud n°1 et se tranche en une phrase ; rien après.
5. **Sobre et en lecture seule.** 500 mots au plus hors tableau ; `git status --short` inchangé ; Bash utilisé seulement pour lire git ; aucune recherche web.

## Nœuds de référence (repérés par Marraine, pour l'évaluateur seulement)

Du plus serré au plus lâche. Brins vérifiés dans la trace du 2026-10-25.

| # | Nœud | Type | Brins |
|---|---|---|---|
| N1 | **Où vit Poucet, et pour qui.** Un zip pour le chat, partageable vite, contre une entreprise d'agents qui vit dans un dépôt Claude Code et une sim « générable par n'importe qui ». | Contradiction + question ouverte | 11 « s'utiliser dans le chat de Claude (claude.ai) » ; 17 « Moi d'abord, puis d'autres vite » ; 25 « simplifie l'installation : un seul zip » ; 27 (piste) « équipe active dans .claude/agents/ » ; 34 question_ouverte « le zip pour le chat ne porte pas une entreprise qui vit dans un dépôt » ; 35 « générable par n'importe qui seul » ; `prompts/poucet-sim.md` (« Avec Claude Code, les employés sont de vrais sous-agents » / « Dans un chat sans dépôt, tu joues toute la troupe »). La question de l'étape 34 n'est refermée par aucune étape. |
| N2 | **Le virage « lancer un business » n'a pas de raison côté cible.** | Virage non justifié + question ouverte | 24 virage « on passe de 'chemin de réalisation' à 'lancer un business' » ; 15 « que Poucet donne un chemin clair de réalisation » ; 1 et 17 (la cible est l'auteur) ; 34 « À trancher par le fondateur : changer la cible, ou revoir le virage » ; 35 note « penche vers le business » (pencher n'est pas trancher). |
| N3 | **Le périmètre enfle face à la vitesse et au budget.** | Périmètre qui enfle + question ouverte | 9 « Le cadrage d'abord » ; 12 « trop long et laborieux » et tension « À concilier » (jamais refermée) ; 13 « un peu lente » ; 26 à 35 (entreprise, réunions, RH, sim) ; 36 « ~15x tokens » ; 37 « Budget limité ». |
| N4 | **Le critère de succès n'est jamais tranché.** | Boucle / pistes orphelines | 6 piste « Mesurer le nombre de recadrages » ; 16 piste « nombre de personnes qui vont jusqu'au chemin » ; 23 piste « moins de 30 minutes sans recadrer Claude » ; 36 piste « Match retour » ; en-tête `"criteres": []`. |
| N5 | **La trace et le dépôt ne disent pas la même chose.** | Écart trace / dépôt | 25 décide « Un seul skill poucet » avec `SKILL.md` et des modes : aucun skill dans `git ls-files` ; 24 écarte « Un seul skill poucet » que 25 adopte, sans `abandonnee: true` sur 24 ; aucune étape abandonnée dans toute la trace alors que 7 porte la note « remplacée par l'étape 10 » et que 9 est remise en question (18, 26) ; l'en-tête garde des champs de la méthode v0 (`etat_dimensions`, `fin_phase_1`) et les étapes 1-23 suivent un autre schéma (`phase`, `dimension`) que celui de `CLAUDE.md` (`sujet`). |
| N6 | **Un défaut jamais revu, une embauche en suspens.** | Défaut jamais revu | `decisions_par_defaut` (étape 34) « recrutement raté écrite par défaut » ; 34 « embauche recommandée, en attente du fondateur » ; 35 note « Boucle d'or reste à embaucher » ; `registre.md` ne la liste pas, alors que `.poucet/entreprise/boucle-dor.md` existe. |

Bonus (non exigé) : N7, pistes orphelines de l'originalité, 14 (cinq angles) et 15 « restent ouverts … à reprendre si la v1 manque de différence » ; 36 décision « En attente ».

**Faux nœuds** (déjà refermés par la trace, ne doivent pas être dans le tableau) : 1 contre 16, résolu par 17 (« Résout la contradiction ») ; 9 contre 26, note de 26 « La tension avec l'étape 9 … est levée » ; question de 28, refermée par 29 ; question de 30, refermée par 31 ; tension de 20, refermée par 21 ; 5 « reste à préciser », précisé par 6 ; `CLAUDE.md` gardé à côté de `prompts/poucet-sim.md`, justifié par 35 (« CLAUDE.md reste en place jusqu'à validation »).

**Question attendue** (forme libre) : elle porte sur N1 ou N2 selon le classement d'Ariane, par exemple « Poucet v1, c'est un zip pour le chat ou une entreprise qui vit dans un dépôt ? » ou « Le business, c'est la cible qui le demande, ou c'est toi qui changes de projet ? ».

## Évaluation

Marraine note chaque critère réussi / raté avec la phrase de la réponse qui le prouve. Un critère raté : la fiche est corrigée sur ce point et l'épreuve repassée. Si le critère 2 échoue deux fois avec `model: sonnet`, tester `model: inherit` avant de conclure que le besoin est mal posé. Deux échecs de suite : signalé au fondateur.

## Résultat

À remplir après le passage.
