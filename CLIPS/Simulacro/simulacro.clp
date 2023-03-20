; SIMULACRO EXAMEN CLIPS
; TORRES VILORIA JUAN.


; DEFINICIÓN ESTRUCTURA HECHOS UNIVALUADOS
(deftemplate oav-u "Plantilla Hechos univaluados"
	(slot objeto (type SYMBOL))
	(slot atributo(type SYMBOL))
	(slot valor)
)

; DEFINICIÓN ESTRUCTURA HECHOS MULTIVALUADOS.
(deftemplate oav-m "Plantilla Hechos multivaluados"
	(slot objeto (type SYMBOL))
	(slot atributo(type SYMBOL))
	(multislot valor)
)

; REGLA QUE GARANTIZA QUE LOS OAV-U SEAN REALMENTE UNIVALUAADOS
; Para ello se queda con la última entrada del oav-u.
(defrule garantizar-univaluados
    (declare (salience 10000))
    ?x <- (oav-u (objeto ?o1) (atributo ?a1) (valor ?v1))
    ?y <- (oav-u (objeto ?o1) (atributo ?a1) (valor ?v2))
    (test (> (fact-index ?x) (fact-index ?y)))
=>
(retract ?y)
)

; PETICIÓN DE ESCENARIO AL USUARIO.
(defrule escenario "dispositivo a revisar"
	(declare (salience 1000))
=>
	(printout T crlf "BIENVENIDO" crlf)
	(printout T crlf "ESCENARIO 1: Dispositivo a revisar es MÓVIL.")
	(printout T crlf "ESCENARIO 2: Dispositivo a revisar es TABLET.")
	(printout T crlf "ESCENARIO 3: Dispositivo a revisar es PORTÁTIL." crlf)
	(printout T crlf "Eliga un escenario ( 1 | 2 | 3 ): ").
	(assert	(oav-u
			(objeto escenario)
			(atributo numero)
			(valor = (read T))))
)

; IMPRIMIR POR PANTALLA EL DIAGNOSTICO EN CASO DE HABER PROBLEMA(S).
(defrule resultado-diagnostico "informar al usuario del diagnostico"
	(declare (salience -1000))
	(oav-m
		(objeto ?dispositivo)
		(atributo problema)
		(valor ?problema))
=>
	(printout T crlf "DIAGNÓSTICO:" crlf)
	(printout T "El dispositivo " ?dispositivo " presenta un problema de " ?problema "." crlf)
)

; IMPRIMIR POR PANTALLA SI NO SE LLEGA A UN DIAGNÓSTICO.
(defrule no-se-llega-a-diagnostico "ha pasado la revision pero no se ha llegado a un diagnóstico"
	(declare (salience -1000))
	(oav-u
		(objeto ?dispositivo)
		(atributo revisable)
		(valor TRUE))
	(not	(oav-m
			(objeto ?dispositivo)
			(atributo problema)))
=>
	(printout T crlf "DIAGNÓSTICO:" crlf)
	(printout T "El dispositivo " ?dispositivo " ha pasado la revisión pero no se ha podido llegar a un diagnóstico." crlf)
)
; SI HAY QUE REVISAR MÓVIL (ESCENARIO 1).
(defrule revisar-movil "dispositivo a revisar es el móvil"
	(oav-u
		(objeto escenario)
		(atributo numero)
		(valor 1))
=>
	(assert (oav-u
			(objeto movil)
			(atributo antiguedad)
			(valor 14))
		(oav-u
			(objeto movil)
			(atributo sistemaOperativo)
			(valor actual))
		(oav-m
			(objeto movil)
			(atributo fallo)
			(valor se-apaga-inesperadamente)))
)

; SI HAY QUE REVISAR TABLET (ESCENARIO 2).
(defrule revisar-tablet "dispositivo a revisar es la tablet"
	(oav-u
		(objeto escenario)
		(atributo numero)
		(valor 2))
=>
	(assert	(oav-u
			(objeto tablet)
			(atributo antiguedad)
			(valor 20))
		(oav-u
			(objeto tablet)
			(atributo sistemaOperativo)
			(valor actual))
		(oav-m
			(objeto tablet)
			(atributo fallo)
			(valor error-arranque))
		(oav-m
			(objeto tablet)
			(atributo fallo)
			(valor ficheros-corruptos)))
)

