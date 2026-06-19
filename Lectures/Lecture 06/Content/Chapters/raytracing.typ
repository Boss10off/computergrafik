#import "../../Template/definitions.typ": *
#import "../../Template/template.typ": *

#chapter-title-slide(section-name: [Raytracing])

#slide[
  =
  #set align(horizon + center)
  Bisher nur lokale Beleuchtung
]

#slide[
  = Globale Beleuchtungsmodelle
  #set align(horizon)
  - Beinhalten LichtReflexionen anderer Oberflächen und Schatten
  - Wesentliche Modelle: *Raytracing* und *Radiosity*
  - Verbesserung der Darstellung bei wesentlich mehr Rechenzeit
  
  #figure(
    image("../../Images/raytracing_room.png")
  )
]

#slide[
  = Global vs. Lokal
  #set align(horizon)

  #figure(
    image("../../Images/global_local_shading.png", width: 90%)
  )
]

#slide[
  = Global vs. Lokal
  #set align(horizon)

  #figure(
    image("../../Images/phong_ray_room.png", width: 100%)
  )
]

#slide[
  = Raytracing
  #set align(horizon)

  #grid(
    columns: (1fr, 0.9fr),
    [
      Warum Raytracing?
      - Simulation von Lichtstrahlen
      - Produziert natürliche Beleuchtungseffekte
        - Reflexionen
        - Brechungen
        - Schatten
        - Tiefenschärfe
        - Bewegungsunschärfe
    ], [
      #figure(
        image("../../Images/minecraft_rtx.png", width: 100%)
      )

      #figure(
        image("../../Images/raytracing_example.png", width: 100%)
      )
    ]
  )
]

#slide[
  = Raytracing
  == Grundidee
  #set align(horizon + center)

  Simulation eines Lichtstrahls von Lichtquelle zu Auge

  #cetz.canvas(length: 3cm, {
    import cetz.draw: *

    circle((-1.2, 1.2), radius: 15pt)
    circle((-1.15, 1.15), radius: 6pt, fill: blue, stroke: blue)
    circle((-1.14, 1.14), radius: 3pt, fill: black, stroke: blue)

    circle((1.2, 1.2), radius: 12pt, fill: yellow, stroke: yellow)
    line((1.5, 1.2), (0.9, 1.2), stroke: yellow + 2.5pt)
    line((1.2, 1.5), (1.2, 0.9), stroke: yellow + 2.5pt)

    
    line((1, 1), (0, 0), stroke: 2.5pt + hszg-green, mark: (end: ">"))
    line((0, 0), (-1, 1), stroke: 2.5pt + hszg-green, mark: (end: ">"))

    line((-2, 0), (2, 0), stroke: 2.5pt)
  })
]

#slide[
  = Forward Raytracing
  #set align(horizon)

  - Strahlenverfolgung ab Lichtquelle
  - Viel Aufwand für wenig Ertrag

  #figure(
    image("../../Images/forward_raytracing.png", width: 80%)
  )
]

#slide[
  = Backward Raytracing
  #set align(horizon)
  #v(1fr)
  - Strahlenverfolgung ab Auge statt Lichtquelle
  - Aufwand nur dort, wo es nötig ist
  - Gewöhnlicher Ansatz, wenn man von Raytracing spricht
  #v(1fr)
  #figure(
    image("../../Images/backward_raytracing.png", width: 60%)
  )
  #v(1fr)
]

#slide[
  = Raytracing
  #set align(horizon)

  - Farbfeststellung pro Pixel:
    - Erstellung eines Strahls ab Auge duch Pixel in die virtuelle Szene
    - Feststellung von Intersection mit Objekten
    - Feststellung der sichtbaren Flächen
  - Darstellung der ersten Intersection ist bekannt als *Ray Casting*

  #figure(
    image("../../Images/raycasting.png", width: 40%)
  )
]

#slide[
  = Schatten
  #set align(horizon)

  - Elementar für realistische Darstellung von Raycasting
  - Erzeugung eines Feeler Rays ab dem Punkt der Intersection zum Licht, um festzustellen, ob Licht blockiert wird

  #figure(
    image("../../Images/shadows_ray.png")
  )
]

