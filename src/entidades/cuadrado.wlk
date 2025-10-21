import wollok.game.*

class Cuadrado {
  var property image;
  var property position;
  /*var property colores = ["azul.jpg", "rojo.jpg"]*/

  method aparecer(){
    game.addVisual(self);
  }

  method cambiarImagen(nuevaImagen){
    image = nuevaImagen;
  }
}