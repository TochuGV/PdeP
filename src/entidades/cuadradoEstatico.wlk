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

  //Habría que pasar el nivel por parámetro para obtener el listado colores.
  //En base a eso, ir cambiando el índice según el tamaño de la colección.
  //Luego, modificar la imagen del cuadrado según el índice.
}