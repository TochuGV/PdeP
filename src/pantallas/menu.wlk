import wollok.game.*
import pantalla.*
import handlerPantalla.*
class Menu inherits Pantalla(image =  "menu.jpg") {
  
  override method iniciarEventosDeTeclado(){
    keyboard.enter().onPressDo{handlerPantalla.siguientePantalla()};
  }

}