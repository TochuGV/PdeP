import wollok.game.*
import entidades.cuadrado.*

class CuadradoEstatico inherits Cuadrado {
  var indiceColorActual = 0;
  var property nivel;

  method cambiarColor(){
    const colores = nivel.colores();
    indiceColorActual = (indiceColorActual + 1) % colores.size()
    image = colores.get(indiceColorActual)
  }
}