# Archive : script tel qu'utilise. Il lisait data.json (points de la photo 1, y decale de -900) ;
# ces points sont maintenant dans ../../donnees/comptages.json (photo1, coordonnees originales).
import cv2,json,numpy as np
from skimage.feature import peak_local_max
d=json.load(open('data.json'))
added=[(108,391),(1011,876),(551,404),(414,387),(398,266),(404,215),(357,152),(591,232),(387,134),(358,167),(344,202),(359,221),(308,338),(352,388),(352,416),(393,348),(357,352),(346,366),(405,366),(354,451),(290,570),(653,376),(640,441)]
gt=[(m['x'],m['y']+900) for m in d['marks'] if m['k']=='sure' and m['id']!='r6']+[(x,y+900) for x,y in added]
gt=np.array(gt,float)
img=cv2.imread('../../photos/originales/photo1_2026-10-14_16h29.jpg')
g=cv2.cvtColor(img,cv2.COLOR_BGR2GRAY);hsv=cv2.cvtColor(img,cv2.COLOR_BGR2HSV)
def detect(th,md,ta,sat):
    m=(g<th).astype(np.uint8)*255; m[:950]=0; m[1920:]=0
    m[(hsv[...,0]>30)&(hsv[...,0]<90)&(hsv[...,1]>sat)]=0
    m=cv2.morphologyEx(m,cv2.MORPH_OPEN,np.ones((3,3),np.uint8))
    m=cv2.morphologyEx(m,cv2.MORPH_CLOSE,np.ones((5,5),np.uint8))
    dt=cv2.distanceTransform(m,cv2.DIST_L2,5)
    pk=peak_local_max(dt,min_distance=md,threshold_abs=ta)
    return np.array([(x,y) for y,x in pk],float)
def score(p,tol=20):
    used=set();tp=0
    for q in gt:
        if len(p)==0:break
        dd=np.hypot(*(p-q).T);dd[list(used)]=1e9;i=dd.argmin()
        if dd[i]<tol:used.add(i);tp+=1
    prec=tp/max(len(p),1);rec=tp/len(gt);return 2*prec*rec/(prec+rec+1e-9),prec,rec,len(p)
best=[]
for th in (75,85,95,105,115):
  for md in (8,10,12,14,16):
    for ta in (4,6,8,10):
      for sat in (40,60,80):
        f,p,r,n=score(detect(th,md,ta,sat));best.append((f,p,r,n,th,md,ta,sat))
best.sort(reverse=True)
for b in best[:5]:print("F1 %.2f prec %.2f rec %.2f n=%d | seuil=%d dist=%d min=%d sat=%d"%b)
print("moi (manuel v1): ",score(np.array([(m['x'],m['y']+900) for m in d['marks'] if m['k']=='sure'],float)))
man=np.array([(m['x'],m['y']+900) for m in d['marks'] if m['k']=='sure'],float)
for th,md,sat in [(85,10,80),(75,8,60),(85,8,80)]:
  det=detect(th,md,6,sat)
  for gap in (18,22,26):
    extra=np.array([p for p in det if np.hypot(*(man-p).T).min()>gap])
    print(th,md,gap,"candidats ajoutés",len(extra),"->",score(np.vstack([man,extra]))[:3])