#slide[
  = Schatten
  #set align(horizon)

  Cast eines Rays pro Pixel solange
    - ... er bis zur $infinity$ geht (Hintergrundfarbe wird genutzt)
    - ... ein Licht Trifft (Lichtfarbe wird genutzt)
    - ... eine Surface trifft
      - Feststellen, ob Oberfläche beleuchtet ist
      - Berechnung von Schatten über Feeler Rays
      - Wenn Feeler Ray anderes Surface zuerst trifft, dann ist die Lichtquelle blockiert (Schatten)
]

#slide[
  = Schatten
  #set align(horizon)

  - Wenn Feeler Ray zuerst ein Objekt trifft, dann ist die zweite Intersection eines Objektes ein Schatten
  #v(50pt)
  #figure(
    cetz.canvas(length: 3cm, {
      import cetz.draw: *

      

      circle((2, 0), radius: 30pt, fill: blue, stroke: blue, name: "normal")
      rect((4, -1), (6, 1), fill: gray, name: "plane")
      circle((5, 0), radius: 30pt, fill: black.transparentize(50%), stroke: none, name: "shadow")

      line((0, 0), (5, 0), stroke: 2.5pt, name: "feeler")

      content("feeler.0%", [Feeler Ray], padding: (bottom: 50pt))
      content("normal.south", align(center)[Erste Intersection], padding: (top: 50pt))
      content("plane.south", align(center)[Zweite Intersection \ Schatten], padding: (top: 75pt))
    })
  ) 
]

#slide[
  = Reflexionen
  #set align(horizon)

  - Elementar für realistische Darstellung durch Raytracing
  - Verfolgen eines Rays von reflektierenden Oberflächen
  - Feststellen, ob ein Objekt getroffen wird
  - Nur spiegelnde Reflexionen werden berücksichtigt
  
  *Wenn Ja*: 
  - Berechnung der Beleuchtungsgleichung für den Sekundärstrahl
  - Bestimmen des Beitrags dieser Reflexion am ersten Schnittpunkt

  #figure(
    image("../../Images/reflection_raytracing.png")
  )
]

#slide[
  = Brechung (Refraction)
  #set align(horizon)

  - Transparente Objekte brechen (krümmen) Licht beim Durchdringen
  - Berechnung und Verfolgung von gebrochnen Strahlen
  - Biegewinkel $f$ kann aus den Brechungsindizes $n_(1)$ und $n_(2)$ der beiden Materialien berechnet werden
  
  #showybox(
    frame: (
      border-color: hszg-green,
      thickness: 2.5pt,
      title-color: hszg-green.lighten(60%)
    ),
    title-style: (
      color: black,
      sep-thickness: 2.5pt,
    ),
    title: [*Snell's Law*],
    shadow: (
      color: black.lighten(50%)
    )
  )[
    $ n_(1) times sin(theta) eq n_(2) times sin(phi) $
  ]
]

#slide[
  = Brechung (Refraction)
  #set align(horizon)

  - Brechungen sind abhängig von der Wellenlänge (Dispersion)
  - Brechungen werden stärker mit abnehmender Wellenlänge des Lichts
  - In der Computergrafik Häufig igoniert
  *Beispiel*: Regenbogen

  #figure(
    image("../../Images/rainbow_refraction.png", width: 80%)
  ) 
]

// #slide[
//   = Dispersion
//   #set align(horizon)

//   //Write chapter for dispersion
//   #link("https://de.wikipedia.org/wiki/Dispersion_(Physik)")[Wikipedia]
// ]

#slide[
  = Nicht-ideale Reflexionen / Brechungungen
  #set align(horizon)

  #figure(
    image("../../Images/non_ideal_reflection_refraction.png")
  )
]

#slide[
  = Vor- und Nachteile
  #set align(horizon)

  *Vorteile*
  - Transparenz
  - Spiegelungen
  - Schatten
  - Einfach konstruktive Volumenkörpergeometrie
  - Konzeptionell einfach und einfach zu implementieren
    - Kein Clipping, keine Projektionen, keine Scan-Konvertierungen
    - Leicht Parallelisierbar

  *Nachteile*
  - Keine diffus-diffusen Wechselwirkungen (z.B.: Pfadverfolgung)
  - Ansichtsabhängig (Kein walk-through möglich)
  - Schnittpunkttests sind *teuer* (Kann durch Bounding Volumes optimiert werden)
]

#chapter-title-slide(section-name: [Rekursives Raytracing])

