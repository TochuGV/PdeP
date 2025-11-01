import wollok.game.*
import entidades.cuadradoDinamico.*
import entidades.cuadradoEstatico.*
import entidades.pista.*
import entidades.nivel.*
import entidades.dificultad.*

object juego {
  var property nivelActual = null;
  var property indiceDificultad = 0;
  
  method iniciar(){
    self.cargarDificultadActual()
  }

  method cargarDificultadActual(){
    const dificultad = dificultades.lista().get(indiceDificultad)
    nivelActual = new Nivel(dificultad = dificultad);
    nivelActual.iniciar();
  }

  method siguienteDificultad(){
    if (indiceDificultad < dificultades.lista.size() - 1) {
      indiceDificultad += 1
      self.cargarDificultadActual()
    } // Habría que agregar un 'else' diciendo que completó el juego
  }
}