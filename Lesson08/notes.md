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