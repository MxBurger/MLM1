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

#### Reales Experiment (d.h. am echten System) nicht möglich
- zu kostspielig
- benötigt zu viel Zeit
- zu schwierig (z.B. zu beobachten)
- zu riskant
- Experiment nicht rückgängig zu machen/irreversibel

>Simulation wenn:
>- ... ein Problem zu komplex ist, um es mit analytischen Methoden zu lösen
>- ... echte Experimente aus praktischen, zeitlichen, finanziellen, sicherheitstechnischen oder anderwertigen Gründen nicht durchführbar sind.
