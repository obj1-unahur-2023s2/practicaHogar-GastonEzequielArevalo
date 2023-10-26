import Personas.*
class Habitacion{
	
	const ocupantes = []
	
	method ocupantes(){
		return ocupantes
	}
	
	method nivelDeConfortQueAporta(unaPersona)
	
	method aporteDeConfortBase(){
		return 10
	}
	
	method unidadesExtra()
	
	method puedeEntrar(unaPersona)
	
	method casoBase(){
		return ocupantes.isEmpty()
	}
}

class HabitacionDeUsoGeneral inherits Habitacion{
	
	override method nivelDeConfortQueAporta(unaPersona){
		return self.aporteDeConfortBase()
	}
	
	override method unidadesExtra(){
		
	}
	
	override method puedeEntrar(unaPersona){
			return true
	}
	
}

class Dormitorio inherits Habitacion{
	const personasQueDuermenEnElDormitorio = []
	
	method duermeEnElDormitorio(unaPersona){
		return personasQueDuermenEnElDormitorio.contains(unaPersona)
	}
	
	override method nivelDeConfortQueAporta(unaPersona){
		if (self.duermeEnElDormitorio(unaPersona)){
			return self.aporteDeConfortBase() + self.unidadesExtra()
		}
		else{
			return self.aporteDeConfortBase()
		}
	}
	
	override method unidadesExtra(){
		return 10 / personasQueDuermenEnElDormitorio.size()
	}
	
	method todasLasPersonasQueDuermenEstanOcupandolo(){
		return personasQueDuermenEnElDormitorio == ocupantes
	}
	
	override method puedeEntrar(unaPersona){
		return personasQueDuermenEnElDormitorio.contains(unaPersona) or self.todasLasPersonasQueDuermenEstanOcupandolo()
	}
} 

class Banio inherits Habitacion{
	
	override method nivelDeConfortQueAporta(unaPersona){
		if (unaPersona.edad() <= 4){
			return self.aporteDeConfortBase() + self.unidadesExtra()
		}
		else{
			return self.aporteDeConfortBase() + self.unidadesExtra() + 2
			
		}
	}
	
	override method unidadesExtra(){
		return 2
	}
	
	method algunoDeSusOcupantesEsMenorDe4Anios(){
		return ocupantes.any({ocupante => ocupante.edad() <= 4})
	}
	
	override method puedeEntrar(unaPersona){
		return self.algunoDeSusOcupantesEsMenorDe4Anios()
	}
}

class Cocina inherits Habitacion{
	
	var property metrosCuadradosDeCocina = 10
	
	override method nivelDeConfortQueAporta(unaPersona){
		if (unaPersona.tieneHabilidadesDeCocina()){
			return self.aporteDeConfortBase() + self.unidadesExtra()
		}
		else{
			return self.aporteDeConfortBase()
		}
	}
	
	override method unidadesExtra(){
		return metrosCuadradosDeCocina
	}
	
	method laPersonaTieneHabilidadesDeCocina(unaPersona){
		return unaPersona.tieneHabilidadesDeCocina()
	}
	
	method enLaCocinaHayPersonasConHabilidadesDeCocina(){
		return ocupantes.any({persona => persona.tieneHabilidadesDeCocina()})
	}
	
	override method puedeEntrar(unaPersona){
		return not self.enLaCocinaHayPersonasConHabilidadesDeCocina() and self.laPersonaTieneHabilidadesDeCocina(unaPersona)
	}
}