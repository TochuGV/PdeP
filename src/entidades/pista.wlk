import wollok.game.*
import entidades.cuadradoEstatico.*
import entidades.cuadradoDinamico.*
import entidades.nivel.*

class Pista {
  var property nivel;
  var property indiceColorActual;
  var property image = null;
  var property position;
  var property cuadradoEstatico = null;
  var property cuadradosDinamicos = [];
  //var property cantidadGenerada = 0;

  method iniciar(){
    const colorActual = nivel.colores().get(indiceColorActual)
    const imagenPista = "pista-" + colorActual

    self.image(imagenPista)
    game.addVisual(self)

    const posicionCuadradoEstatico = game.at(position.x() + 1, position.y())
    //Está puesto así porque sin el '+1' se rompe el programa - LL: Dispara evento de colision con la pista

    cuadradoEstatico = new CuadradoEstatico(
      nivel = nivel,
      image = colorActual,
      position = posicionCuadradoEstatico
    )
    cuadradoEstatico.aparecer();
    self.generarCuadradosDinamicos(nivel.velocidadDeGeneracion(), nivel.velocidadDeMovimiento());
  }

  method generarCuadradosDinamicos(velocidadDeGeneracion, velocidadDeMovimiento){
    var cantidadGenerada = 0;
    game.onTick(velocidadDeGeneracion, "generarCuadradosDinamicos", {
      if (cantidadGenerada < nivel.dificultad().cantidadDeCoincidenciasParaAvanzar()) {
        self.generarCuadradoDinamico(nivel.colores().anyOne(), velocidadDeMovimiento)
        cantidadGenerada += 1;
      } else {
        game.removeTickEvent("generarCuadradosDinamicos");
      }
    });
  }

  method generarCuadradoDinamico(color, velocidadDeMovimiento){
    const nuevoCuadrado = new CuadradoDinamico(
      image = color, 
      position = game.at(position.x() + 34, position.y())
    );
    cuadradosDinamicos.add(nuevoCuadrado);
    nuevoCuadrado.aparecer();
    nuevoCuadrado.iniciarMovimiento(velocidadDeMovimiento);
  }

  method removerCuadradoDinamico(){
    if(cuadradosDinamicos.size() > 0){
      const cuadradoARemover = cuadradosDinamicos.first();
      cuadradoARemover.desaparecer();
      cuadradosDinamicos.remove(cuadradoARemover);
    }
  }

  //method hayMatch() = (cuadradosDinamicos.size() > 0) && cuadradoEstatico.image() == cuadradosDinamicos.first().image();
  // TV: Esto hace que cuando llegue a los 40 puntos, finalice el juego automáticamente.

  method hayMatch() = cuadradoEstatico.image() == cuadradosDinamicos.first().image();
  
  method cambiarColor(){  
    self.image("pista-" + cuadradoEstatico.image())
  }

  method desaparecer(){
    game.removeVisual(self);
    game.removeTickEvent("generarCuadradosDinamicos");
    cuadradoEstatico.desaparecer();
    cuadradosDinamicos.forEach({ cuadrado => cuadrado.desaparecer() });
  }
}