#slide[
  = Rekursives Raytracing
  #set align(horizon)

  - Rekursives Raytracing berechnet Schatten, spekulare Reflexionen und Brechungen bei jeder Intersection
  - Anzahl der Rekursionslevel kann verändert werden und entscheidet über Komplexität und Genauigkeit der Darstellung
  - Nur direkte Beleuchtung, keine diffusen Reflexionen

  #figure(
    image("../../Images/recursive_raytracing.png")
  )
]

#slide[
  = Rekursives Raytracing
  #set align(horizon)

  #grid(
    columns: (1fr, 1.5fr),
    [
      *Endlose Rekusion?*
      - Rekursionstiefe entscheident
      - Definition der Anzahl der Bounces
      - Anteil eines Bounces an der Gesamtdarstellung darf nicht unter Minimalwert fallen, sonst wird er verworfen 
    ], [
      ```
        trace ray
          Intersect all objects
          color = ambient term
          For every light
            cast shadow ray
            color += local shading term
          If mirror
            color += reflection_color * trace reflected ray
          If transparent
            color += transparent_color * trace transmitted ray
      ```
    ]
  )
]

#slide[
  = Rekusrives Raytracing
  == Ray Tree

  #grid(
    columns: (1fr, 1fr),
    inset: 10pt,
    [
      #figure(
        image("../../Images/raytree_base.png", width: 100%)
      )

      $N_(i)$: Oberflächen Normale \
      $R_(i)$: Reflektierter Ray \
      $L_(i)$: Schatten Ray \
      $T_(i)$: transmitted (refracted) Ray
    ], [
      #set align(center)
      #cetz.canvas(length: 3cm, {
        import cetz.draw: *

        content((0, 0), padding: (bottom: 35pt), [Auge])

        line((0, 0), (0, -1), stroke: 2.5pt)
        line((0, -1), (1, -1), stroke: 2.5pt + green, mark: (end: ">"), name: "l1")
        line((0, -1), (-1, -2), stroke: 2.5pt + red, name: "r1")
        line((-1, -2), (0, -2), stroke: 2.5pt + green, mark: (end: ">"), name: "l2")
        line((-1, -2), (-2, -3), stroke: 2.5pt + red, name: "r2")
        line((0, -1), (1, -2), stroke: 2.5pt + blue, name: "t1")
        line((1, -2), (2, -3), stroke: 2.5pt + blue, name: "t3")
        line((1, -2), (0, -3), stroke: 2.5pt + red, name: "r3")
        line((1, -2), (2, -2), stroke: 2.5pt + green, mark: (end: ">"), name: "l3")

        circle((0, -1), radius: 5pt, fill: black)
        circle((-1, -2), radius: 5pt, fill: black)
        circle((1, -2), radius: 5pt, fill: black)

        content("l1.100%", text(fill: green)[$L_(1)$], padding: (left: 25pt))
        content("l2.100%", text(fill: green)[$L_(2)$], padding: (left: 25pt))
        content("l3.100%", text(fill: green)[$L_(3)$], padding: (left: 25pt))

        content("r1.50%", text(fill: red)[$R_(1)$], padding: (right: 50pt))
        content("r2.50%", text(fill: red)[$R_(2)$], padding: (right: 50pt))
        content("r3.50%", text(fill: red)[$R_(3)$], padding: (right: 50pt))

        content("t1.50%", text(fill: blue)[$T_(1)$], padding: (left: 50pt))
        content("t3.50%", text(fill: blue)[$T_(3)$], padding: (left: 50pt))
      })
    ]
  )
]

#slide[
  = Rekursives Raytracing
  == Ray Tree
  #set align(horizon)

  - Darstellung eines Ray Trees für einen einzelnen Bildpixel
  - Kann sehr komplex werden: *Terminierungsparameter* muss gezielt gesetzt werden

  #figure(
    image("../../Images/recursive_raytracing_3d.png", width: 60%)
  )
]

#chapter-title-slide(section-name: [Diffuses Raytracing])

#slide[
  = Diffuses / Stochastisches Raytracing
  #set align(horizon)

  Problem mit Whitted Raytracing:
  - Harte Schatten
  - Perfekte Reflektionen
    - Erfordert perfekte Spiegelungen
    - z.B.: Metallische Spiegelungen sind gläzend
  - alles im Fokus

  Idee des distributed Raytracing
  - Mehrere Strahlen pro Pixel werfen
  - Mehrere Reflexions- und Brechungsstrahlen werfen
  - Flächenlichtquellen verwenden (mehrere Schattenstrahlen werfen)
]

