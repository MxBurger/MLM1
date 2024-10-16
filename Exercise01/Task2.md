# Task 2 (8 pt): … and a bit of Practice

$x(t)...Wasservolumen \space zum \space Zeitpunkt \space \bold{t}$
$x(0)...Initiales \space Wasservolumen \space [l]$

$x'(t) = \space ?$

Vorgehensweise: Aufteilen des Modells in $\bold{I} \space prozentuelle Abnahme$ und $\bold{II} \space konstanter Zufluss$.

$\bold{I:} \space 5\% \space Abnahme$:
$x(t)=x(0)*0.95^t$
$x(t)=x(0)*e^{ln(0.95)*t}$
$x'(t)=x(0)*e^{ln(0.95)*t}*ln(0.95)$
$x'(t)=x(0)*ln(0.95)$

$\bold{II:} \space 1000l \space konstanter \space Zufluss \space 1000l/h$:
$x'(t)=1000$

Führen nun beide Modelle zusammen lässt sich folgende Gleichung aufstellen:

$x'(t)=x(t)*ln(0.95)+1000$

---

Für die Simulation kann folgende Iterationsvorschrift erstellt werden:
$tStep...Schrittweite \space der \space Simulation$
1. Ermittle die Steigung $x'(0)$ (Initialwert) mit der oben aufgestellten Gleichung
2. Wende die ermittelte Steigung an, um den Wert des ersten Iterationsschrittes zu erhalten:
$x(0 + tStep)$ (erster Iterationsschritt) entspricht dann $x(0) + x'(0)*tStep$
3. Ermittle für den ermittelten Wert erneut die Steigung und multipliziere sie mit $tStep$. Wende die nun mit $tStep$ korrigierte Steigung auf das aktuelle $x(t)$ an und erhalte das Ergebnis der nächsten Iteration.
4. Wiederhole Schritt **3** bis zur gewünschten Iterationstiefe

Dieses Verfahren ist allgemein bekannt unter *explizites Eulerverfahren*.

---
## Ergebnisse

Ergebnis mit $tStep=1.0$
![alt text](Pictures/tStep1_0.png)

$Equilibrium...19495.72575l$
Erreicht nach ~430 Iterations-Schritten -> ~430h

---

Ergebnis mit $tStep=0.5$
![alt text](Pictures/tStep0_5.png)
$Equilibrium...19495.72575l$
Erreicht nach ~885 Iterations-Schritten -> ~442.5h

---

Ergebnis mit $tStep=0.1$
![alt text](Pictures/tStep0_1.png)
$Equilibrium...19495.72575l$
Erreicht nach ~4460 Iterations-Schritten -> ~446h


>Für die Feststellung des Equilibriums wurden 5 Nachkommastellen betrachtet.
