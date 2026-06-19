= Catmull-Clark

Implementiere den Catmull-Clark Subdivision Algortihmus. 
Es wird dafür das catmullclark Package bereitgestellt.

== Schritte
1. Finde alle Face-Points
  - Face-Point = Durchschnitt aller Punkte eines Faces
  #image("step_1.png", width: 50%)
2. Finde alle Edge-Points
  - Edge-Point ist Durchschnitt der benachbarten Face-Points und dem Mittelpunkt der jeweiligen Kante
  #image("step_2.png", width: 50%)
3. Finde alle Vertex-Points
  - Für jeden ursprünglichen Punkt $P$: Nehme den Durschnitt aller Face-Points von benachbarten Faces und den Durschnitt der Mittelpunkte der Kanten die $P$ berühren 
  - $P$ wird zum neuen Vertex-Point verschoben
  #image("step_3.png", width: 50%)

#pagebreak()

4. Verbinde neue Face-Points mit passenden Edge-Points
#image("step_4.png", width: 50%)
5. Verbinde Vertex-Points mit passenden Edge-Points
#image("step_5.png", width: 50%)
6. Definiere die neuen Faces
#image("step_6.png", width: 50%)