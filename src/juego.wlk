import wollok.game.*
import entidades.cuadradoDinamico.*
import entidades.cuadradoEstatico.*
import entidades.pista.*
import entidades.nivel.*
import entidades.dificultad.*

object juego {
  var property indiceDificultad = 0;
  var property nivelActual = new Nivel(dificultad = dificultades.lista().get(indiceDificultad));

  method iniciar(){
    nivelActual.iniciar();
  }

  method cargarDificultadActual(){
    nivelActual.dificultad(dificultades.lista().get(indiceDificultad))
  }

  method siguienteDificultad(){
    if (indiceDificultad < dificultades.lista().size() - 1) {
      indiceDificultad = indiceDificultad + 1;
      self.cargarDificultadActual();
    } // Habría que agregar un 'else' diciendo que completó el juego
      // LL: Y si hacemos un par mas de dificultades que sean muy dificiles? Asi en algun momento se pierde y dejamos el score final
  }
}