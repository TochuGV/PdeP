import wollok.game.*
import entidades.nivel.*
import entidades.dificultad.*

object juego {
  var property indiceDificultad = null;
  var property nivelActual = null;

  method iniciar(){
    indiceDificultad = 0;
    nivelActual = new Nivel(dificultad = dificultades.lista().get(indiceDificultad));
    nivelActual.iniciar();
  }

  method cargarDificultadActual(){
    nivelActual.dificultad(dificultades.lista().get(indiceDificultad))
  }

  method siguienteDificultad(){
    if (indiceDificultad < dificultades.lista().size() - 1) {
      indiceDificultad = indiceDificultad + 1;
      self.cargarDificultadActual();
    }
  }
}