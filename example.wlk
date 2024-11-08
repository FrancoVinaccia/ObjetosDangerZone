class Empleado {

  var salud
  var habilidades = []  
  var puesto

  method nuevoPuesto(nuevo) {
    puesto = nuevo
  }
  method saludCritica() = puesto.saludCritica()

  method incapacitado() = salud < self.saludCritica()

  method puedeUsar(habilidad) = self.tieneHabilidad(habilidad) and not self.incapacitado()
  method tieneHabilidad(habilidad) = habilidades.contains(habilidad)

  method recibirDanio(cantidad) { salud = salud - cantidad }

  method puedeCumplir(mision) = mision.habiliaddesNecesarias().all({habilidad => self.puedeUsar(habilidad)})

  method cumplirMision(mision) {
    if (self.puedeCumplir(mision)){
      salud - mision.peligrosidad()
      if (self.estaVivo()){
      puesto.cumplirMision(self,mision)
      }
    }
  }

  method aprenderHabilidades(habilidadesNuevas){
    habilidades += habilidadesNuevas
  }

  method estaVivo() = salud > 0
}

object espia {
  method saludCritica() = 15
  method cumplirMision(empleado,mision){
    empleado.aprenderHabilidades(mision.habiliaddesNecesarias())
  }
}


object oficinista {
  var cantEstrellas = 0
  method saludCritica() = 40 - 5 * cantEstrellas
  method cumplirMision(empleado){
    cantEstrellas =+ 1
  if (cantEstrellas == 3) {
			empleado.nuevoPuesto(espia)
		}
  }
}

class Jefe inherits Empleado{
  const subordinados = []
  override method puedeUsar(habilidad) = super(habilidad) or subordinados.any { s=>s.puedeUsar(habilidad) }
}

class mision {
  var property habiliaddesNecesarias = []
  const peligrosidad
}

const m = new mision (peligrosidad = 10, habiliaddesNecesarias = ["sigilo","combate"])
const e = new Empleado (salud = 50, habilidades = ["sigilo","combate"], puesto = oficinista)