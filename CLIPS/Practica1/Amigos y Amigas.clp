;  Segundo ejemplo: AMIGOS y AMIGAS

;	Hechos iniciales

(deffacts amigos "algunos amigos"
	(persona nombre "Luis Prieto" sexo varon)
	(persona nombre "Ana Perez" sexo mujer)
)

; Tres reglas

(defrule nombre-amigos "Encontrar el nombre de los amigos"
	(persona nombre ?x ? ?)
=>
	(assert (encontrado ?x))
)

(defrule registrar-amigo "Solo para los varones"
	(encontrado ?x)
	(persona nombre ?x sexo varon)
=>
	(assert (amigo ?x))
)


(defrule registrar-amiga "solo para las mujeres"
	(encontrado ?x)
	(persona nombre ?x sexo mujer)
=>
	(assert (amiga ?x))
)