import wollok.game.*

class Digito {
  var property image = "0.jpg";
  var property position;

  method aparecer(){
    game.addVisual(self);
  }

  method desaparecer(){
    game.removeVisual(self);
  }

  method cambiarNumero(numero){
    image = numero + ".jpg";
  }
}