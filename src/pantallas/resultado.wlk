import wollok.game.*
import pantalla.*
import handlerPantalla.*
import src.entidades.puntaje.*
import src.entidades.digito.*
class Resultado inherits Pantalla(image =  "resultado.jpg") {
  
    const digitos = [
        new Digito(image = "0-grande.png", position = game.at(11, game.center().y() - 4)),
        new Digito(image = "0-grande.png", position = game.at(15, game.center().y() - 4)),
        new Digito(image = "0-grande.png", position = game.at(19, game.center().y() - 4)),
        new Digito(image = "0-grande.png", position = game.at(23, game.center().y() - 4))
    ];

    override method iniciarEventosDeTeclado(){
        keyboard.enter().onPressDo{handlerPantalla.siguientePantalla()};
    }

    method mostrarPuntaje(){
        self.reiniciarPuntaje();
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

    method reiniciarPuntaje(){
        digitos.forEach({ digito => digito.cambiarNumero("0-grande") });
    }

}