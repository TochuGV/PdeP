import wollok.game.*
import cuadrado.*

class CuadradoDinamico inherits Cuadrado {

  method avanzar(){
    position = game.at(position.x() - 0.5, position.y());
  }

  method iniciarMovimiento(velocidad){
    game.onTick(velocidad, "movimientoCuadrado", { self.avanzar() });
  }
}