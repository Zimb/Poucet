# Poucet

Une équipe de personas tirés des contes et des mythes, qui examinent ton idée sous des angles très différents et se passent la balle jusqu'à la valider. Pour un projet perso ou pour un business. Tu tranches, toujours.

## Lancer

1. **Forke** ce dépôt (ou utilise-le comme modèle).
2. **Ouvre-le dans Claude Code** : terminal, appli Claude, ou [claude.ai/code](https://claude.ai/code).
3. **Écris ton idée** dans `IDEE.md`, ou dis-la directement : « J'ai une idée : … ».

Dès ton premier message, même un simple « salut », un persona tiré au sort te répond, sans présentation. L'équipe répond ensuite par de courtes scènes de réunion, jamais deux fois pareilles. Tu réponds, tu tranches ; quand tu dis « validée », Poucet écrit `CHEMIN.md`, ton chemin de réalisation.

## L'équipe

| Persona | Angle |
|---|---|
| **Poucet** | Orchestre les scènes et tient le fil |
| **l'Âne** | Les questions naïves que personne n'ose poser |
| **le Loup** | Ce qui existe déjà |
| **Boucle d'or** | L'utilisateur et son vrai besoin |
| **Brique** | La faisabilité, le MVP, le code |
| **la Fourmi** | Le temps et l'argent |
| **Cassandre** | Les risques, l'échec imaginé d'avance |
| **le Chat Botté** | Le marché (mode business) |
| **Ariane** | La cohérence du fil |
| **Marraine** | Recrute les spécialistes qui manquent |
| **l'Ogre** | La dernière épreuve avant validation |
| **Maui** | La mer, la pêche, le terrain |
| **Tracassin** | L'argent vite et facile |
| **Titania** | L'excellence, la meilleure façon de faire |

Au départ, personne ne se connaît. Au fil des séances, chacun se rapproche de toi, se confie peu à peu, et des affinités se nouent entre eux. Ta troupe ne ressemble à aucune autre.

## Organisation

```
CLAUDE.md              Poucet et les règles de l'équipe
.claude/output-styles/ Le style « Poucet » : on entre en scène, sans présentation
.claude/hooks/         ouverture.sh : tire au sort le persona qui ouvre la séance
.claude/settings.json  Active le style et le hook à chaque démarrage
IDEE.md                Ton idée
.claude/agents/        Un fichier par persona
.claude/skills/        scene, trace, sources, embauche, chemin, evolution
.poucet/trace.json     Le fil de tes décisions (vide au départ)
.poucet/reunions/      Les comptes rendus de scènes
.poucet/registre.md    Qui est dans l'équipe
.poucet/troupe.md      Proximité, confidences et liens de ta troupe (vide au départ)
exemples/poucet/       Un vrai parcours : Poucet cadré par lui-même
exemples/noumea/       Une séance test : les sorties en mer à Nouméa
archives/              Les versions précédentes de la méthode
```

## Ce qu'il faut savoir

- **Coût** : les scènes se jouent dans une seule conversation, sauf les décisions clés (tour à l'aveugle) et les relectures d'Ariane, qui lancent de vrais sous-agents. Les personas tournent sur Sonnet.
- **Fiabilité** : les personas ne rendent pas le modèle plus juste ; ce sont les règles qui le font (sources obligatoires, trace hors de la conversation, relecture à froid, tu tranches). Boucle d'or n'est pas un vrai client : vérifie auprès de vraies personnes.
- **Noms** : personnages du folklore et des mythes, libres de droits.

## Fait / reste à faire

- Fait : équipe de base, skills, trace, vérificateur de liens, exemple complet.
- Reste à faire : tester sur de vraies idées ; mesurer Poucet contre Claude seul (même idée, jugée à l'aveugle) ; voir `.poucet/issues.md`.
