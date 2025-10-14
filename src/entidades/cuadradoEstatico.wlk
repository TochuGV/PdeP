import wollok.game.*
import cuadrado.*

class CuadradoEstatico inherits Cuadrado {
  var indiceColorActual = 0
  
  method cambiarColor(){
    indiceColorActual = (indiceColorActual + 1) % self.colores().size()
    color = colores.get(indiceColorActual)
  }
}