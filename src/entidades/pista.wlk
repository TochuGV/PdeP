import wollok.game.*
import entidades.cuadradoEstatico.*
import entidades.cuadradoDinamico.*
import entidades.nivel.*

class Pista {
  var property image;
  var property position;
  var property cuadradoEstatico = new CuadradoEstatico(image = image, position = position);
  
  method iniciar(nivel){
    game.addVisual(cuadradoEstatico);
    self.generarCuadradosDinamicos(nivel.velocidadDeGeneracion(), nivel.colores(), nivel.velocidadDeMovimiento());
  }

  method generarCuadradosDinamicos(velocidadDeGeneracion, colores, velocidadDeMovimiento){
    game.onTick(velocidadDeGeneracion, "generarCuadradosDinamicos", { self.generarCuadradoDinamico(colores.anyOne(), velocidadDeMovimiento) });
  }

  method generarCuadradoDinamico(color, velocidadDeMovimiento){
    const nuevoCuadrado = new CuadradoDinamico(image = color, position = game.center());
    game.addVisual(nuevoCuadrado);
    nuevoCuadrado.iniciarMovimiento(velocidadDeMovimiento);
  }
}