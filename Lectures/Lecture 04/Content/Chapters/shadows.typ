// LTeX: enable=true language=de-DE
#import "../../Template/definitions.typ": *
#import "../../Template/template.typ": *

#chapter-title-slide(section-name: [Schatten])

#subchapter-title-slide(section-name: [Motivation])
#slide[
  = Motivation
  #set align(horizon)

  #align(center)[Mehr Realismus und Atmosphäre]

  #grid(
    columns: (1fr, 1fr),
    inset: 15pt,
    [
      #image("../../Images/crysis_3_water.jpg")
    ], [
      #image("../../Images/nier_automata_shadow.jpg")
    ]
  )
]

#slide[
  = Motivation
  #set align(horizon)

  - Hinweise über Rauminformationen
  - Hilfestellung für Game Play und Orientierung

  #figure(
    image("../../Images/no_shadow_shadow.png")
  )
]

#slide[
  = Motivation
  #set align(horizon)

  - Simple Schatten besser als keine Schatten
  - das menschliche Auge "_vergibt_"

  #figure(
    image("../../Images/super_mario_64.png", fit: "contain", width: 70%)
  )
]

#slide[
  = Definition
  == Bestandteile
  #set align(horizon)

  - Lichtquelle
  - Schatten Creator und Receiver

  #figure(
    image("../../Images/shadow_creator_receiver.png", width: 80%)
  )
]

#slide[
  = Definition
  == Schattenarten
  #set align(horizon)

  - Lichtquellentypen haben Einfluss auf Schatten
  - Kernschatten (Umbra) und Halbschatten (Penumbra)

  #figure(
    image("../../Images/shadow_umbra_penumbra.png", width: 80%)
  )
]

#slide[
  = Definition
  == Schattenarten
  #set align(horizon)

  - *Umbra*: Voller Schatten
  - *Penumbra*: Halbschatten in einem teilweise schattiertem Bereich
  - *Antumbra*: Halbschatten, wenn unterschiedliche Penumbra sich treffen
  - *Hard Shadow*: Schatten (Umbra) mit harten Kanten
  - *Soft Shadow*: Schatten mit weichen Kanten
]

#slide[
  = Definition
  == Lichtquellen & Schattenarten
  #set align(horizon)
  #table(
    columns: (auto, auto),
    stroke: hszg-green + 3.5pt,
    align: center,
    inset: 0pt,
    table.cell(
      fill: hszg-green.lighten(90%), 
      stroke: hszg-green + 3.5pt,
      inset: 10pt,
    )[Hard Shadows], 
    table.cell(
      fill: hszg-green.lighten(90%), 
      stroke: hszg-green + 3.5pt,
      inset: 10pt,
    )[Soft Shadows],
    table.cell(inset: 5pt)[
      #grid(
        columns: (1fr),
        inset: 10pt,
        [#image("../../Images/hard_shadows.png", width: 60%)],
        [_Hard Shadows_ von einer Sonne als Punktlichtquelle],
      )
    ], 
    table.cell(inset: 5pt)[
      #grid(
        columns: (1fr),
        inset: 10pt,
        [#image("../../Images/soft_shadows.png", width: 60%)],
        [_Soft Shadows_ von einem Area Light]
      )
    ],
  )
]

#slide[
  = Definition
  #set align(horizon)

  *Denkweise über Schatten*
  - als separate Objekte
  - als Volumina des Raums, die dunkel sind
  - als Orte, die nicht von einer Lichtquelle aus gesehen werden, die auf die Szene blickt

  *Eigenschaften* 
  - wenn die Lichtquellen Punktlichter sind, dann gibt es keinen Halbschatten und die Schatten haben harte Kanten
  - Schatten sind ansichtsunabhängig
  - Sie ändern sich in einer statischen Szene nicht, wenn die Ansicht geändert wird
]

#subchapter-title-slide(section-name: [Modelle])
#slide[
  = Modelle
  == Simple Shadows
  #set align(horizon)

  #grid(
    columns: (1fr, auto),
    [
      - sehr einfache Methode (Blinn, 1988)
        - beinhaltet das Zeichnen einer Projektion auf eine Grundplatte
        - begrenzt auf Ein-Objekte-Szenen
        - oder Szenen, wo Objekte keine Schatten auf sich gegenseitig werfen
      - kann erweitert werden zu vertikalen Flächen
      - kann erweitert werden zu zufällig orientierten Flächen
    ], grid.cell(inset: 10pt)[
      #figure(
        image("../../Images/blinn_simple_shadow.png")
      )
    ]
  )
]

#slide[
  //TODO: Make slide nicer
  #set align(horizon)
  #grid(
    columns: (1fr, 1fr),
    align: center + horizon,
    [
      Shadow Mapping
    ], [
      Shadow Volumes
    ]
  )
]

#chapter-title-slide(section-name: [Shadow Maps])

