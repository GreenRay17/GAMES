# Planche de cases echantillon zoomees (estimation de densite des tas). Usage: Z=4 python3 cases_echantillon.py photo.jpg sortie.jpg x,y x,y ...
import cv2,sys,numpy as np
img=cv2.imread(sys.argv[1]); out=sys.argv[2]; cells=[tuple(map(int,c.split(','))) for c in sys.argv[3:]]
Z=int(__import__("os").environ.get("Z","8"));S=400//Z;tiles=[]
for x,y in cells:
    c=cv2.resize(img[y:y+S,x:x+S],None,fx=Z,fy=Z,interpolation=cv2.INTER_CUBIC)
    for k in (100,200,300): cv2.line(c,(k,0),(k,400),(255,255,0),1); cv2.line(c,(0,k),(400,k),(255,255,0),1)
    cv2.rectangle(c,(0,0),(399,399),(0,0,0),3)
    cv2.putText(c,f"{x},{y}",(6,22),0,0.7,(0,255,255),2); tiles.append(c)
while len(tiles)%3: tiles.append(np.zeros_like(tiles[0]))
rows=[np.hstack(tiles[i:i+3]) for i in range(0,len(tiles),3)]
cv2.imwrite(out,np.vstack(rows))
