import wollok.game.*
import entidades.cuadradoEstatico.*
import entidades.cuadradoDinamico.*
import entidades.nivel.*
class Pista {
  var property nivel;
  var property indiceColorActual;
  var property image = null;
  var property position;
  var cuadradoEstatico = null;
  var property cuadradosDinamicos = [];

  method iniciar(){
    const colorActual = nivel.colores().get(indiceColorActual)
    const imagenPista = "pista-" + colorActual

    self.image(imagenPista)
    game.addVisual(self)

    const posicionCuadradoEstatico = game.at(position.x() + 1, position.y())
    //Está puesto así porque sin el '+1' se rompe el programa

    cuadradoEstatico = new CuadradoEstatico(
      nivel = nivel,
      image = colorActual,
      position = posicionCuadradoEstatico
    )
    cuadradoEstatico.aparecer();
    self.generarCuadradosDinamicos(nivel.velocidadDeGeneracion(), nivel.velocidadDeMovimiento());
  }

  method generarCuadradosDinamicos(velocidadDeGeneracion, velocidadDeMovimiento){
    game.onTick(velocidadDeGeneracion, "generarCuadradosDinamicos", { 
      self.generarCuadradoDinamico(nivel.colores().anyOne(), velocidadDeMovimiento) 
    });
  }

  method generarCuadradoDinamico(color, velocidadDeMovimiento){
    const nuevoCuadrado = new CuadradoDinamico(
    image = color, 
    position = game.at(position.x() + 10, position.y()));
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

  method cuadradoEstatico() = cuadradoEstatico

  method hayMatch() = cuadradoEstatico.image() == cuadradosDinamicos.first().image();

  method cambiarColor(){  
   self.image("pista-" + cuadradoEstatico.image())
  }
}