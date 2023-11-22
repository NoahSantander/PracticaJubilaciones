import Empleados.*

object fiesta {
	var listaInvitados = #{}
	const asistentes = new Dictionary()
	var ordenLlegada = 0
	const sorteo = new Dictionary()
	
	method invitadosFiesta(invitados) {
		listaInvitados = invitados
	}
	
	method colocarEnMesa(invitado) = invitado.numeroMesa()
	
	method agregarAsistentes(invitado){
		ordenLlegada += 1
		asistentes.put(invitado, self.colocarEnMesa(invitado))
		sorteo.put(ordenLlegada, invitado)
	}
	
	method puedePasar(invitado) = listaInvitados.contains(invitado)
	method dejarPasar(invitado) {
		if(self.puedePasar(invitado))
			self.agregarAsistentes(invitado)
	}	
	
	method cantidadAsistentes() = self.obtenerAsistentes().size()
	method costo() = 200000 + 5000 * self.cantidadAsistentes()
	method obtenerAsistentes() = asistentes.keys()
	method regalos() = self.obtenerAsistentes().sum({ asistente => asistente.regalar() })
	method balance() = self.costo() - self.regalos()
	
	method vino(invitado) = self.obtenerAsistentes().contains(invitado)
	method fueExcelente() = listaInvitados.all({ invitado => self.vino(invitado) })
	
	method numeroAleatorio() = (1.. ordenLlegada).anyOne()
	method sorteo() = sorteo.get(self.numeroAleatorio())
}