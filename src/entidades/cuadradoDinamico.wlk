import wollok.game.*
import cuadrado.*

class CuadradoDinamico inherits Cuadrado {

  method avanzar(){
    position = position.left(1);
  }

  method verificarColision(){
    position.x() == juego.cuadradoBase1.position().x()
  }

  method coincideConColor(){
    // misma url de imagen que el cuadrado estatico (o indice de array)
  }

  method iniciarMovimiento(velocidad){
    game.onTick(velocidad, "movimientoCuadrado", { self.avanzar() });
  }

  method desaparecer(){
    game.removeVisual(self);
  }


}