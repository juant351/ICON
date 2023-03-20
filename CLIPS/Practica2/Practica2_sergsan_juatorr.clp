; SEGUNDA PRÁCTICA. EJERCICIO 2 (EJERCICIO 1 ES LA REGLA univaluar-hechos).
; SANZ SANZ SERGIO.
; TORRES VILORIA JUAN.

; ESTRUCTURA HECHOS UNIVALUADOS.
(deftemplate   oav-u
	(slot objeto (type SYMBOL))
	(slot atributo (type SYMBOL))
	(slot valor)
)

; ESTRUCTURA HECHOS MULTIVALUADOS.
(deftemplate   oav-m
	(slot objeto (type SYMBOL))
	(slot atributo (type SYMBOL))
	(slot valor)
)


; DECLARACION PACIENTES.
(deffacts pacientes
	(oav-u (objeto Daniel) 
				(atributo sexo) 
				(valor hombre))
	(oav-u (objeto Daniel) 
				(atributo edad) 
				(valor 5))
	(oav-m (objeto Daniel) 
				(atributo sintoma) 
				(valor febricula))
	(oav-m (objeto Daniel) 
				(atributo sintoma) 
				(valor dolor-de-abdomen))

	(oav-m (objeto Daniel) 
				(atributo evidencia) 
				(valor rumor-diastolico))
	(oav-u (objeto Daniel) 
				(atributo presionSistolica) 
				(valor 130))
	(oav-u (objeto Daniel) 
				(atributo presionDiastolica) 
				(valor 85))

	(oav-u (objeto Ana) 
				(atributo sexo) 
				(valor mujer))
	(oav-u (objeto Ana) 
				(atributo edad) 
				(valor 71))
	(oav-m (objeto Ana) 
				(atributo sintoma) 
				(valor febricula))
	(oav-m (objeto Ana) 
				(atributo sintoma) 
				(valor dolor-de-abdomen))
	(oav-m (objeto Ana) 
				(atributo evidencia) 
				(valor rumor-abdominal))
	(oav-m (objeto Ana) 
				(atributo evidencia) 
				(valor masa-pulsante-abdomen))
	(oav-u (objeto Ana) 
				(atributo presionSistolica) 
				(valor 100))
	(oav-u (objeto Ana) 
				(atributo presionDiastolica) 
				(valor 50))
)

; UNIVALUAR HECHOS (OAV-U)
(defrule univaluar-hechos
	(declare (salience 10000))
	?x <- (oav-u)
	?y <- (oav-u)
	(test(neq ?x ?y))
=>
	(retract ?y)
)

; IMPRIMIR RESULTADO DIAGNOSTICO CUANDO TIENE UNA ENFERMEDAD.
(defrule imprimir-enfermedad
	(declare (salience -1000))
	(oav-m		
		(objeto ?nombre)
		(atributo enfermedad)
		(valor ?enfermedad))
	(oav-m
		(objeto ?nombre)
		(atributo causa)
		(valor ?causa))
=>
	(printout T crlf "Nombre: " ?nombre crlf " Detectado:"?causa crlf)
	(printout T " El paciente padece una " ?enfermedad crlf)
)

; IMPRIMIR RESULTADO DIAGNOSTICO CUANDO NO TIENE UNA ENFERMEDAD.
(defrule imprimir-noEnfermedad
	(declare (salience -1000))
	
		(oav-u
		(objeto ?nombre)
		(atributo edad))
		
		(not (oav-m
			(objeto ?nombre)
			(atributo enfermedad)
			(valor enfermedad-cardiovascular-corazon)))
	
		(not (oav-m
			(objeto ?nombre)
			(atributo enfermedad)
			(valor enfermedad-cardiovascular-vasos-sanguineos)))
=>
	(printout T "Nombre: " ?nombre crlf " no tiene ninguna enfermedad" crlf)
)

