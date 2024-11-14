# Aufgabe 1
## a)
### I)
$x(t)=
\begin{bmatrix}
z(t) \\
v(t) \\
x(t)
\end{bmatrix} =
\begin{bmatrix}
x_1(t) \\
x_2(t) \\
x_3(t)
\end{bmatrix}$

$x_1 \ ' = 2 \cdot (U_1 + U_2)$
$x_2 \ ' = x_1 - U_2$
$x_3 \ ' = x_2$

Zeilen sind Differentialgleichungen der Zustandsvariablen und Spalten die Koffezienten der Zustandsvariablen

$A=
\begin{bmatrix}
0 \quad  0 \quad   0 \\
1 \quad 0 \quad 0 \\
0 \quad 1 \quad 0
\end{bmatrix}
$

Zeilen sind Differentialgleichungen der Zustandvariablen, Spalten sind Koffezienten der Inputs

$B=
\begin{bmatrix}
2 \quad 2 \\
0  -1 \\
0 \quad 0
\end{bmatrix}
$

Zeilen sind die Outputs, Spalten sind die Zustandsvariablen die sich auf die Outputs auswirken

$C=
\begin{bmatrix}
0 \quad 1 \quad 0 \\
0 \quad 0 \quad 1
\end{bmatrix}
$

### II)
$x(t)=
\begin{bmatrix}
z(t) \\
x(t)
\end{bmatrix} =
\begin{bmatrix}
x_1(t) \\
x_2(t) 
\end{bmatrix}$

$x_1 \ ' = -5 \cdot U_1$
$x_2 \ ' = x_1 + x_2 + -2 \cdot U_2 + U_3 + U_4  $


Zeilen sind Differentialgleichungen der Zustandsvariablen und Spalten die Koffezienten der Zustandsvariablen

$A=
\begin{bmatrix}
0 \quad  0  \\
1 \quad 1 
\end{bmatrix}
$

Zeilen sind Differentialgleichungen der Zustandvariablen, Spalten sind Koffezienten der Inputs

$B=
\begin{bmatrix}
-5 \quad 0 \quad 0 \quad 0 \\
0 \ -2 \quad 1 \quad 1
\end{bmatrix}
$

Zeilen sind die Outputs, Spalten sind die Zustandsvariablen die sich auf die Outputs auswirken

$C=
\begin{bmatrix}
0 \quad 1 
\end{bmatrix}
$


## b)

### II)
$x_1 \ ' = -x_1 + x_2 + 2 \cdot U_2$
$x_2 \ ' = x_1 + U_1 - 2 \cdot U_2$
$y = x_2$


## c)
In der $B$-Matrix kann die Anzahl der Zeilen nicht stimmen, $B$ muss soviele Zeilen haben, wie es Zustandsvariablen gibt. In der $C$-Matrix muss für jede Zustandsvariable eine Spalte existieren. 

