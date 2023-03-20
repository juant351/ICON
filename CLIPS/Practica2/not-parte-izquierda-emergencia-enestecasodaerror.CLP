(deftemplate emergencia
         (slot tipo)
		 )



(defrule informar-emergencia
     (informar-estado)
	 (emergencia (tipo ?tipo))
	 =>
	 (printout t "Manejando " ?tipo " emergencia" crlf))
	 
(defrule no-hay-emergencia
     (informar-estado)
	 (not (emergencia (tipo ?tipo)))
	 =>
	 (printout t "No hay emergencia de tipo " ?tipo  crlf))
	 
	 
;Defining deftemplate: emergencia
;Defining defrule: informar-emergencia +j+j+j
;Defining defrule: no-hay-emergencia 
;[PRCCODE3] Undefined variable tipo referenced in RHS of defrule.

;ERROR:
;(defrule MAIN::no-hay-emergencia
;   (informar-estado)
;   (not (emergencia (tipo ?tipo)))
;   =>
;   (printout t "No hay emergencia de tipo " ?tipo crlf))
;FALSE

