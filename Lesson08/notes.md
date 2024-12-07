# Exponential Growth and Decay

discrete
```
x(n+1) = x(n) * ɑ
x(n) = x0 * ɑ^n
```

cont
```
x(t) = x0 * e^βt
β = ln(ɑ)
```

```
x'(t) = x(t) * ln(β)
```


# Predator and Prey

```
b'(t) = ɑb(t)-βb(t)r(t)
r'(t) = -ɤr(t)+δb(t)r(t)

ɑ... growth rate
β... consumption rate
ɤ... mortality
δ... reproduction rate


wenn 

b'=0
r't=0

ɑb=βbr
b==
ɑ=βr
r= ɑ/β

```

## Predator Prey with external factors


```
b'(t) = ɑb(t)-βb(t)r(t) - ɛ1b
r'(t) = -ɤr(t)+δb(t)r(t) - ɛ2r

ɑ... growth rate
β... consumption rate
ɤ... mortality
δ... reproduction rate

ɑp = ɑ - ɛ1
ɤp = ɤ - ɛ2

ɑp... alpha with pesticides
ɤp... gamma with pesticides
```

## Predator Prey with Limit Cycles

```
b'(t) = b(ɑ1(1-(b/ɑ2)-ɑ3 * (r(t)/b(t)+ɑ4)))
      = b(ɑ1-(ɑ1*b / ɑ2)- (ɑ3*r/b+ɑ4))
      = ɑ1b - (ɑ1/ɑ2)b^2 - b*r*(ɑ3 / (b + ɑ4))

... ɑ1b ... reproduction
... ɑ1b - (ɑ1/ɑ2)b^2 ... logistic growth
... ɑ3 / (b + ɑ4) ... 


ɑ1... growth rate
ɑ2... carrying capacity of the system
ɑ3... consumption rate ( how much do the  predators consume prey)
ɑ4... saturation constant for consumption

r'(t) = r * ɑ5 (1- ɑ6 * (r/b))
ɑ5... reproduction
ɑ6... how much dependes the r on b
```