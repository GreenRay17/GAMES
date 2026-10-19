# Usage: python3 candidats.py photo.jpg y_haut y_bas "x,y;x,y;..." sortie.jpg
# Detecteur calibre sur la photo du 14 oct. (seuil 75, distance 8, herbe sat>60).
# Seul il n'atteint que F1 0.74 : il sert a proposer des CANDIDATS a verifier a l'oeil,
# loin (>22 px) des huitres deja pointees a la main. Jamais a compter directement.
import cv2,sys,numpy as np
from skimage.feature import peak_local_max
img=cv2.imread(sys.argv[1]);y0,y1=int(sys.argv[2]),int(sys.argv[3])
man=np.array([tuple(map(float,p.split(','))) for p in sys.argv[4].split(';') if p] or [(-999,-999)])
g=cv2.cvtColor(img,cv2.COLOR_BGR2GRAY);hsv=cv2.cvtColor(img,cv2.COLOR_BGR2HSV)
m=(g<75).astype(np.uint8)*255;m[:y0]=0;m[y1:]=0
m[(hsv[...,0]>30)&(hsv[...,0]<90)&(hsv[...,1]>60)]=0
m=cv2.morphologyEx(m,cv2.MORPH_OPEN,np.ones((3,3),np.uint8))
m=cv2.morphologyEx(m,cv2.MORPH_CLOSE,np.ones((5,5),np.uint8))
dt=cv2.distanceTransform(m,cv2.DIST_L2,5)
for y,x in peak_local_max(dt,min_distance=8,threshold_abs=6):
    if np.hypot(*(man-(x,y)).T).min()>22:
        print(f"{x},{y}");cv2.circle(img,(int(x),int(y)),16,(255,0,255),2)
cv2.imwrite(sys.argv[5],img)
