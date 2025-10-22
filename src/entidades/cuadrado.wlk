import wollok.game.*

class Cuadrado {
  var property image;
  var property position;

  method aparecer(){
    game.addVisual(self);
  }

  method cambiarImagen(nuevaImagen){
    image = nuevaImagen;
  }

  method desaparecer(){
    game.removeVisual(self);
  }

}