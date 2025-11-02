import wollok.game.*
import pantalla.*
import handlerPantalla.*
import src.juego.*
class Juego inherits Pantalla(image =  "juego.jpg") {
  
    override method iniciarEventosDeTeclado(){}

    override method aparecer(){
        super();
        juego.iniciar();
    }

}