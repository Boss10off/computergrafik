#import "../../Template/definitions.typ": *
#import "../../Template/template.typ": *

#chapter-title-slide(section-name: [Partikelsysteme])

#slide[
  = Partikelsysteme
  #set align(horizon)

  Partikelsysteme sind eine Technik der Computergrafik, um bestimmte Fuzzy-Phänomene zu simulieren, die mit herkömmlichen Rendering-Techniken nur sehr schwer darstellbar sind \

  z.B.: Feuer, Explosionen, Rauch, fließendes Wasser, Funken, fallende Blätter, Wolken, Nebel, Schnee, Staub, Meteoritenschweife oder abtrakte visuelle Effekte wie Leuchtspuren usw.

  #figure(
    image("../../Images/particle_systems_examples.png", width: 60%)
  )
]

#slide[
  = Partikelsysteme
  #set align(horizon)

  - Ein Objekt wird als #text(weight: "bold")[Menge]/Wolke von primitiven Partikeln dargestellt, die sein Volumen definieren, anstatt durch Polygone oder Flächen, die seine Begrenzung definieren
  - Ein Partikelsystem ist *dynamisch*
  - Die Partikel bewegen sich im Laufe der Zeit
  - Das Objekt ist *nicht deterministisch*
  - Seine Form und Gestalt sind nicht vollständig festgelegt
]

#slide[
  = Historie
  #set align(horizon)

  #showybox(
    title: [
      Particle Dreams by Karl Sims (1988)
      #link("https://www.youtube.com/watch?v=E3G29zYlfDs&pp=ygUcUGFydGljbGUgRHJlYW1zIGJ5IEthcmwgU2ltcw%3D%3D")[#text(fill: hszg-green.darken(50%))[YouTube $arrow$]]
    ],
    frame: (
      title-color: hszg-green,
      border-color: hszg-green,
      body-color: hszg-green.lighten(90%),
      thickness: 2.5pt
    ),
    title-style: (
      color: black
    ),
    shadow: (
      offset: 5pt
    ),
    text(weight: "light")[
      This piece contains a collection of dream sequences created using 3D particle systems techniques. 
      Behavior rules are applied to thousands of individual particles to model complex phenomena such as an explosion, a snowstorm, a tumultuous head, and a waterfall. 
      Data-parallel computation was used to perform physical simulations on thousands of particles simultaneously, one processor \[of a Connection Machine CM-2\] for each particle.
    ]
  )

  #figure(
    image("../../Images/particle_systems_history.png")
  )
]

#slide[
  = Eigenschaften
  #set align(horizon)

  - Initial Position
  - Initial Velocity
  - Initial Size
    - $"InitialSize" eq "MeanSize" plus "rand" times "VarSize"$
  - Initial Color
  - Initial Transparency
  - Shape
  - Lifetime
]

#slide[
  = Basismodell
  #set align(horizon)

  - Partikel werden durch Prozesse mit einem Element des Zufalls erzeugt
  *1. Möglichkeit die Anzahl der erzeugten Partikel zu steuern:*
  - Durchschnittlichen Wert pro Frame festlegen
  - Durch Zufall den Wert abweichen lassen
  $ 
    N "parts"_(f) eq "MeanParts"_(f) plus "Rand"() times "VarianceParts"_(f)  
  $

  *2. Möglichkeit die Anzahl der erzeugten Partikel zu steuern:*
  - Anzahl von Partikeln pro Bildschirmfläche erzeugen:
    - Damit hängt die Anzahl der Partikel von der Bildschirmfläche ab
    - Es ist nicht nötig, tausende Partikel für wenige Pixel Flächen zu erzeugen
  
  $
    N "parts"_(f) eq ("MeanParts"_(f) plus "Rand"() times "VarianceParts"_(S A f)) times "ScreenArea"
  $
]

#slide[
  = Generierung
  #set align(horizon)

  Das Partikelsystem generiert Partikel auf Basis der Grundfläche und zufällig variierenden Werten, wie bspw:
    - Geschwindigkeit
    - Beschleunigung
    - Richtung 
    - ...

  #figure(
    image("../../Images/particle_systems_parameters.png", width: 50%)
  )
]

#slide[
  = Dynamik
  #set align(horizon)

  Die Position eines Teilchens wird durch einfache Addition seines Geschwindigkeitsvektors zu seinem Positionsvektor ermittelt \
  #text(weight: "light")[
    $arrow$ Dies kann durch Kräfte wie die Schwerkraft verändert werden
  ]

  Auch andere Attribute können sich im Laufe der Zeit ändern, z.B.: Farbe, Transparenz und Größe \
  #text(weight: "light")[
    $arrow$ Diese Änderungsdaten können global oder stochastisch für jeden Partikel sein
  ]
]

