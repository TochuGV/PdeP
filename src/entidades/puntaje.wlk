object puntaje {
  var property puntos = 0;

  method position() = game.origin();
  method text() = "Puntos: " + puntos;

  method sumarPuntos(cantidad){
    puntos = puntos + cantidad;
  }

  method aparecer(){
    game.addVisual(self);
  }
}