; COMPROBAR SI HAY ANEURISMA EN LA ARTERIA ABDOMINAL
(defrule aneurismaArteriaAbdominal
	(oav-m
		(objeto ?nombre)
		(atributo sintoma)
		(valor dolor-de-abdomen))
	(oav-m
		(objeto ?nombre)
		(atributo evidencia)
		(valor masa-pulsante-abdomen))
	(oav-m
		(objeto ?nombre)
		(atributo evidencia)
		(valor rumor-abdominal))
=>
	(assert (oav-m
			(objeto ?nombre)
			(atributo causa)
			(valor aneurisma-arteria-abdominal)))
)

; CALCULAR PRESION PULSO.
(defrule calcular-presion-pulso
	(oav-u 
		(objeto ?nombre)
		(atributo presionSistolica)
		(valor ?presionS))
	(oav-u 
		(objeto ?nombre)
		(atributo presionDiastolica)
		(valor ?presionD))
=>
	(bind ?presionPulso (- ?presionS ?presionD))
	(assert (oav-u
			(objeto ?nombre)
			(atributo presionPulso)
			(valor ?presionPulso)))
)

; COMPROBAR SI ES GRUPO DE RIESGO.
(defrule grupo-riesgo
	(oav-u
		(objeto ?nombre)
		(atributo edad)
		(valor ?edad))
	
	(or	(test	(> ?edad 70))
		(and	(oav-u
				(objeto ?nombre)
				(atributo annosFumando)
				(valor ?annos))
			(test	(> ?annos 20)))
		(oav-u
			(objeto ?nombre)
			(atributo obesidad)
			(valor TRUE)))
=>
	(assert	(oav-u
			(objeto ?nombre)
			(atributo grupo-riesgo)
			(valor TRUE)))
)

; COMPROBAR SI HAY ARTERIOSCLEROSIS
(defrule arteriosclerosis
	(oav-u
		(objeto ?nombre)
		(atributo grupo-riesgo)
		(valor TRUE))
=>
	(assert	(oav-m
			(objeto ?nombre)
			(atributo causa)
			(valor arteriosclerosis)))
)

; COMPROBAR SI HAY REGURGITACIÓN AÓRTICA
(defrule regurgitacion-aortica
	(oav-u
		(objeto ?nombre)
		(atributo presionPulso)
		(valor ?presionPulso))
	(oav-u
		(objeto ?nombre)
		(atributo presionSistolica)
		(valor ?presionS))

	(test (> ?presionS 150))
	(test (> ?presionPulso 90))
	
	(oav-m 
		(objeto ?nombre)
		(atributo evidencia)
		(valor rumor-sistolico | dilatacion-en-el-corazon)) 
	
=>
	(assert (oav-m
			(objeto ?nombre)
			(atributo causa)
			(valor regurgitacion-aortica)))
)

; SI HAY ESTENOSIS
(defrule estenosis
	(or 	(oav-m 
			(objeto ?nombre)
			(atributo sintoma)
			(valor calambres-piernas))
		(and 	(oav-u 
				(objeto ?nombre)
				(atributo grupo-riesgo)
				(valor TRUE))
			(oav-m 
				(objeto ?nombre)
				(atributo causa)
				(valor arteriosclerosis))))
=>
	(assert (oav-m
			(objeto ?nombre)
			(atributo causa)
			(valor estenosis)))

)

; SI ES ENFERMEDAD CARDIOVASCULAR DEL CORAZON
(defrule enfermedad-cardiovascular-corazon
	(oav-m
		(objeto ?nombre)
		(atributo causa)
		(valor regurgitacion-aortica))
=>
	(assert (oav-m
			(objeto ?nombre)
			(atributo enfermedad)
			(valor enfermedad-cardiovascular-corazon)))
)

; SI ES ENFERMEDAD CARDIOVASCULAR DE LOS VASOS SANGUÍNEOS.
(defrule enfermedad-cardiovascular
	(or 	(oav-m 
			(objeto ?nombre)
			(atributo causa)
			(valor aneurisma-arteria-abdominal))
		(oav-m 
			(objeto ?nombre)
			(atributo causa)
			(valor estenosis))
		(oav-m 
			(objeto ?nombre)
			(atributo causa)
			(valor arteriosclerosis)))
=>
	(assert (oav-m
		(objeto ?nombre)
		(atributo enfermedad)
		(valor enfermedad-cardiovascular-vasos-sanguineos)))	
)




