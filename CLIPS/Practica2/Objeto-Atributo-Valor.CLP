(deftemplate   oav-u
	(slot objeto (type SYMBOL))
	(slot atributo(type SYMBOL))
	(slot valor)
)

(deftemplate   oav-m
	(slot objeto (type SYMBOL))
	(slot atributo(type SYMBOL))
	(slot valor)
)

(deffacts hechos-supuestamente-univaluados

(oav-u (objeto Juan)
		     (atributo edad)
		     (valor 35))
(oav-u (objeto Juan)
		     (atributo edad)
		     (valor 45))
)

(defrule univaluar-hechos
	?x <- (oav-u)
	?y <- (oav-u)
	(test(neq ?x ?y))
	=>
	(retract ?y)
)