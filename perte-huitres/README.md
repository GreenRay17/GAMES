# Perte d'huîtres — dossier de preuves et de données

Comptage, à partir de photos, des **huîtres entières** laissées sur un chemin de digue entre
deux bassins (Claude, octobre 2026). Ce dossier est fait pour qu'un autre agent puisse
l'analyser et en tirer un rapport sans relire la conversation d'origine.

## Chiffres clés

| Photo | Date | Statut | Huîtres retenues | Fourchette |
|---|---|---|---|---|
| photo1 | 14 oct. 2026, 16:29 | **vérifiée par un humain** | **138** | 138 (≈ 99 % juste selon l'utilisateur) |
| photo2 | 12 oct. 2026, 17:45 | non vérifiée | 50 | 50 – 55 |
| photo3 | date inconnue | non vérifiée | ~336 (47 pointées + ~289 estimées dans le tas) | 264 – 449 |

Les trois photos montrent des scènes différentes du même type de chemin. Rien ne prouve
qu'elles montrent le même endroit, donc **ne pas additionner** les totaux comme s'il s'agissait
d'un seul stock sans le signaler.

## Arborescence

```
perte-huitres/
├── README.md                     ← ce fichier
├── HISTORIQUE.md                 ← déroulé chronologique du travail et des corrections
├── photos/
│   ├── originales/               ← captures d'écran téléphone, telles que reçues (preuves)
│   └── annotees/                 ← mêmes images avec les cercles de comptage
├── donnees/
│   ├── comptages.json            ← SOURCE PRINCIPALE : tous les points, statuts, totaux
│   ├── resume.csv                ← une ligne par photo
│   ├── calibration_detecteur.json← fiabilité du détecteur auto vs vérité terrain
│   ├── verifications/            ← exports bruts des corrections humaines
│   └── points_photo*_source.py   ← listes de points brutes (archives)
├── methode/
│   ├── METHODE.md                ← procédure de comptage et leçons apprises
│   ├── zoom_grille.py, candidats.py
│   └── scripts/                  ← scripts d'analyse archivés
└── interface/
    └── controle-huitres_template.html ← modèle de la page de correction (sans photo)
```

## Lire `donnees/comptages.json`

- `photos[]` : un objet par photo avec `original`, `annotees`, `statut`, `comptage_claude`,
  `resultat_verifie` (photo1 seulement), `fourchette`, `note`, `points`.
- `points[]` : `{id, x, y, claude, verification}`
  - `x, y` : pixels dans l'**image originale** (1080 × 2408, capture d'écran de téléphone ;
    la photo occupe une bande au milieu, entourée de barres noires et de l'interface).
  - `claude` : `sure` (cercle rouge), `incertaine` (cercle orange), `oubliee` (ajoutée par l'humain).
  - `verification` : `confirmee`, `rejetee`, `ajoutee_par_humain`, `non_jugee`.
  - Une huître de photo1 compte dans le total vérifié si :
    (`claude`=`sure` et `verification`≠`rejetee`) ou `verification` ∈ {`confirmee`, `ajoutee_par_humain`}.
- `photos[2].tas` : polygone du tas compact de la photo 3 et estimation par bandes
  (surface × couverture × densité corrigée de la perspective).
- `fiabilite_claude` : précision et rappel mesurés sur la photo 1.

Les fichiers de `verifications/` utilisent un repère **recadré** (y décalé, voir le champ
`repere_coordonnees`). `comptages.json` est déjà ramené au repère de l'image originale.

## Fiabilité, à citer dans un rapport

- Cercles rouges de Claude : **98 %** justes (108/110 sur photo 1).
- Cercles orange : environ 1 sur 2 est vraiment une huître.
- Claude **sous-compte** : rappel de **81 %** (112/138). Les oublis sont surtout dans les tas,
  là où des huîtres se chevauchent.
- Détecteur automatique seul : F1 0,74, à ne pas utiliser pour compter.
- Photo 3 : le tas est une **estimation à ±25 %**, pas un comptage. Beaucoup de demi-coquilles
  blanches (débris) devant le tas ne sont pas comptées, et la limite est parfois floue.
- Photos 2 et 3 : non vérifiées. Avec le biais mesuré sur la photo 1, le vrai nombre est
  plutôt au-dessus du chiffre « sûres » que en dessous.

## Pistes pour le rapport

- Une section par photo : photo originale, photo annotée, total, fourchette, statut.
- Le tableau de fiabilité ci-dessus, et l'avant/après de la photo 1
  (`photo1_..._comptage-claude-initial.jpg` puis `photo1_..._comptage-corrige.jpg`).
- Une carte des points depuis `comptages.json` (scatter x/y, couleur par statut) montre où
  se concentrent les pertes et les oublis.
- Rester clair sur ce qui est mesuré (photo 1), compté sans vérification (photo 2) et estimé (photo 3).

## Liens de correction (privés, propriétaire seulement)

- photo1 : https://claude.ai/artifact/EEcMQMU7q6Cr5jmkBDJM8F
- photo2 : https://claude.ai/artifact/Kjq6cUqhCWgSWSDZwgxj3U
- photo3 : https://claude.ai/artifact/S576XyW4Km4k1MG2sn4vQV

Les corrections y sont stockées dans la collection `review`, document `main`.
