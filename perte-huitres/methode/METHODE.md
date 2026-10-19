# Méthode de comptage des huîtres sur photo

## Règles du jeu
- 1 cercle = 1 huître **entière** : foncée (brun/gris/noir), bombée, avec une ombre propre.
- Ne comptent pas : débris et morceaux blancs, cailloux, mottes d'herbe, ombres.
- **Rouge** = je suis sûr. **Orange/jaune** = je doute.
- Seulement le chemin devant soi ; le fond trop lointain pour être lu est signalé à part, pas compté.

## Ce que m'a appris la photo du 14 oct. (corrigée par l'utilisateur)

| | |
|---|---|
| Mon 1er comptage | 110 rouges + 11 oranges |
| Vérité après 2e correction | **138** (108 rouges + 4 oranges validées + 26 oubliées) |
| Précision de mes rouges | 108/110 = **98 %** → quand je dis « sûr », c'est fiable |
| Précision de mes oranges | 4 vraies / 3 fausses / 4 non jugées → ~50/50, l'orange a du sens |
| Rappel | 112/138 = **81 %** → **mon défaut : j'en oublie** |
| Détecteur automatique seul | F1 0.74 : trop de faux positifs (herbe, ombres) |

Où étaient les oubliées : presque toutes dans **le tas dense**, surtout son **bord haut-gauche**
(6 oubliées dans un carré de 50 px), où 2–3 huîtres se chevauchent et où j'avais mis un seul
cercle. Plus 1 isolée dans l'herbe à gauche.
Cause : tuiles trop grandes, zoom ×2 seulement. Règle : dans un tas, compter **au moins
1 huître par carré de grille de 25 px** couvert de coquilles foncées, puis vérifier.

## Procédure

1. **Cadrer** : repérer sur la photo entière la zone où sont les huîtres (coordonnées en pixels
   réels de l'image) et les zones de bord (herbe) à vérifier quand même.
2. **Découper** en tuiles d'environ 300 × 200 px, chacune zoomée **×4** avec une grille de
   coordonnées tous les 50 px (`zoom_grille.py`). Les tuiles se chevauchent un peu ;
   un point déjà pris dans la tuile voisine n'est pas recompté.
3. **Pointer** dans chaque tuile, ligne de grille par ligne de grille :
   - compter les **bords de coquille** (lèvre, ombre portée), pas les taches sombres ;
   - une tache plus grande qu'une huître isolée = probablement 2 ou 3 → les pointer séparément ;
   - noter chaque point rouge ou orange avec ses coordonnées.
4. **Deuxième passe automatique** : `candidats.py` avec mes points. Chaque candidat
   loin (> 22 px) de mes cercles est revu à l'œil en ×4 → rouge, orange ou rejeté.
   Le détecteur ne compte jamais à ma place.
5. **Contrôle de vraisemblance** : comparer la taille de chaque tas au nombre de cercles dedans.
   Comme je sous-compte d'environ 15 % dans les tas, je repasse les tuiles des tas avant de rendre.
6. **Dessiner** les cercles sur l'image (rouge / orange, taille adaptée à la profondeur) et
   afficher le total.
7. **Faire vérifier** : interface de correction (juger, ajouter, supprimer) ; je lis tes
   corrections et j'ajoute la leçon à ce fichier.

## Résultat rendu
- Image annotée + total : `X rouges (sûres) + Y oranges (incertaines)`.
- Une fourchette honnête : minimum = rouges, maximum = rouges + oranges.
- Ce que j'ai volontairement laissé de côté (fond lointain, cas ambigus).

## Tas trop compact pour être pointé (photo 3)

Quand une huître fait moins de ~15 px et que les coquilles se recouvrent, les pointer une à une
est du hasard. Je passe alors en **estimation par densité** :
1. Délimiter le tas (polygone violet) et le découper en bandes horizontales de 50 px.
2. Compter finement une case échantillon de 100 × 100 px (zoom ×8, grille 12,5 px) :
   photo 3 → ~40 huîtres pour 100 × 100 px là où une huître fait ~17 px.
3. Corriger par la perspective : densité ∝ 1 / taille², la taille d'une huître grandissant
   linéairement vers le bas de l'image.
4. Par bande : surface × taux de couverture (sol visible, coquilles blanches exclus) × densité.
5. Rendre une fourchette ±25 %, et pointer normalement tout ce qui est hors du tas.