#slide[
  = Löschung
  #set align(horizon)

  - Bei der Erzeugung erhält ein Teilchen eine *Lebensdauer* in Frames
  - Lebensdauer des Partikels wird bei jedem Frame dekrementiert
  - Partikel wird getötet, wenn seine Lebenszeit $0$ erreicht
  - Partikel können auch getötet werden, wenn sie nicht mehr zum Bild beitragen (Transparenz unter einem bestimmten Schwellenwert, etc.)
]

#slide[
  = Rendering
  #set align(horizon)

  Jedes Partikel rendern
  - als einzelnes Pixel
  - als texturiertes Billboard-Quad (d.h.: Viereck, das immer dem Betrachter zugewandt ist) oder Sprite
  - als statisches (Trümmer) oder animiertes (Boids) Mesh (_solid particle system_)
  - als Metaball (für flüssige Oberflächen)
  - als Liniensegment $arrow$ Bewegungsunschärfe
]

#slide[
  = Billboard Quads
  #set align(horizon)

  #grid(
    columns: (1fr, 1fr),
    align: top,
    inset: 10pt,
    figure(
      image("../../Images/particle_system_untextured.png"),
      caption: [
        Untexturiertes Partikelsystem
      ]
    ),
    figure(
      image("../../Images/particle_system_textured.png"),
      caption: [
        Texturiertes Partikelsystem mit semitransparenten Texturen
      ]
    )
  )
]

#slide[
  = Mesh
  #set align(horizon)

  #grid(
    columns: (1fr, 1fr),
    inset: 10pt,
    stroke: 2.5pt + hszg-green,
    fill: (x, y) => {
      if y == 0 {
        return hszg-green
      } else {
        return hszg-green.lighten(90%)
      }
    },
    grid.cell()[#text(weight: "bold")[Static Mesh]], 
    grid.cell()[#text(weight: "bold")[Metaballs]],
    grid.cell()[
      #figure(
        image("../../Images/static_mesh_particles.jpg")
      )
    ],
    grid.cell()[
      #figure(
        image("../../Images/metaballs_particles.png")
      )
    ], 
  )
]

#slide[
  = Haare
  #set align(horizon)

  Stilles Rendering von Haar/Gras
  - es wird die gesamte Flugbahn eines Partikels über seine Lebensdauer gerendert, um ein statisches Bild zu erzeugen
  - den Partikeln werden grüne und dunkelgrüne Farben zugewiesen, die auf der Grundlage der Lichtquellen der Szene schattiert werden
  - jedes Partikel wird zu einem Grashalm bzw. Haar

  #set align(center)
  #image("../../Images/hair_particles.png", fit: "contain")
]

#chapter-title-slide(section-name: [Forces])

#slide[
  = Forces
  #set align(horizon)

  - Kräfte können die Dynamik im Partikelsystem extern ändern
  - Unäre Kräfte - Kräfte, die nur von einem Partikel abhängen

  #grid(
    columns: (1fr, 1fr, 1fr),
    align: center + top,
    inset: 15pt,
    [
      #image("../../Images/gravity_forces.png", fit: "contain", width: 80%)
    ], [
      #image("../../Images/drag_forces.png", fit: "contain", width: 80%)
    ], [
      #image("../../Images/wind_forces.png", fit: "contain", width: 80%)
    ],
    [*Gravity*], [*Dampening*], [*Wind Fields*],
    [$f eq m g$], [$f_("drag") eq -k_(d) V$], [$f eq k v_("wind")$]
  )
]

#slide[
  = Forces
  #set align(horizon)

  - Teilchen interagieren, wenn sie sich nahe beieinander befinden, hören auf zu interagieren, wenn sie sich auseinander befinden, hören auf zu interagieren, wenn sie sich auseinander bewegen (_räumliche Kräfte_)
  - Kosten $O(n^(2))$ in Anzahl der Partikel - räumliche Datenstrukturen können Berechnungen optimieren

  #figure(
    image("../../Images/space_data_structure.png")
  )
]

#slide[
  = Forces
  #set align(horizon)

  - Anwendung von Nutzerinteraktion durch Federn
  - *Benutzer-Interaktionskräfte* - Kräfte, die der Benutzer auf Partikel ausübt (z.B.: mit der Maus, um ein Partikel zu greifen und zu bewegen)

  #figure(
    image("../../Images/force_spring.png")
  )
]

#chapter-title-slide(section-name: [Kollisionen])