#slide[
  = Modellierung
  == Shadow Mapping
  #set align(horizon)

  - Eingeführt von Lance Williams 1978
  - Überprüfung, ob ein Pixel von einer Lichtquelle sichtbar ist
  *Vorteile* \
    - Kosten weniger empfindlich gegenüber geometrischer Komplexität
    - Können an beliebiger Stelle abgefragt werden
    - Oft einfacher zu implementieren
  *Nachteile* \
    - Aliasing
  *Nutzung* \
  - Blender EEVEE, Unreal, Unity ...
]

#slide[
  = Ansatz
  #set align(horizon)

  - Szene wird von der Lichtquelle aus gerendert
  - Alles was von der Lichtquelle aus gesehen werden kann ist beleuchtet
  - Alles was nicht von der Lichtquelle gesehen werden kann ist im Schatten

  #grid(
    columns: (1fr, 1fr),
    align: center + horizon,
    [
      #box(fill: blue, width: 50pt, height: 15pt) Im Licht
    ], [
      #box(fill: black, width: 50pt, height: 15pt) Im Schatten
    ]
  )

  #figure(
    image("../../Images/shadow_mapping/shadow_mapping_rendering_from_light.png", height: 55%)
  )
]

#slide[
  = Ansatz
  #set align(horizon)

  - Erster Hit des Lichtrays wird mit allen folgenden Hits verglichen
  - Wenn der neue Punkt weiter entlang des Rays patziert ist, ist der im Schatten
  - Rays zu ineffizient für real time Rendering
  - Depth Buffer als bessere Alternative
]

#slide[
  = Shadow Map
  == 1. Pass
  #set align(horizon)

  #grid(
    columns: (1fr, 0.75fr),
    [
      Rendern der Szene aus Sicht der Lichtquelle
      - Tiefenwerte pro Pixel abspeichern im z-Buffer
      - Die Geometrie der Szene wird einmal pro Punktlicht gerendert
      - Für ein omnidirektionales Punktlicht muss die Szene mehr als einmal gerendert werden
      - Sofern der Schattenbereich nicht auf einen gewünschten Wirkungswinkel für gerichtetes Licht (z.B.: den der Sonne) begrenzt werden kann, sollte eine Parallelprojektion verwendet werden
    ], grid.cell(inset: 10pt)[
      #figure(
        image("../../Images/z_buffer_render.png"),
        caption: [
          Szene, die aus der Sicht der Lichtquelle gerendert wurde. 
          Weiß ist fern und schwarz ist nah.
        ]
      )
    ]
  )
]

#slide[
  = Shadow Map
  == 2. Pass
  #set align(horizon)

  - Render aus Sicht der Kamera
  - Verwendung der Shadow Map
    - Umwandlung des Oberflächenpunkts $P$ in Lichtkoordinaten $P_(L)$
    - Vergleich der aktuellen Oberflächentiefe am Punkt $P$ mit der gespeicherten Tiefe in der Shadow Map
    - Wenn $T gt T_("gespeichert")$ $arrow$ Pixel ist im Schatten
    - Wenn Tiefe $T eq eq T_("gespeichert")$ gespeicherte Tiefe denn ist der Pixel beleuchtet
    - $T lt T_("gespeichert")$ sollte nie eintreten
]

#slide[
  = Shadow Map
  #set align(horizon)

  #figure(
    image("../../Images/shadow_mapping/shadow_map_diagram.png")
  )
]

#slide[
  = Ergebnis
  #set align(horizon)

  #figure(
    image("../../Images/shadow_mapping_result.png", width: 70%)
  )
]

#slide[
  = Multiple Lights
  #set align(horizon)

  - Eine Shadow Map pro Lichtquelle
  - Punktlicht: bis zu 6 Shadow Maps
  - Definierung von Schattenerzeugern und Empfängern

  #figure(
    image("../../Images/multiple_shadow_maps_threejs.png", fit: "contain", width: 50%),
    caption: [
      Zwei Shadow Maps in einem ThreeJS Beispiel. \
      #link("https://threejs.org/examples/#webgl_shadowmap_viewer")[
        #text(fill: blue)[#underline[Link $arrow$]]
      ]
    ]
  )
]

#slide[
  = Multiple Lights
  #set align(horizon)

  ```javascript
  const spotLight = new THREE.SpotLight(...);
  const directionalLight = new THREE.DirectionalLight(...);
  torusKnot.castShadow = true;
  torusKnot.receiveShadow = true;
  cube.castShadow = true;
  cube.receiveShadow = true;
  ground.castShadow = false;
  ground.receiveShadow = true;
  ```
]

#slide[
  = Aliasing Probleme
  #set align(horizon)

  - Vergrößerung, Verkleinerung und anisotrope Artefakte
  - Erhöhung der Auflösung der Shadow Map ist rechenintensiv
  - Texturfilterung kann nicht auf standard Shadow Maps angewendet werden
  
  #set align(center)
  #image("../../Images/shadow_map_aliasing.png")
]

#slide[
  = Schattenakne
  #set align(horizon)

  $ T_("gepeichert") gt T $
  - Numerische Fehler
  - Führen zu Artefakten in Bereichen die beleuchtet sein sollten

  #set align(center)
  #image("../../Images/shadow_acne.png")
]

