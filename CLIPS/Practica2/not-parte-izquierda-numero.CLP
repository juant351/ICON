(deffacts numeros  (numero 2)(numero 5) (numero 10) (numero 20))

(defrule numero-mayor
	(numero ?x)
	(not (numero ?y&:(> ?y ?x)))
=>
	(printout t "El numero mayor es: " ?x  crlf)
)


