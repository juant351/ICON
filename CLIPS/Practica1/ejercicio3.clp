; PRIMERA PRACTICA. Ejercicio 3.
; Sergio Sanz Sanz.
; Juan Torres Viloria.


; PETICION DE ESCENARIO AL USUARIO.
(defrule escenario "sintomas observados"
	(declare (salience 1000))
	=>
	(printout T crlf "BIENVENIDO" crlf)
	(printout T "ESCENARIO 1: Motor no arranca y el indicador de batería marca 0" crlf)
	(printout T "ESCENARIO 2: Motor se para y el indicador de combustible marca 0" crlf)
	(printout T crlf "Eliga escenario (1 o 2): " crlf)
	(assert (escenario = (read T)))
)

; IMPRESION POR PANTALLA DE LA(S) CAUSA(S) DEL FALLO.
(defrule causa-fallo "la causa del fallo es:"
	(declare (salience -1000))
	(causa fallo ?x)
	=>
	(printout T crlf "La causa del fallo es: " ?x crlf)
)

; EN CASO DE SER EL ESCENARIO 1.
(defrule escenario-1 "escenario 1"
	(escenario 1)
	=>
	(assert (bateria indicador 0))
	(assert (motor comportamiento "no arranca"))
)

; EN CASO DE SER EL ESCENARIO 2.
(defrule escenario-2 "escenario 2"
	(escenario 2)
	=>
	(assert (combustible indicador 0))
	(assert (motor comportamiento "se para"))
)

; REGLAS INTERMEDIAS.
; POTENCIA
(defrule potencia-falla "estado potencia"
	(motor comportamiento "no arranca")
	=>
	(assert (motor potencia 0))
)

; COMBUSTIBLE 1 (MOTOR NO ARRANCA)
(defrule combustible-falla1 "estado combustible si motor no arranca"
	(motor comportamiento "no arranca")
	=>
	(assert (motor combustible 0))
)

; COMBUSTIBLE 2 (MOTOR SE PARA)
(defrule combustible-falla2 "estado combustible si motor se paea"
	(motor comportamiento "se para")
	=>
	(assert (motor combustible 0))
)

; REGLAS FINALES.
; FUSIBLE
(defrule fusible-falla "estado fusible"
	(fusible estado roto)
	(motor potencia 0)
	=>
	(assert (causa fallo "fusible fundido"))
)

; BATERIA
(defrule bateria-falla "estado bateria"
	(bateria indicador 0)
	(motor potencia 0)
	=>
	(assert (causa fallo "bateria baja"))
)

; DEPOSITO
(defrule deposito-falla "estado deposito"
	(combustible indicador 0)
	(motor combustible 0)
	=>
	(assert (causa fallo "deposito vacio"))
)










