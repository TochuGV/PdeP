import wollok.game.*
import cuadrado.*

class CuadradoDinamico inherits Cuadrado {

  method avanzar(){
    position = game.at(position.x() - 0.5, position.y());
  }
  
  method coincideConColor(){
    // misma url de imagen que el cuadrado estatico (o indice de array)
  }

  method iniciarMovimiento(velocidad){
    game.onTick(velocidad, "movimientoCuadrado", { self.avanzar() });
    //game.onTick(velocidad, "colisionCuadradoEstatico", { self.verificarColision() });
  }

  method desaparecer(){
    game.removeVisual(self);
  }

  /*
  method verificarMatch(){
    const cuadradoEstaticoConElQueColisiona = self.obtenerCuadradoEstatico();
  }
  
  method obtenerCuadradoEstatico(){
    return juego.cuadradosEstaticos.find(cuadrado => verificarColision(cuadrado));
  }

  method verificarColision(cuadrado){
    return position.x() == cuadrado.position().x()
  }
  */



// hay que hacer un metodo usando que sea para verficiar en que carril se encuentra el cuadrado
//va, al menos para verificar despues en la colision con cual cuadrado tiene que evaluarse si matchea o no

/*
method cuadradoEstaticoDelCarril() {

if (position.y() == juego.cuadradoEstatico1.Position().y()) {
  return juego.cuadradoEstatico1
}

if (position.y() == juego.cuadradoEstatico2.position().y()) {
  return juego.cuadradoEstatico2
  }

  return null  //aca por si está en un carril que no es válido
}


*/
}