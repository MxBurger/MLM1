# Einleitung

## Modellbasiertes Problemlösen

![Modellbasiertes Problemlösen](img/ModellBasiertesProblemLoesen.svg)

- **Modellierung**: Die Modellierung ist der Prozess der Überführung eines realen Systems in ein abstraktes Abbild. Dabei werden die wesentlichen Eigenschaften und Verhaltensweisen des Systems in eine formale Darstellung übertragen. (*Bsp.: Differentialgleichung, Blockschaltbild*)
- **Abstraktion**: Bei der Abstraktion werden unwichtige Details weggelassen, um sich auf das Wesentliche zu konzentrieren. Es ist der Prozess der Verallgemeinerung, bei dem man von spezifischen Eigenschaften absieht und nur die für das Problem relevanten Aspekte betrachtet und somit zwei spezifisch unterschiedliche Dinge auf abstrakter Ebene als "gleich" betrachten kann. (*Bsp.: egal ob T-Rex oder Feuersalamander, im Modell sind beide Predator*)
- **Idealisierung**: Die Idealisierung vereinfacht komplexe Sachverhalte durch Annahme von perfekten oder idealen Bedingungen. Dabei werden beispielsweise Störfaktoren oder Ungenauigkeiten bewusst vernachlässigt, um ein klareres Modell zu erhalten. (*Bsp.: Messungenauigkeiten für eine Regelung werden vernachlässigt*)
- **Vereinfachung**: Bei der Vereinfachung werden komplexe Zusammenhänge auf ihre grundlegenden Beziehungen reduziert. Ziel ist es, das System handhabbarer zu machen, ohne die wichtigen Eigenschaften zu verlieren. (*Bsp.: Reibungsverluste werden vernachlässigt*)
- **Aggregation**: Die Aggregation fasst mehrere Einzelteile oder Details zu größeren Einheiten zusammen. Statt viele Einzelelemente zu betrachten, werden diese zu übergeordneten Gruppen oder Kategorien zusammengefasst, um die Komplexität zu reduzieren. (*Bsp.: Monatsumsatz statt Einzelverkäufe wird betrachtet*)

## Simulation
Computersimulation ist die Nachbildung realer Systeme mit Computern. Der Fokus dieser LVA liegt auf dynamischen Systemen, also solchen, die sich über die Zeit und/oder im Raum verändern können.

### Warum überhaupt Simulation?

#### Problem nicht analytisch lösbar
- Fragen können zwar formuliert werden, aber
- keine effektiven/effizienten Antworten/Lösungen können entwickelt werden
(*Effektiv* bedeutet, dass überhaupt eine funktionierende Lösung gefunden werden kann, die zum gewünschten Ziel führt - also die Wirksamkeit einer Lösung. (Eine ineffektive Lösung würde das Problem gar nicht lösen))
(*Effizient* bezieht sich darauf, wie gut die Ressourcen (Zeit, Rechenleistung, Kosten etc.) bei der Lösungsfindung genutzt werden - also die Wirtschaftlichkeit einer Lösung.)

#### Reales Experiment (d.h. am echten System) nicht möglich
- zu kostspielig
- benötigt zu viel Zeit
- zu schwierig (z.B. zu beobachten)
- zu riskant
- Experiment nicht rückgängig zu machen/irreversibel

>Simulation wenn:
>- ... ein Problem zu komplex ist, um es mit analytischen Methoden zu lösen
>- ... echte Experimente aus praktischen, zeitlichen, finanziellen, sicherheitstechnischen oder anderwertigen Gründen nicht durchführbar sind.

### Fragestellungen welche mit Simulation bearbeitet werden

1. Überprüfung von Hypothesen:
Testen und Validieren von Annahmen und Theorien durch Simulation
2. Vorhersage
Prognose zukünftiger Systemzustände und Entwicklungen
3. Verbesserung
Optimierung und Weiterentwicklung bestehender Systeme und Prozesse
4. Design/Gestaltung
Entwicklung und Planung neuer Systeme oder Komponenten
5. Lehre
Einsatz von Simulationen zu Ausbildungs- und Schulungszwecken
6. Unterhaltung
Verwendung von Simulationen für Spiele und Entertainment-Anwendungen (*GTA als Real Life Simulator* :D )

### Probleme der Modellierung und Simulation
- **Toy Duck Approach** bei der Modellierung
*"Wind it up and let it run"* Ein zu vereinfachter, oberflächlicher Ansatz ohne tieferes Verständnis des Systems wird gewählt.
-  **Modellgültigkeit**
Inwieweit sind die abgeleiteten Annahmen auf die reale Welt übertragbar? Frage nach der Validität und Übertragbarkeit der Simulationsergebnisse
- Es können **keine allgemeingültigen Aussagen** abgeleitet werden
Stattdessen nur eine Sammlung von Experimenten, die für einen spezifischen Kontext gültig sind. Die Ergebnisse sind kontextabhängig und nicht universell anwendbar.
- **Optimale Problemlösung** kann **nicht** garantiert werden
Es gibt keine Garantie, dass die durch Simulation gefundene Lösung tatsächlich optimal ist

### Anforderungen an die Durchführung einer Simulation
Korrekte, d.h. angemessene Realisierung/Implementierung in Bezug auf:
- Dynamisches Verhalten
- Keine Kausalitätsfehler
- Strategien zur Konfliktlösung (Zeitliche/Ressourcen Konflikte in der Implementierung oder im Modell)
- Angemessene numerische Methoden und Wahl der Schrittweite, z.B. zur Vermeidung von numerischen Ungenauigkeiten oder Instabilitäten
Die Simulation soll effizient durchgeführt werden können:
- Parallele, verteilte Ansätze

> In einer Simulation ist es wichtig, dass die modellierten Beziehungen zwischen Variablen oder Ereignissen auf echten Kausalzusammenhängen basieren und nicht nur auf beobachteten Korrelationen. **Korrelation**: Zwei Ereignisse treten gemeinsam auf oder zwei Variablen bewegen sich ähnlich. (*Wenn mehr Störche in einer Region sind, werden dort mehr Babys geboren*) **Kausalität**: Ein Ereignis ist tatsächlich die direkte Ursache für ein anderes. (*Wenn man Wasser erhitzt, steigt die Wassertemperatur*)

### Die zwei Hauptbereiche der Modellierung und Simulation

#### Kontinuierliche Modellierung und Simulation
- Gleichungsmodelle mit unendlich vielen Änderungen in jedem Zeitintervall
- Explizite Beziehungen zwischen Zuständen und Zeit (und daraus resultierende Unstetigkeiten) werden nicht berücksichtigt
![Kontinuierlich](img/Kontinuierlich.svg)

#### Diskrete Modellierung und Simulation
- In jedem Zeitintervall gibt es nur endlich viele relevante/interessante Änderungen
- Zustandsübergänge erfolgen zu präzisen Zeitpunkten
![alt text](img/Diskret.svg)

#### Anwendungsbereiche

| Kontinuierliche Simulation  | Diskrete Simulation   |
|---|---|
| Elektronik  | Produktions-Systeme  |
| Mechatronik  | Transport-Systeme  |
| Regelungstechnik  | Geschäftsprozesse  |
| Wetter-Berechnungen  | LAN-Simulation  |
| Wirtschafts-Modelle  | Logistik  |
| ...  | ...  |
