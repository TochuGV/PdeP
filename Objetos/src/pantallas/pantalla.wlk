import wollok.game.*

class Pantalla {
  var property image;

  method position() = game.origin();

  method aparecer(){
    game.addVisual(self);
    self.iniciarEventosDeTeclado();
  }

  method desaparecer(){
    game.clear();
  }

  method iniciarEventosDeTeclado
}