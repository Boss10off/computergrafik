#import "../../Template/definitions.typ": *
#import "../../Template/template.typ": *

#chapter-title-slide(section-name: [Viewing])

#slide[
  = Historie
  #set align(horizon)

  - Planansicht (orthografische Projektion) aus Mesopotamien, 2150 v. Chr.
  - Älteste bekannte technische Zeichnung, die existiert

  #figure(
    image("../../Images/planview_meso.png")
  )

  - Griechische Vasen aus dem späten 6. Jahrhundert v. Chr. zeigen Perspektive
  - Vitruv, ein römischer Architekt, veröffentlichte Spezifikationen für Grund- und Aufrisszeichnungen, sowie für die Perspektive
  - Illustrationen zu den Schriften sind verloren gegangen
]

#slide[
  = Frühe Perspektive
  #set align(horizon)

  - Möglichkeiten, den dreidimensionalen Raum aufzurufen:
    - abgerundete, volumetrische Formen, die durch Schattierung suggeriert werden
    - räumliche Tiefe des Raumes, die durch konvergierende Linien suggeriert wird
  - Nicht systematisch - die Linien konvergieren nicht zu einem einzigen Fluchtpunkt

  #figure(
    image("../../Images/early_perspective.png")
  )
]

#slide[
  = Alberti
  #set align(horizon)

  - Veröffentlichung der ersten Abhandlung über die Perspektive, Della Pittura, im Jahr 1435
  
  #rect(inset: 15pt, fill: hszg-green.lighten(90%), stroke: (paint: hszg-green, thickness: 3.5pt, join: "bevel"))[
    Ein Gemälde \[die Projektebene\] ist der Schnittpunkt einer visuellen Pyramide \[Betrachtungsvolumen\] in einer bestimmten Entfernung, mit einem festen Zentrum \[Projektionszentrum\] und einer definierten Position des Lichts, dargestellt durch die Kunst mit Linien und Farben auf einer bestimmten Oberfläche \[der Wiedergabe\].
    #v(10pt)
    #text(weight: "light", size: 15pt)[
      Leono Battista Alberti (1404 - 1472), Über die Malerei, S. 32 - 33
    ]
  ] 
]

#slide[
  = Lineare Projektion
  #set align(horizon)

  - Parallele Linien konvergieren (in 1, 2 oder 3 Achsen) zu einem Fluchtpunkt
  - Weiter entfernte Objekte sind stärker verkürzt (d.h. kleiner) als nähere Objekte
    - Beispiel: Perspektivischer Würfel

  #figure(
    cetz.canvas(length: 4cm, {
      import cetz.draw: *

      let outerP1 = (-1, -1)
      let outerP2 = (1, -1)
      let outerP3 = (1, 1)
      let outerP4 = (-1, 1)

      let innerP1 = (-0.25, -0.25)
      let innerP2 = (0.25, -0.25)
      let innerP3 = (0.25, 0.25)
      let innerP4 = (-0.25, 0.25)

      let stroke_style = (
        thickness: 2.5pt
      )

      line(outerP1, outerP2, outerP3, outerP4, close: true, stroke: stroke_style)
      line(innerP1, innerP2, innerP3, innerP4, close: true, stroke: stroke_style)
      line(outerP1, innerP1, stroke: stroke_style)
      line(outerP2, innerP2, stroke: stroke_style)
      line(outerP3, innerP3, stroke: stroke_style)
      line(outerP4, innerP4, stroke: stroke_style)
    })
  )
]

#slide[
  = Ein-Punkt-Perspektive
  #set align(horizon)

  #figure(
    image("../../Images/one_point_perspective.png", width: 100%)
  )
]

#slide[
  = Zwei-Punkt-Perspektive
  #set align(horizon)

  #figure(
    image("../../Images/two_point_perspective.png", width: 100%)
  )
]

#slide[
  = Drei-Punkt-Perspektive
  #set align(horizon)

  #figure(
    image("../../Images/three_point_perspective.png", width: 100%)
  )
]

#slide[
  = Geometrische Konstruktion von Projektionen
  #set align(horizon + center)

  Bis zu 6 verschiedene Fluchtpunkte möglich

  #v(15pt)

  #grid(
    columns: (1fr, 1fr, 1fr),
    align: center + horizon,
    [
      #image("../../Images/one_point_pers_example.png", height: 100pt)
      *1 Punkt Perspektive*
      #v(15pt)
      Beispiel: Blick Richtung Ende eines Raumes.
    ], [
      #image("../../Images/two_point_pers_example.png", height: 100pt)
      *2 Punkt Perspektive*
      #v(15pt)
      Beispiel: Kante eines Gebäudes betrachten.
    ], [
      #image("../../Images/three_point_pers_example.png", height: 100pt)
      *3 Punkt Perspektive*
      #v(15pt)
      Beispiel: Gebäude von oben betrachten.
    ]
  )
]

