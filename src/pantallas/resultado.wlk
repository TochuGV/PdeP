import wollok.game.*
import pantalla.*
import handlerPantalla.*
import src.entidades.puntaje.*
import src.entidades.digito.*
class Resultado inherits Pantalla(image =  "resultado.jpg") {
  
    const digitos = [
        new Digito(image = "0-grande.jpg", position = game.at(0, game.center().y())),
        new Digito(image = "0-grande.jpg", position = game.at(6, game.center().y())),
        new Digito(image = "0-grande.jpg", position = game.at(12, game.center().y())),
        new Digito(image = "0-grande.jpg", position = game.at(18, game.center().y()))
    ];

    override method iniciarEventosDeTeclado(){
        keyboard.enter().onPressDo{handlerPantalla.siguientePantalla()};
    }

    method mostrarPuntaje(){
        const arrayPuntaje = puntaje.puntos().toString().split("");
        const diferenciaDeDigitos = digitos.size() - arrayPuntaje.size();
        
        (0..(arrayPuntaje.size() - 1)).forEach{
        indice => digitos.get(diferenciaDeDigitos + indice).cambiarNumero(arrayPuntaje.get(indice) + "-grande")
        }

        digitos.forEach({ digito => digito.aparecer() });
    }

    override method aparecer(){
        super();
        self.mostrarPuntaje();
    }
}