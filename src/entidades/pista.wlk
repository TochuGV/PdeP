import wollok.game.*
import entidades.cuadradoEstatico.*
import entidades.cuadradoDinamico.*
import entidades.nivel.*

class Pista {
  var property colores;
  var property indiceColorActual;
  var property image = null;
  var property position;
  var cuadradoEstatico = null;
  var property cuadradosDinamicos = [];

  method iniciar(nivel){
    const colorActual = colores.get(indiceColorActual)
    const imagenPista = "pista-" + colorActual

    self.image(imagenPista)
    game.addVisual(self)

    const posicionCuadradoEstatico = game.at(self.position().x(), self.position().y() + 1)

    cuadradoEstatico = new CuadradoEstatico(
      nivel = nivel,
      image = colorActual,
      position = posicionCuadradoEstatico
    )
    cuadradoEstatico.aparecer();
    self.generarCuadradosDinamicos(nivel.velocidadDeGeneracion(), nivel.velocidadDeMovimiento());
  }

  method generarCuadradosDinamicos(velocidadDeGeneracion, velocidadDeMovimiento){
    game.onTick(velocidadDeGeneracion, "generarCuadradosDinamicos", { self.generarCuadradoDinamico(colores.anyOne(), velocidadDeMovimiento) });
  }

  method generarCuadradoDinamico(color, velocidadDeMovimiento){
    const nuevoCuadrado = new CuadradoDinamico(image = color, position = game.at(10, position.y()));
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
  
  method hayMatch() = cuadradoEstatico.image() == "columna-" + cuadradosDinamicos.first().image();

  method actualizarColor(){
    self.image("pista-" + cuadradoEstatico.image())
  }

  method cambiarColor(){
    cuadradoEstatico.cambiarColor();
    self.actualizarColor();
  }
}