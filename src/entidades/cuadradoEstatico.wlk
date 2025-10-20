import wollok.game.*
import cuadrado.*

class CuadradoEstatico inherits Cuadrado {
  var indiceColorActual = 0
  /*
  method cambiarColor(){
    indiceColorActual = (indiceColorActual + 1) % self.colores().size()
    color = colores.get(indiceColorActual)
  }
  */

  //Habría que pasar el nivel por parámetro para obtener el listado colores.
  //En base a eso, ir cambiando el índice según el tamaño de la colección.
  //Luego, modificar la imagen del cuadrado según el índice.
}