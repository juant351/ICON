(deftemplate emergencia
         (slot tipo))
		 
(deffacts informar (informar-estado))

(defrule informar-emergencia
     (informar-estado)
	 (emergencia (tipo ?tipo))
	 =>
	 (printout t "Manejando " ?tipo " emergencia" crlf))
	 
(defrule no-hay-emergencia
     (informar-estado)
	 (not (emergencia))
	 =>
	 (printout t "No se estan manejando emergencias" crlf))
	 