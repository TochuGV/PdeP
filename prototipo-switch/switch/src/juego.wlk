import wollok.game.*

object juego {

  var alternado = false;

  method iniciar(){
    game.addVisual(cuadradoUno);
    game.addVisual(cuadradoDos);
    columnaRoja.aparecer();
    columnaAzul.aparecer();
  }
 
  method intercambiarColores(){
    cuadradoUno.intercambiar();
    cuadradoDos.intercambiar();
  }

  method cambiarColor(color){
    cuadradoUno.cambiarColor(color);
    cuadradoDos.cambiarColor(color);
  }
  method cambiarModo(){
    if(!alternado){
      cuadradoUno.cambiarColor("rojo");
      cuadradoDos.cambiarColor("rojo");
    }else{
      cuadradoUno.cambiarColor("rojo");
      cuadradoDos.cambiarColor("azul");
    }
    alternado = !alternado;
  }
}

object cuadradoUno{
  var property position = game.at(1,1);
  var property image = "rojo.jpg";

  method intercambiar(){
    if(self.image() == "rojo.jpg"){
      image = "azul.jpg"
    }else{
      image = "rojo.jpg"
    }
  }

  method cambiarColor(color){
    image = color + ".jpg"
  }
}

object cuadradoDos{
  var property position = game.at(1,4);
  var property image = "azul.jpg";

  method intercambiar(){
    if(self.image() == "rojo.jpg"){
      image = "azul.jpg"
    }else{
      image = "rojo.jpg"
    }
  }

  method cambiarColor(color){
    image = color + ".jpg"
  }
}

object columnaRoja{
  var property image = "columna-rojo.jpg";
  var property position = game.at(31,0);

  method aparecer(){
    game.addVisual(self);
    self.comenzarDesplazamientos();
  }

  method comenzarDesplazamientos(){
      game.onTick(100, "desplazarse", {self.desplazarse()})
    }

   method desplazarse(){
      if(!self.colisiona()){
        if(position.x() > 0){
          position = position.left(1)
        }else{
          game.removeVisual(self)
        }
      }else{
        if(!self.coincideConColorCuadrado()){
          game.removeVisual(cuadradoUno);
          game.removeVisual(cuadradoDos);
        }
      }
   }
  method coincideConColorCuadrado() = (cuadradoUno.image() == "rojo.jpg")
  method colisiona() = (position.x() - 1 == cuadradoUno.position().x())
  
}

object columnaAzul{
  var property image = "columna-azul.jpg";
  var property position = game.at(31,3);

  method aparecer(){
    game.addVisual(self);
    self.comenzarDesplazamientos();
  }

  method comenzarDesplazamientos(){
    game.onTick(100, "desplazarse", {self.desplazarse()})
  }

  method desplazarse(){
      if(!self.colisiona()){
        if(position.x() > 0){
          position = position.left(1)
        }else{
          game.removeVisual(self)
        }
      }else{
        if(!self.coincideConColorCuadrado()){
          game.removeVisual(cuadradoUno);
          game.removeVisual(cuadradoDos);
        }
      }
   }
  method coincideConColorCuadrado() = (cuadradoDos.image() == "azul.jpg")
  method colisiona() = (position.x() - 1 == cuadradoUno.position().x())
  
}