#slide[
  = Diffuses / Stochastisches Raytracing
  #set align(horizon)

  #figure(
    image("../../Images/distributed_raytracing.png")
  )
]

#slide[
  = Diffuses / Stochastisches Raytracing
  #set align(horizon)

  - Casten mehrerer Rays pro Pixel
  - z.B.: 16 Sub-Pixel
  - Geschichtetes Sampling
    - Zufällige Position der Sub-Pixel
    - Zufälligkeit hilft bei Vorbeugung möglichen Aliasings
  
  #figure(
    image("../../Images/stratified_sampling.png"),
    caption: [
      _Stratified Sampling_ in Computergrafik: 
      Ein Pixel wird in 16 Unterpixel und 16 Samplepunkte geteilt. 
      Die Samplepunkte werden duch Jittering des Mittelpunktes der Subpixel generiert.
    ]
  )

  // #grid(
  //   columns: (1fr, 1fr),
  //   [

  //   ], [
  //     #cetz.canvas(length: 3cm, {
  //       import cetz.draw: *
  //       import "@preview/suiji:0.5.1": *

  //       let rng = gen-rng-f(3924751384)
  //       let randX = (1, 2, 3)
  //       let randY = (1, 2, 3)

  //       let size = 1
  //       let pixelPerRow = 4

  //       line((0, 0), (pixelPerRow * size, 0), (pixelPerRow * size, pixelPerRow * size), (0, pixelPerRow * size), close: true, stroke: 2.5pt)

  //       let n = 1
  //       while n <= pixelPerRow {
  //         line((n * size, 0), (n * size, pixelPerRow * size))
  //         line((0, n * size), (pixelPerRow * size, n * size))

  //         let y = 0
  //         while y < pixelPerRow {
  //           let yY = y * size + size / 2
            
  //           let x = 0
  //           while x < pixelPerRow {
  //             let xX = x * size + size / 2
              
  //             (rng, randX) = integers-f(rng, low: -4, high: 5, endpoint: false)
  //             (rng, randY) = integers-f(rng, low: -4, high: 5, endpoint: false)

  //             let coord = (
  //               randX / 10 + xX, 
  //               randY / 10 + yY
  //             )
              
  //             circle((xX, yY), radius: 2.5pt, fill: gray, stroke: none)
  //             circle(coord, radius: 2.5pt)
  //             x += 1
  //           }

  //           y += 1
  //         }
          

  //         n += 1
  //       }
  //     })
  //   ]
  // )
]

#slide[
  = Diffuses / Stochastisches Raytracing
  #set align(horizon)

  *Glanz / Glossy Reflexion*
  - Casten mehrerer Reflexions-Rays
  - Zufällige Störung der Richtung der Reflexionen
  *Depth of Field / Tiefenschärfe*
  - Simulation eines weichen Fokus, Lens-Effekt
  *Motion Blur / Bewegungsunschärfe*
  - Animation der Szene
  - Raycast zu unterschiedlichen Zeitpunkten

  #set align(center)
  #image("../../Images/depth_of_field_motion_blur.png")
]

#chapter-title-slide(section-name: [Path Tracing])

#slide[
  = Path Tracing
  #set align(horizon)

  - Auch als _Monte-Carlo-Raytracing_ bezeichnet - Nutzt Monte-Carlo Integration
  - Simulation von globaler Beleuchtung (Global Illumination)
  - Berechnung vieler verschiedener Effekte in einem Prozess
    - Harte und weiche Schatten
    - Spiegel- oder Glanzreflektionen
    - Brechungen
    - Indirekte Beleuchtung
  
  *Nachteile*
  - Rauschen (besonders bei kleinen sehr hellen Lichtquellen)
    - Verschwindet mit steigender Anzahl der Pfade
    - Konvergiert zu einem sauberen Bild
  - Reines Path-Tracing ist oft zu langsam
]

