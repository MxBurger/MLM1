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

$
u(t) =
\begin{bmatrix}
U_1(t) \\
U_2(t)
\end{bmatrix}
$

$x_1 \ ' = 2 \cdot (U_1 + U_2)$
$x_2 \ ' = x_1 - U_2$
$x_3 \ ' = x_2$

$
y_1 = x_2 \\
y_2 = x_3
$

Zeilen sind Differentialgleichungen der Zustandsvariablen und Spalten die Koeffizienten der Zustandsvariablen

$A=
\begin{bmatrix}
0 \quad  0 \quad   0 \\
1 \quad 0 \quad 0 \\
0 \quad 1 \quad 0
\end{bmatrix}
$

Zeilen sind Differentialgleichungen der Zustandvariablen, Spalten sind Koeffizienten der Inputs

$B=
\begin{bmatrix}
2 \quad 2 \\
0  -1 \\
0 \quad 0
\end{bmatrix}
$

Zeilen sind die Outputs, KoeffizientenSpalten sind die Zustandsvariablen die sich gewichtet auf die Outputs auswirken

$C=
\begin{bmatrix}
0 \quad 1 \quad 0 \\
0 \quad 0 \quad 1
\end{bmatrix}
$

---

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

$
u(t) =
\begin{bmatrix}
U_1 \\
U_2 \\
U_3 \\
U_4
\end{bmatrix}
$

$x_1 \ ' = -5 \cdot U_1$
$x_2 \ ' = x_1 + x_2 + -2 \cdot U_2 + U_3 + U_4  $


Zeilen sind Differentialgleichungen der Zustandsvariablen und Spalten die Koeffizienten der Zustandsvariablen

$A=
\begin{bmatrix}
0 \quad  0  \\
1 \quad 1 
\end{bmatrix}
$

Zeilen sind Differentialgleichungen der Zustandvariablen, Spalten sind Koeffizienten der Inputs

$B=
\begin{bmatrix}
-5 \quad 0 \quad 0 \quad 0 \\
0 \ -2 \quad 1 \quad 1
\end{bmatrix}
$

Zeilen sind die Outputs, KoeffizientenSpalten sind die Zustandsvariablen die sich gewichtet auf die Outputs auswirken

$C=
\begin{bmatrix}
0 \quad 1 
\end{bmatrix}
$

---

## b)

### I)

$
x(t)=
\begin{bmatrix}
x_1(t) \\
x_2(t) \\
x_3(t)
\end{bmatrix}$

$
u(t) =
\begin{bmatrix}
U_1(t) \\
U_2(t) 
\end{bmatrix}
$

$x_1 \ ' = -x_2 + U_1 + 2 \cdot U_2 $
$x_2 \ ' = 2 \cdot x_1 -8 \cdot x_2 + 3 \cdot U_1 - 2 \cdot U_2 $
$x_3 \ ' = -2 \cdot x_1 + x_3 - U_1  + U_2$

$y_1 = x_1$
$y_2 = 2 \cdot x_2$
$y_3 = -x_2 + x_3$
$y_4= 3 \cdot x_2$

### II)

$
x(t)=
\begin{bmatrix}
x_1(t) \\
x_2(t)
\end{bmatrix}$

$
u(t) =
\begin{bmatrix}
U_1 \\
U_2
\end{bmatrix}
$

$x_1 \ ' = -x_1 + x_2 + 2 \cdot U_2$
$x_2 \ ' = x_1 + U_1 - 2 \cdot U_2$
$y = x_2$


## c)
- $A$ ist eine Quadrat-Matrix :white_check_mark:
- In der $B$-Matrix kann die Anzahl der Zeilen nicht stimmen, $B$ muss soviele Zeilen haben, wie es Zustandsvariablen gibt. :x:
- In der $C$-Matrix muss für jede Zustandsvariable eine Spalte existieren. :x:
- Es ist ein lineares System :white_check_mark: (zumindest in den Zeilen und Spalten die ersichtlich sind)

## d)

$
x(t)=
\begin{bmatrix}
a(t) \\
b(t) \\
c(t)
\end{bmatrix} =
\begin{bmatrix}
x_1(t) \\
x_2(t) \\
x_3(t)
\end{bmatrix}$

$
u(t)=
\begin{bmatrix}
i_1(t) \\
i_2(t)
\end{bmatrix} =
\begin{bmatrix}
U_1(t) \\
U_2(t) \\
\end{bmatrix}$

$x_1 \ ' = 2 \cdot x_1 + 4 \cdot x_2 - 2 \cdot x_3 + 2 \cdot U_1 $
$x_2 \ ' = 4 \cdot x_2 - x_3 + U_2$
$x_3 \ ' = - x_3 + 3 \cdot U_1 $

$y_1 = 3 \cdot x_1$
$y_2 = - x_2$
$y_3 = x_1 - x_3 $



Zeilen sind Differentialgleichungen der Zustandsvariablen und Spalten die Koeffizienten der Zustandsvariablen

$A=
\begin{bmatrix}
2 \quad  4 \quad   -2 \\
0 \quad 4 \quad -1 \\
0 \quad 0 \quad -1
\end{bmatrix}
$

Zeilen sind Differentialgleichungen der Zustandvariablen, Spalten sind Koeffizienten der Inputs

$B=
\begin{bmatrix}
 2 \quad 0 \\
 0 \quad 1 \\
 3 \quad 0 \\
\end{bmatrix}
$

Zeilen sind die Outputs, KoeffizientenSpalten sind die Zustandsvariablen die sich gewichtet auf die Outputs auswirken

$C=
\begin{bmatrix}
3 \quad 0 \quad 0 \\ 
0 \quad -1 \quad 0\\
1 \quad 0 \quad -1
\end{bmatrix}
$