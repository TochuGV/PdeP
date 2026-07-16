import wollok.game.*

class Digito {
  var property image = "0.png";
  var property position;

  method aparecer(){
    game.addVisual(self);
  }

  method desaparecer(){
    game.removeVisual(self);
  }

  method cambiarNumero(numero){
    image = numero + ".png";
  }
}