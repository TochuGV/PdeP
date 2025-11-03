import wollok.game.*

object flechaIndicadora {  
  var property position = game.origin();
  var property indicePistaApuntada = 0;
  var property pistas = [];

  method image() = "flecha.png";

  method aparecer(){
    position = self.calcularPosicion();
    game.addVisual(self)
    self.iniciarEventosDeTeclado();
  }

  method iniciarEventosDeTeclado(){
    keyboard.down().onPressDo{self.mover(1)};
    keyboard.up().onPressDo{self.mover(-1)};
    keyboard.s().onPressDo{self.cambiarColor()};
  }

  method mover(direccion){
    indicePistaApuntada = self.obtenerPistaSiguiente(direccion);
    self.calibrarPosicion();
  }

  method calcularPosicion() = game.at(pistas.get(indicePistaApuntada).position().x() - 1, pistas.get(indicePistaApuntada).position().y());
  
  method obtenerPistaSiguiente(direccion){
    const nuevaPosicion = indicePistaApuntada + direccion;
    if(nuevaPosicion >= pistas.size()) return 0;
    if(nuevaPosicion < 0) return pistas.size() - 1;
    return nuevaPosicion;
  }

  method cambiarColor(){
    const pistaApuntada = pistas.get(indicePistaApuntada);
    pistaApuntada.cuadradoEstatico().cambiarColor();
    pistaApuntada.cambiarColor();
  }

  method calibrarPosicion(){
    position = self.calcularPosicion();
  }
}