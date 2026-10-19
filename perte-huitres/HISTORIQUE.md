# Historique du travail (19 oct. 2026)

1. **Photo 1 (14 oct.) : premier comptage.** Seuil automatique : trop de faux positifs dans
   l'herbe et les ombres, abandonné. Pointage manuel sur tuiles zoomées ×2 :
   **110 sûres + 11 incertaines**.
2. **Interface de correction.** Page web où l'utilisateur juge chaque cercle (juste/faux) et
   ajoute les oubliées. Ajout ensuite de la pose de cercles par-dessus un cercle existant,
   parce que certains cercles couvraient 2 ou 3 huîtres.
3. **Correction 1** : 1 rouge faux, 1 orange faux, 23 oubliées → **132**
   (« c'est à 99 % vrai »).
4. **Calibration.** Détecteur réglé sur la vérité : F1 0,74 au mieux, contre 0,91 pour le
   pointage manuel. Le détecteur ne sert plus qu'à proposer des pistes.
5. **Méthode v2 écrite** avant de traiter la photo suivante : zoom ×4, compter les bords de
   coquille, contrôle des tas (`methode/METHODE.md`).
6. **Photo 2 (12 oct.)** : 9 tuiles ×4. Le détecteur propose 19 pistes, toutes rejetées
   (herbe). Résultat : **50 sûres + 5 incertaines**. Non vérifiée.
7. **Correction 2 de la photo 1** : 2 rouges faux, 4 oranges confirmées, 3 oranges fausses,
   26 oubliées → **138**. Les oubliées se concentrent au bord haut-gauche du tas.
   Nouvelle règle : au moins 1 huître par case de 25 px couverte de coquilles foncées.
8. **Photo 3** (tas compact, date inconnue) : huîtres de 10 à 18 px qui se recouvrent.
   Méthode v3 : estimation du tas par densité (case de référence ~40 huîtres / 100×100 px,
   correction de perspective, 7 bandes) → **~289 (217–361)**. Pointage individuel autour du
   tas : **47 sûres + 41 incertaines**. Non vérifiée.
9. **Dossier `perte-huitres/`** créé pour qu'un autre agent produise un rapport.