#slide[
  = Path Tracing
  #set align(horizon)

  *Verfahren: Random Sampling*
  - Viele Strahlen zufällig in die Szene schießen
  - Beim Auftreffen auf Oberflächen werden diese entweder reflektiert, gebrochen oder absorbiert
    - Strahlenn suchen sich so den Weg durch die Szene
  - *Samples per Pixel* (*SPP*) entscheidend für Renderqualität
    - Je mehr Anfangsstrahlen verwendet werden, umso näher kommt man an das ideale Bild
    - Jedes weitere Sample trägt zum Durchschnitt aller für das Pixel berechneten Abtastwerte bei
    - Zusätzliche Qualität pro Sample verringert sich bei zunehmender SPP
]

#slide[
  = Path Tracing
  #set align(horizon)

  *Render Time*
  - Je länger gerendert, desto besser die Qualität
  - Bild anfangs verrauscht bei wenigen SPP
  - Abhängig von Beleuchtung der Szene, Pixelzahl und SPP des Renderers
  - Große gleichmäßige Beleuchtung führt schneller zu "gutem" Ergebnis als kleine, intensive Lichtquellen
]

#slide[
  = Path Tracing
  #set align(horizon)

  #grid(
    columns: (1fr, 1fr),
    [
      #image("../../Images/path_tracing_levels.png", width: 100%)
    ], [
      #grid(
        columns: (1fr),
        align: horizon,
        inset: 25pt,
        [
          *Oberes Bild* \
          Fertig gerendertes Bild mit Path Tracing und 65.536 Samples pro Pixel
        ], [
          *Untere Bilder* \
          Zoom bei gleicher Szene mit unterschiedlicher Anzahl an Samples pro Pixel.
          $ 1, 16, 256, 4096, 65536 $
          Rauschen ist selbst bei 4096 SPP noch vorhanden
        ]
      )
    ]
  )
]

#slide[
  = Path Tracing
  #set align(horizon)

  #figure(
    image("../../Images/path_tracing_example_1.png", width: 100%)
  )
]

#slide[
  = Path Tracing
  #set align(horizon)

  #figure(
    image("../../Images/path_tracing_example_2.png", width: 100%)
  )
]

#chapter-title-slide(section-name: [Photon Mapping])

#slide[
  = Photon Mapping
  #set align(horizon)

  - Genutzt als effizienzsteigernde Maßnahme in Raytracing
    - Effiziente Ermittlung der globalen Beleuchtung einer Szene
    - Realistische Bilder mit weniger Zeitaufwand
    - Particle-Tracing-Methode (Photon-Tracing)
  
  #showybox(
    frame: (
      border-color: hszg-green,
      thickness: 2.5pt,
      title-color: hszg-green.lighten(60%)
    ),
    title-style: (
      color: black,
      sep-thickness: 2.5pt,
    ),
    shadow: (
      color: black.lighten(50%)
    ),
    title: [*Begrifflichkeiten*],
    [
      - Photon: Simuliertes Lichtpaket
      - Leistung (Photon): Energie pro Zeiteinheit (Summe der phys. Photonen)
    ]
  )
  
  *Photon Map*
  - Von Geometrie unabhängige Datenstruktur
  - Photonen erlauben Abschätzung über eingehenden Strahlenfluss
]

#slide[
  = Photon Mapping
  == Verfahren
  #set align(horizon)

  - Photonen werden mit einer bestimmten Leistung werden von der Lichtquelle aus in die Szene Geschossen
  - Photon können an einer Oberfläche reflektiert, gestreut, gebrochen oder absorbiert werden
  - Auftreffen auf eine Oberfläche verändert die Leistung des Photons
  - Photon Map beinhaltet die Informationen über die globale Beleuchtung der Szene
  - Ermittlung der globalen Beleuchtung aus den Informationen über indirekte Beleuchtung aus Photon Map
  - Addiert mit direkter Beleuchtung aus diffusem Raytracing
]

// #slide[
//   = Photon Mapping
//   == Verfahren
//   #set align(horizon)

//   //TODO: Visualize 
// ]

#slide[
  = Vergleich von Raytracing
  #set align(horizon)

  #figure(
    image("../../Images/raytracing_comparison.png")
  )
]

#slide[
  = Beispiele
  #set align(horizon)

  - LuxCoreRender - Open Source Physically Based Renderer
  - Cycles (Blender) - Path Tracer
  - NVIDIA Mental Ray
  - Pixar Renderman

  #figure(
    image("../../Images/luxcorerender_example.png", width: 70%),
    caption: [
      LuxCoreRender
    ]
  )
]
