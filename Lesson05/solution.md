# Task  1
##### a) Use SIMULINK to model the landing of a moon landing unit, as formulated in the lecture notes(idealized and simplified). Assume an initial descent rate of 10 m/s and an initial altitude of 1000 m; the braking force of the two available braking stages are 42,000 N and 34,000 N, respectively, and the mass of the lander is 20,000 kg. Determine optimal start and end times for the braking phases by means of simulation-controlled optimization; document your optimal results in terms of landing time and speed at touchdown.

![alt text](1a.png)

![alt text](1a_scope.png)

![alt text](1a_thrust.png)

Mit:
- $t_1=13.75$
- $t_2=65$
- $t_3=35.25$
- $t_4=44$

kann eine Landung nach $47.6s$ mit $-1.6\ m/s$ erreicht werden.
Verwendete Simulationsparameter:
- Solver: *ode4 (Runge-Kutta)*
- Fixe Schrittweite mit *0.01*
- Startzeit: *0.0*
- Stopzeit: *100.0*


##### b) Do changes of the solver (settings) significantly change the simulation result? Document changes by using other integration methods and changing step size settings. Discuss your results.

Ja, die Änderungen haben tatsächlich signifkante Auswirkungen.

###### Landung nach $n$ Sekunden

|Solver/ Schrittweite $[s]$| Euler  | Heun   | Bogacki-Shampine | Runge-Kutta | 
|---|---|---|---|--- |
|_0.001_|  47.600 | 47.900  | 47.600  | 47.604 |
|_0.01_| 47.608  | 47.921  | 47.604  |47.700 |
|_0.1_| 45.534  | 47.800  | kein Touchdown (minimale Höhe 0.4m nach 50.723s)   | kein Touchdown (minimale Höhe 0.9m nach 50.698s) |

Mit variabler Schrittweite und automatischer Solver-Auswahl in Matlab konnte die Landung nach 47.676s erzielt werden.

###### Geschwindigkeit bei der Landung in $m/s$

|Solver/ Schrittweite $[s]$| Euler  | Heun   | Bogacki-Shampine | Runge-Kutta | 
|---|---|---|---|--- |
|_0.001_|  -1.593  | -1.441 | -1.6006  | -1.609  |
|_0.01_| -1.589 | -1.432  | -1.604  | -1.554 |
|_0.1_| -2.600 | -1.431 | kein Touchdown (Geschwindigkeit im Wendepunkt sinngemäß 0) | kein Touchdown (Geschwindigkeit im Wendepunkt sinngemäß 0)  |

Mit variabler Schrittweite und automatischer Solver-Auswahl in Matlab konnte die Landung mit -1.574 m/s erzielt werden.

###### Interpretation

- **Einfluss der Schrittweite:**
    - Bei kleinen Schrittweiten (0.001s und 0.01s) liefern alle Methoden ähnliche Ergebnisse
    - Bei größerer Schrittweite (0.1s) versagen einige Methoden komplett
        - Bogacki-Shampine und Runge-Kutta erreichen gar keine Landung mehr
        - Euler und Heun liefern deutlich abweichende Ergebnisse
- **Vergleich der Methoden:**
    - Euler als einfachste Methode zeigt die größten Abweichungen
    - Heun ist stabiler als Euler, aber weniger genau als Bogacki-Shampine/Runge-Kutta
    - Bogacki-Shampine und Runge-Kutta liefern die konsistentesten Ergebnisse bei kleinen Schrittweiten
- **Genauigkeit vs. Rechenaufwand:**
    - Kleinere Schrittweiten führen zu genaueren Ergebnissen, benötigen aber mehr Rechenzeit
    - Die Wahl von 0.01s erscheint als guter Kompromiss zwischen Genauigkeit und Effizienz
- **Variable Schrittweite:**
    - auch mit variabler Schrittweite wird eine Landung mit plausiblen Werten erreicht
    - Dies zeigt, dass auch adaptive Methoden gute Ergebnisse liefern können

Diese Ergebnisse unterstreichen die Bedeutung der richtigen Wahl von Solver und Schrittweite für die Genauigkeit und Stabilität der Simulation.


##### c) Assume that braking leads to a decrease of the mass of the lander (factor 0.001). Adapt your model accordingly and document changes regarding the landing oft he landing unit. Again, determine optimal braking parameters (start / end times) and document new landing times and velocities.

Für die Abnahme der Masse durch Treibstoff-Verbrauch wird folgende Formel herangezogen.

$c \dots 0.001 $

$\frac{dm}{dt}=-(c \cdot thrust_1 + c \cdot thrust_2)$ 

###### Neues Blockschaltbild
![alt text](1c_blocks.png)
###### Masse-Abnahme durch Betätigung der Thruster
![alt text](1c_fuel_dec.png)
###### Lande-Versuch mit unkorrigierten Parametern aus 1a)
![alt text](1c_original_parameter.png)

Aufgrund der unangepassten Parametern und der nun verringerten Masse wird vorerst keine Landung erreicht.
Danach prallt der LunarLander mit ca 28.5m/s auf die Oberfläche. RIP Astronauten, ihr starbt für die Wissenschaft.


# Task 2
##### a) Implement an evolutionary optimization algorithm (in MATLAB) based on an ES, which optimizes the lunar landing of Task 1.

##### b) Which algorithmic parameter sets lead to rather good, which leads to rather bad results? How do you quantify the quality of such an optimization run? Does the adaptation of the mutation width affect the quality of the optimization? How, why? Discuss your results! How does the population size affect the results? How well does the μ+λ ES work here, how good the μ,λ ES? Document your results with different parameter settings, show statistics (graphics, tables) 