; SI HAY QUE REVISAR PORTÁTIL (ESCENARIO 3).
(defrule revisar-portatil "si el dispositivo a revisar es el portatil"
	(oav-u
		(objeto escenario)
		(atributo numero)
		(valor 3))
=>
	(assert	(oav-u
			(objeto portatil)
			(atributo antiguedad)
			(valor 30))
		(oav-u
			(objeto portatil)
			(atributo sistemaOperativo)
			(valor no-actual))
		(oav-m
			(objeto portatil)
			(atributo fallo)
			(valor no-enciende)))
)

; EL DISPOSITIVO NO SE PUEDE REVISAR DEBIDO A LA ANTIGUEDAD
(defrule no-aceptar-dispositivo-1 "comprobar si se pasa de meses de antiguedad"
	(oav-u
		(objeto ?dispositivo)
		(atributo antiguedad)
		(valor ?meses))
	(test	(> ?meses 24))
=>
	(assert (oav-u
			(objeto ?dispositivo)
			(atributo revisable)
			(valor FALSE)))
	(printout T crlf "El dispositivo " ?dispositivo " no se puede revisar porque su antiguedad es mayor de 2 años." crlf)
)

; EL DISPOSITIVO NO SE PUEDE REVISAR DEBIDO AL SISTEMA OPERATIVO.
(defrule no-aceptar-dispositivo-2 "comprobar si el SO es el actual"
	(oav-u
		(objeto ?dispositivo)
		(atributo sistemaOperativo)
		(valor no-actual))
=>
	(assert (oav-u
			(objeto ?dispositivo)
			(atributo revisable)
			(valor FALSE)))
	(printout T crlf "El dispositivo " ?dispositivo " no se puede revisar porque su Sistema Operativo no es el actual." crlf)
)

; COMPROBAR SI SE PUEDE REVISAR EL DISPOSITIVO Y OFRECER EL SERVICIO.
(defrule aceptar-dispositivo "comprobar que se le puede ofrecer el dispositivo"
	(oav-u
		(objeto ?dispositivo)
		(atributo antiguedad))
	(not	(oav-u
			(objeto ?dispositivo)
			(atributo revisable)))

=>
	(assert	(oav-u
			(objeto ?dispositivo)
			(atributo revisable)
			(valor TRUE)))
)

; COMPROBAR SI SE TRATA DE UN PROBLEMA DEL SISTEMA OPERATIVO
(defrule problema-sistemaOperativo "es un problema del sistema operativo"
	(or	(oav-m
			(objeto ?dispositivo)
			(atributo fallo)
			(valor error-arranque))
		(oav-m
			(objeto ?dispositivo)
			(atributo fallo)
			(valor ficheros-corruptos)))
=>
	(assert (oav-m
			(objeto ?dispositivo)
			(atributo problema)
			(valor sistema-operativo)))
)

; COMPROBAR SI SE TRATA DE UN PROBLEMA DEL SISTEMA DE ALIMENTACIÓN.
(defrule problema-sistemaAlimentacion "es un problema del sistema de alimentación"
	(oav-m
		(objeto ?dispositivo)
		(atributo fallo)
		(valor bateria))
	(or	(oav-m
			(objeto ?dispositivo)
			(atributo fallo)
			(valor se-apaga-inesperadamente))
		(oav-m
			(objeto ?dispositivo)
			(atributo fallo)
			(valor no-enciende)))
=>
	(assert	(oav-m
			(objeto ?dispositivo)
			(atributo problema)
			(valor sistema-de-alimentacion)))
)

; COMPROBAR SI SE TRATA DE UN PROBLEMA DE MAL USO
(defrule problema-mal-uso "es un problema de mal uso del dispositivo"
	(oav-m
		(objeto ?dispositivo)
		(atributo problema)
		(valor sistema-de-alimentacion))
	(oav-m
		(objeto ?dispositivo)
		(atributo fallo)
		(valor golpes))
=>
	(assert	(oav-m
			(objeto ?dispositivo)
			(atributo problema)
			(valor mal-uso)))
)