#slide[
  = Anti Aliasing
  #set align(horizon)

  Es gibt Varianten des Shadow Mapping, die Anti-Aliasing Techniken unterstützen. 
  Normalerweise werden sie bei Texturfilterung angewendet \
  *Techniken*: bi- und trilineare Interpolation, Mip-Mapping und Weichzeichnen
  - Variance Shadow Maps
  - Exponential Shadow Maps
  - Cascaded Shadow Maps
]

#slide[
  = Cascaded Shadow Maps
  #set align(horizon)
  
  #grid(
    columns: (auto, 1fr),
    [
      #enum(
        numbering: "A:",
        enum.item(1)[keine Cascades],
        enum.item(2)[2 Cascades],
        enum.item(3)[3 Cascades],
        enum.item(4)[4 Cascades]
      )
    ], [
      #figure(
        image("../../Images/cascading_shadow_maps.png", fit: "contain", width: 70%)
      )
    ]
  )

  *Konzept*: Shadow Maps werden hochauflösender, wenn sie näher am Betrachter sind
]

#slide[
  = Soft Shadows
  #set align(horizon)

  - Verwischen der Shadow Map
  - Erzeugt Eindruck weicher Schatten

  #figure(
    image("../../Images/shadow_blurring.png", width: 100%)
  )
]

#chapter-title-slide(section-name: [Shadow Volumes])

#slide[
  = Shadow Volumes & Stencil Shadows
  #set align(horizon)

  - Popularisiert von Doom 3 (2004)
  - Hauptidee: Erstelle ein Volumen, welches alle Schatten der Szene einschließt
  - Finden der Silhouetten aller Objekte
  $arrow$ Kanten finden, bei denen ein Face Richtung Licht zeigt und eins weg vom Licht zeigt

  #figure(
    image("../../Images/shadow_volumes/shadow_volume_silhouette.png", fit: "contain", width: 50%)
  )
]

#slide[
  = Shadow Volumes & Stencil Shadows
  #set align(horizon)

  - Vertices, die Richtug Licht zeigen bleiben an ihrer Position
  - Vertices, die weg vom Licht zeigen werden weit weg extrudiert
  - Duplizieren und Extrudieren der Silhouetten-Vertices und Verbindung mit den originalen Vertices

  #figure(
    image("../../Images/shadow_volumes/shadow_volume_extrude.png", fit: "contain", width: 30%)
  )

  Erstellung von: Light Cap, Dark Cap und Sides
]

#slide[
  = Silhouette Edges
  #set align(horizon)

  - Nur äußere Kanten tragen zur Erstellung des Shadow Volumes bei
  - Erstellung der Silhouettenkante entfernt nutzlose Polygone

  #figure(
    image("../../Images/shadow_volumes_polygon_merging.png", width: 90%)
  )
]

#slide[
  = Shadow Volumes & Stencil Shadows
  #set align(horizon)

  *Pros*
  - Hohe Qualität
  - Scharfe Kanten
  *Cons*
  - Nicht so schnell wie Shadow Maps
  - Sensitiver gegenüber geometrischer Komplexität
  - Kanten teilweise zu scharf
]

#slide[
  = Shadow Volumes
  #set align(horizon)

  #figure(
    image("../../Images/shadow_volumes_wireframe.png")
  )
]

// #slide[
//   = Testen eines Punktes
//   #set align(horizon)

//   - Zählen aller Shadow Volume Polygone zwischen Objekt und Auge
//   - Wenn: $abs(P_("Front Facing")) gt abs(P_("Back Facing"))$ dann Schatten

//   #figure(
//     image("../../Images/shadow_volumes_testing.png", width: 80%)
//   )
// ]

#slide[
  = Stencil Buffer
  #set align(horizon)

  - Buffer mit 8-Bit pro Pixel
  - Hinzufügen und Entfernen von Inhalten beim Rendering
  - Maskierung im finalen Bild

  #figure(
    image("../../Images/stencil_buffer.png")
  )
]

#slide[
  = Shadow Volumes & Stencil Buffer
  == Implementierung
  #set align(horizon)

  1. Rendering der Szene mit ambienten Licht
  2. Rendering der Front Facing Shadow Volumes in den Stencil Buffer
  3. Rendering der Back Facing Shadow Volumes in den Stencil Buffer
  4. Rendering diffuser und specular Oberlächen, bei denen der Buffer $0$ ist 
]

#slide[
  = Beispiel
  #set align(horizon)

  #figure(
    image("../../Images/carmack_stencil.png"),
    caption: [
      Carmacks Stencil Buffer, Doom 3
    ]
  )
]

// #slide[
//   = Merging
//   #set align(horizon)

//   Kanten, die von zwei Polygonen geteilt werden, werden aus bei der Form des Shadow Volumes ignoriert

//   #figure(
//     image("../../Images/shadow_volumes_merge.png", width: 90%)
//   )
// ]
