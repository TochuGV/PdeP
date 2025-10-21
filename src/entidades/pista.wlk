import wollok.game.*
import entidades.cuadradoEstatico.*
import entidades.cuadradoDinamico.*
import entidades.nivel.*

class Pista {
  var property indiceColorActual;
  const colores = [];
  var property image = colores.get(indiceColorActual);
  var property position;
  var property cuadradosDinamicos = [];
  var property cuadradoEstatico = new CuadradoEstatico(image = "columna-" + image, position = position);

  method iniciar(nivel){
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
  
  method hayMatch() = cuadradoEstatico.image() == "columna-" + cuadradosDinamicos.first().image();

  method cambiarColor(){
    indiceColorActual = (indiceColorActual + 1) % colores.size();
    cuadradoEstatico.cambiarImagen("columna-" + colores.get(indiceColorActual));
  }
}