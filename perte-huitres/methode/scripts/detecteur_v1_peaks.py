# Detecteur automatique v1 : seuil de gris + distance transform + maxima locaux. Usage: python3 detecteur_v1_peaks.py photo.jpg seuil distance sortie.jpg
import cv2, numpy as np, sys
from skimage.feature import peak_local_max
img=cv2.imread(sys.argv[1]); H,W=img.shape[:2]
y0,y1=950,1920
g=cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
hsv=cv2.cvtColor(img,cv2.COLOR_BGR2HSV)
mask=(g<int(sys.argv[2])).astype(np.uint8)*255
mask[:y0]=0; mask[y1:]=0
grass=((hsv[...,0]>30)&(hsv[...,0]<90)&(hsv[...,1]>50))
mask[grass]=0
mask=cv2.morphologyEx(mask,cv2.MORPH_OPEN,np.ones((3,3),np.uint8))
mask=cv2.morphologyEx(mask,cv2.MORPH_CLOSE,np.ones((5,5),np.uint8))
dt=cv2.distanceTransform(mask,cv2.DIST_L2,5)
pk=peak_local_max(dt,min_distance=int(sys.argv[3]),threshold_abs=5)
res=[]
for y,x in pk:
    r=dt[y,x]
    res.append((x,y,r))
sure=[p for p in res if p[2]>=8]; unsure=[p for p in res if p[2]<8]
print(len(sure),len(unsure))
vis=img.copy()
for x,y,r in sure: cv2.circle(vis,(int(x),int(y)),int(max(r*1.8,16)),(0,0,255),3)
for x,y,r in unsure: cv2.circle(vis,(int(x),int(y)),int(max(r*1.8,14)),(0,170,255),3)
cv2.imwrite(sys.argv[4],vis)
np.save(sys.argv[4]+'.npy',np.array(res))
