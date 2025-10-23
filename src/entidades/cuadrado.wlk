import wollok.game.*

class Cuadrado {
  var property image;
  var property position;

  method aparecer(){
    game.addVisual(self);
  }

  method cambiarImagen(nuevaImagen){ //Hay que mover este método al cuadrado estático
    image = nuevaImagen;
  }

  method desaparecer(){
    game.removeVisual(self);
  }

}