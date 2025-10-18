import wollok.game.*
import cuadrado.*

class CuadradoDinamico inherits Cuadrado {

  method avanzar(){
    position = position.left(1);
  }

  method seleccionarColor(){
    // seleccionar color random de la lista de colores
  }

  method verificarColision(){
    // misma pos en "x" que el cuadrado estatico
  }

  method coincideConColor(){
    // misma url de imagen que el cuadrado estatico (o indice de array)
  }

  method iniciarMovimiento(velocidad){
    game.onTick(velocidad, "movimientoCuadrado", { self.avanzar() });
  }

  /*
  method desaparecer(){
    
  }
  */
}