;  Ejemplo estrategias

;	Hechos iniciales

(deffacts hechos-iniciales 
	(hecho 1 )
	(hecho 2 )
	(hecho 3 )
	(hecho 4 )
	(hecho 5 )
	(hecho 6 )
)

; cuatro reglas




(defrule regla-1 "hechos 1-2-3"
	(hecho 1)
	(hecho 2)
	(hecho 3)
=>
	(assert (regla disparada 1))
)


(defrule regla-2 "hechos 3-2"
	(hecho 3)
	(hecho 2)
=>
	(assert (regla disparada 2))
)

(defrule regla-3 "hecho 2-6-4"
	(hecho 2)
	(hecho 6)
	(hecho 4)
=>
	(assert (regla disparada 3))
)

(defrule regla-4 "hecho 6-4-3-2"
	(hecho 6)
	(hecho 4)
	(hecho 3)
	(hecho 2)
=>
	(assert (regla disparada 4))
)
