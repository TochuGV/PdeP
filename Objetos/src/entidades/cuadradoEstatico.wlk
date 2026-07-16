import wollok.game.*
import entidades.cuadrado.*

class CuadradoEstatico inherits Cuadrado {
  const nivel;
  var indiceColorActual = 0;

  method cambiarColor(){
    const colores = nivel.colores();
    indiceColorActual = (indiceColorActual + 1) % colores.size()
    image = colores.get(indiceColorActual)
  }
}