#slide[
  = Kollisionen
  #set align(horizon)

  - Bestimmen, wann ein Teilchen mit einer Ebene kollidiert ist (z.B.: Boden oder Wand)
  - Raytracing für sehr komplexe Formen
  - Was sollen wir tun, wenn ein Teilchen kollidiert ist?
  - Richtig ist es, die Simulation bis zum genauen Berührungspunkt zurückzurollen
  - Einfacher ist es, nur Positionen und Geschwindigkeit zu ändern

  #figure(
    image("../../Images/collission.png")
  )
]

#chapter-title-slide(section-name: [Blender])

#slide[
  = Partikelsysteme in Blender
  #set align(horizon)

  - zur Darstellung ungeordneter Systeme
    - Feuer, Rauch, Explosionen, Wolken, Flüssigkeiten, Regen, Schnee, Nebel, Gras, Haare, ...
  - Partikel $eq$ Punkt im Raum (keine räumliche Ausdehnung)
    - kann (u.a. phyikalische) Eigenschaften besitzen
      - Initiale Positionen
      - Geschwindigkeit + Richtung
      - Lebensdauer
      - Größenparameter, Rotationsparameter
      - Farbe, Form, Kindobjekte
    - Eigenschaften häufig sehr zufällig
]

#slide[
  = Partikelsysteme in Blender
  #set align(horizon)

  - *Partikel* werden von *Emitter* ausgedehnt
    - Neu erzeugten Partikeln werden (zufällige) Eigenschaften zugewiesen
    - Partikel können aufeinander (und ggf. die Umwelt) reagieren/kollidieren (Dynamik)
  - *Emitter* kann ein Punkt oder ein Mesh sein

  #figure(
    image("../../Images/blender_particle_systems.png", width: 60%)
  )
]

#slide[
  = Partikelsysteme in Blender
  #set align(horizon)

  - Objekt auswählen, welches Emitter sein soll
  - Partikelsystem im entsprechenden Tab hinzufügen
  - "Advanced" Option bietet mehr Kontrolle
  - Definition der Partikelform
    - *Halo*: Rendert jedes Objekt als leuchtenden Punkt oder Wolken aus Licht
    - *Objekt*: Referenzobjekt für jedes Partikel
    - Line, Path, Collection
  - *Hair Dynamics* + *Physics* für realistische Haarsimulation
  - Vertex Group per Weight Painting erstellen, um den Einflussbereich des Emitters zu definieren
]

#slide[
  = Partikelsysteme in Blender
  #set align(horizon)

  - kann für strähnenartige Objekte wie Haare, Fell, Gras, Federkiele usw. verwendet werden
  - sind definiert durch Menge, Länge, Physik und Styling
  - Cycles: Hair BSDF, Principled Hair BSDF

  #figure(
    image("../../Images/blender_sheep.png")
  )
]

#slide[
  = Partikelsysteme in Blender
  #set align(horizon)

  #grid(
    columns: (1fr, 0.8fr),
    inset: 10pt,
    [
      - Emitter-System emittiert/produziert Partikel für eine bestimmte Zeit
      - Partikel werden standardmäßig als Halos gerendert
      - definiert durch Number Seed, Frame Start/End, Lifetime und Source
      - Force Fields beeinflussen Verlauf der Partikel
    ], [
      #image("../../Images/blender_trail.png")
    ]
  )
]

#chapter-title-slide(section-name: [Zusammenfassung])

#slide[
  = Zusammenfassung
  #set align(horizon)

  - Systeme, die zur Modellierung vieler Naturphänomene verwendet werden
    - Flüssigkeiten, Rauch, Feuer, Explosionen, Nebel, ...
  - Computergrafik
    - Filme, Spiele
    - Fokus auf visuelle Darstellung, Echtzeitberechnungen
  - Partikelsysteme in Naturwissenschaften und Technik
    - Schwerpunkt auf realistischer Simulation z.B.: Computational Fluid Dynamics
    - Berechnungen nicht unbedingt in Echtzeit
]

#slide[
  = Zusammenfassung
  == Physics
  #set align(horizon)

  - Physiksimulation (Flüssigkeiten, Rauch, Kollision, Deformation, ...)
    - Rigid Body
    - Cloth Simulation
    - Fluid & Smoke
    - Particle Systems
  - Baking von physikalischen Simulationen
    - Caching der Simulationsberechnungen
    - Cache ist protected $arrow$ geringere Runtime, dafür müssen Änderungen rebaked werden
  - *Blender*: Physics Properties im Properties-Panel
]

#slide[
  = Zusammenfassung
  == Physics
  #set align(horizon)

  - Physiksimulationen: viele Einstellmöglichkeiten, verschiedene Objektanpassungen nötig (z.B.: Subdivisions)
  - seit Blender v2.82: Fluidsim mit MantaFlow

  #figure(
    image("../../Images/blender_fluid.png", width: 80%)
  )
]
