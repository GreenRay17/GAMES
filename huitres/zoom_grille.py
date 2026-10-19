# Usage: python3 zoom_grille.py x0 y0 x1 y1 sortie.jpg photo.jpg  -> crop zoome x4 avec grille de coordonnees tous les 50 px
import cv2,sys
img=cv2.imread(sys.argv[6] if len(sys.argv)>6 else 'photo.jpg')
x0,y0,x1,y1=map(int,sys.argv[1:5])
c=img[y0:y1,x0:x1].copy()
Z=4; c=cv2.resize(c,None,fx=Z,fy=Z,interpolation=cv2.INTER_CUBIC)
for gx in range((x0//50+1)*50,x1,50):
    X=(gx-x0)*Z; cv2.line(c,(X,0),(X,c.shape[0]),(255,255,0),1); cv2.putText(c,str(gx),(X+2,14),0,0.45,(255,255,0),1)
for gy in range((y0//50+1)*50,y1,50):
    Y=(gy-y0)*Z; cv2.line(c,(0,Y),(c.shape[1],Y),(255,255,0),1); cv2.putText(c,str(gy),(2,Y-2),0,0.45,(255,255,0),1)
cv2.imwrite(sys.argv[5],c)