#slide[
  = Planare geometrische Projektion
  #set align(horizon)

  - Projektoren sind gerade Linien
  - Projektionsfläche ist eine Ebene (Bildebene, Projektionsebene)

  #figure(
    image("../../Images/planar_projection.png", width: 80%)
  )
]

#slide[
  = Hauptklassen geometrischer Projektion
  #set align(horizon)

  - *Perspektive*: Bestimmt durch den _Projektionsmittelpunkt_ \ (#text(weight: "bold")[C]enter #text(weight: "bold")[O]f #text(weight: "bold")[P]rojection)
  - *Parallel*: Bestimmt durch die _Projektionsrichtung_ \ (#text(weight: "bold")[D]irection #text(weight: "bold")[O]f #text(weight: "bold")[P]rojection)
    - Projektoren sind parallel - sie konvergieren nicht zu einem _Auge_ oder COP
    - alternativ: COP liegt im Unendlichen
]

#slide[
  = Hauptklassen geometrischer Projektion
  #set align(horizon)
  
  #image("../../Images/dop_cop.png")
]

#slide[
  = Hauptklassen geometrischer Projektion
  #set align(horizon)

  Im Allgemeinen wird Projektion dadurch bestimmt, wo die Projektionsebene im Verhältnis zu den Hauptachsen des Objekts platziert ist und welchen Winkel die Projektoren mit der Projektionsebene bilden.
]

#slide[
  = Typen von Projektion
  #set align(horizon)

  - *Parallele Projektion* werden im Ingenieurwesen und in der Architektur eingesetzt, da sie für Messungen verwendet werden können
    - entspricht nicht der Funktionsweise des menschlichen Auges
    - Objekte erscheinen nicht größer oder kleiner, abhängig von Distanz zum Betrachter
  - *Perspektive* imitiert Augen oder eine Kamera $arrow$ sieht natürlicher aus
]

#chapter-title-slide(section-name: [Orthographic Projection])

#slide[
  = Multiview Orthographic Projection
  #set align(horizon)

  Mehrere Ansichten erforderlich, um ein Gefühl für ein dreidimensionales Objekt zu bekommen.

  Verwendet für:
    - CAD/CAM
    - Architektur
  
  *Vorteile*
  - genaue Messung möglich
  - alle Ansichten haben den gleichen Maßstab

  *Nachteile*
  - keine realistische Ansicht oder Gefühl für 3D-Form
]

#slide[
  = Axonometrische Projektion
  #set align(horizon)

  - Gleiche Methode wie orthografische Mehransichtenprojektion
  - Projektionsebne nicht parallel zu einer Koordinatenebene
    - isometrisch: Die Winkel zwischen allen drei Hauptachsen sind gleich ($120 degree$)
    - anders: Die Winkel zwischen den Hauptachsen sind unterschiedlich
  - Konstruktion einer isometrischen Projektion: Projektebene schneidet jede Hauptachse um $45 degree$

  *Verwendet für*
  - Katalogabbildungen, Möbeldesign
  - Computerspiele

  *Vorteile*
  - Mehrere Ansichten nicht nötig

  *Nachteile*
  - Weniger für gebogene Formen geeignet
  - Wahrnehmung von Tiefe und Höhe kann verwirrend sein
]

#slide[
  = Axonometrische Projektion
  #set align(horizon)

  #figure(
    image("../../Images/sims_1.png"),
    caption: [
      The Sims 1
    ]
  )
]

#slide[
  = Axonometrische Projektion
  #set align(horizon)

  - Bewegung der Projektionsebene relativ zum Objekt zulassen
  - Wir können klassifizieren, wie viele Winkel einer Ecke eines projizierten Würfels gleich sind
    - keine: trimetrisch
    - zwei: dimetrisch
    - drei: isometrisch
  
  #figure(
    image("../../Images/projection_di_tri_iso.png", width: 70%)
  )
]

#slide[
  = Axonometrische Projektion
  #set align(horizon)

  #toolbox.side-by-side()[
    Der klassische Fehler bei der Verwendung der axonometrischen Projektion: \

    #text(weight: "light")[
      Die rote und die blaue Kugel können den Anschein erwecken, in derselben Ebene zu liegen, aber die blaue Kugel liegt tatsächlich zwei "Ebenen" höher.
    ]
  ][
    #image("../../Images/axo_mistake.png")
  ]
]

