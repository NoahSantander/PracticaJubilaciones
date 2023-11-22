import Lenguajes.*

class Empleado {
	const partners = #{}
	const lenguajesSabidos = #{}
	const jefes = #{}
	
	method agregarJefe(nuevoJefe) {
		jefes.add(nuevoJefe)
	}
	
	method algunoEsAntiguo() = lenguajesSabidos.any({ lenguaje => lenguaje.esAntiguo() })
	method recibeInvitacion()
	
	method aprenderLenguaje(lenguaje) {
		lenguajesSabidos.add(lenguaje)
	}
	
	method cantidadLenguajesModernos() = lenguajesSabidos.filter({ lenguaje => !lenguaje.esAntiguo() }).size()
	method numeroMesa() = self.cantidadLenguajesModernos()
	
	method regalar() = 1000 * self.cantidadLenguajesModernos()
}

class Desarrollador inherits Empleado {
	method programaEnWollok() = lenguajesSabidos.contains(wollok)
	override method recibeInvitacion() = self.programaEnWollok() || self.algunoEsAntiguo()
}

class Infraestructura inherits Empleado {
	method cantidadDeLenguajesSabidos() = lenguajesSabidos.size()
	override method recibeInvitacion() = self.cantidadDeLenguajesSabidos() > 5
}

class Jefe inherits Empleado {
	const subordinados = #{}
	method agregarSubordinado(nuevoSubordinado) {
		subordinados.add(nuevoSubordinado)
		nuevoSubordinado.agregarJefe(self)
	}
	
	method noEsJefeDeJuan() = !subordinados.contains(juanPerez)
	method subordinadoProgramaAntiguo() = subordinados.any({ subordinado => subordinado.algunoEsAntiguo() })
	method cumpleCondiciones() = self.algunoEsAntiguo() && self.subordinadoProgramaAntiguo()
	override method recibeInvitacion() = self.noEsJefeDeJuan() && self.cumpleCondiciones()
	
	override method numeroMesa() = 89
	
	method cantidadSubordinados() = subordinados.size()
	override method regalar() = super() + 1000 * self.cantidadSubordinados()
}

object juanPerez inherits Empleado{
	const invitados = #{}
	
	method agregarInvitado(invitado) {
		invitados.add(invitado)
	}
	method partnersInvitados() = partners.filter({ partner => partner.recibeInvitacion() })
	method hacerListaInvitados() {
		self.partnersInvitados().forEach({ invitado => self.agregarInvitado(invitado) })
	}
	
	override method recibeInvitacion(){}
}