#chapter-title-slide(section-name: [Oblique Projection])

#slide[
  = Schrägprojektion / Oblique Projection
  #set align(horizon)

  - Projektionsebene parallel zu einer der Koordinatenebenen
  - Projektoren stehen in einem schiefen Winkel zur Projektionsebene
  - Vergleiche Schrägansichtsvolumen in der Fotografie
    - Fachkameras mit Ziehharmonika-Gehäuse
    - z.B.: bei Wolkenkratzern verwendet
  *Vorteile*
  - Kann genaue Form einer Seite eines Objekts darstellen
  - Kann genaue Messungen vornehmen

  *Nachteile*
  - Objekte können verzerrt aussehen, wenn Position der Projektionsebene nicht sorgfältig gewählt wird
]

#slide[
  = Schrägprojektion / Oblique Projection
  #set align(horizon)

  #figure(
    image("../../Images/perspective_oblique.png", width: 80%)
  )
]

#slide[
  = Vergleich paralleler Projektion
  #set align(horizon)

  #grid(
    columns: (1fr, 0.4fr),
    inset: 10pt,
    [
      *1. Multiview Orthographic*
      - VPN parallel zu einer Hauptkoordinatenachse
      - DOP parallel zur VPN
      *2. Axonometrisch*
      - VPN nicht parallel zu einer Hauptkoordinatenachse
      - DOP parallel zur VPN
      *3. Schräg*
      - VPN parallel zu einer Hauptkoordinatenachse
      - DOP nicht parallel zur VPN
    ], [
      #image("../../Images/parallel_projection_comp.png", width: 100%)
    ]
  ) 
]

#chapter-title-slide(section-name: [Perspective Projection])

#slide[
  = Perspektivische Projektion
  #set align(horizon)

  #grid(
    columns: (1fr, 0.5fr),
    inset: 10pt,
    [
      - Parallele Linien konvergieren
      - Sie verlaufen nicht parallel zu einer Projektionsebene
      - Die Größe des Objekts nimmt mit Entfernung ab

      *Vorteile*
      - Realistische Ansicht
      - Gefühl für die 3D-Form des Objekts

      *Nachteile*
      - Erhält weder Form noch Maßstab des Objekts
    ], [
      #figure(
        image("../../Images/elite_perspective.png", width: 100%),
        caption: [
          Elite Dangerous
        ]
      )
    ]
  )
]

#chapter-title-slide(section-name: [Kameras])

#slide[
   = Synthetische Kamera
   #set align(horizon)

  *Parameter*
  - Position
  - Blickvektor: Richtung, in die die Kamera gerichtet ist
  - Aufwärtsvektor: Drehung der Kamera um den Blickvektor (bestimmt die Ausrichtung)
  - Seitenverhältnis: Verhältnis der Breite zur Höhe der Projektionsebene (_Filmgröße_)
  - Höhenwinkel: Bestimmt, wie viel von der Szene in unser Sichtvolumen passt
    - Je größer der Winkel, desto größer die perspektivische Verzerrung
  - Breitenwinkel: Bestimmt durch Höhenwinkel und Seitenverhältnis
  - Vordere und hintere Clipping-Ebenen (nur Objekte dazwischen werden gerendert)
]

#slide[
  = Synthetische Kamera
  == Fokus
  #set align(horizon)

  - Manchmal zusätzlicher, optionaler Parameter für die Brennweite, insbesondere bei fotorealistischem Rendering
  - unscharfe Darstellung von Objekten, die nicht scharf sind

  #figure(
    image("../../Images/synth_camera_focus.png", width: 80%)
  )
]

#chapter-title-slide(section-name: [Special Camera FX])

#slide[
  = Special Camera FX
  == Depth of Field
  #set align(horizon)

  - In Echtzeit 3D-Grafiken kann die Tiefenschärfe als Postprocessing Effect eingesetzt werden #text(weight: "light")[(kann rechenintensiv sein)]
  - Raytracing-Ansätze verwenden simulierte Linsen, um die Tiefenschärfe zu erreichen #text(weight: "light")[(rechnerisch noch teurer, aber meist keine Echtzeitanforderungen)]

  #figure(
    image("../../Images/depth_of_field.png")
  )
]

#slide[
  = Special Camera FX
  == Motion Blur
  #set align(horizon)
  //TODO: Write Motion Blur Chapter
]

// #slide[
//   = Special Camera FX
//   == Film Grain
//   #set align(horizon)
//   //TODO: Write Film Grain Chapter
// ]

// #slide[
//   = Special Camera FX
//   == Lens Flare
//   #set align(horizon)
//   //TODO: Write Lens Flare Chapter
// ]
