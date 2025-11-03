import wollok.game.*
import src.entidades.digito.*
object puntaje {
  var property puntos = 0;

  const digitos = [
    new Digito(position = game.at(15, 1)),
    new Digito(position = game.at(17, 1)),
    new Digito(position = game.at(19, 1)),
    new Digito(position = game.at(21, 1))
  ];

  method position() = game.origin();

  method sumarPuntos(cantidad){
    puntos = puntos + cantidad;
    self.actualizarDigitos();
  }

  method aparecer(){
    self.reiniciarPuntaje();
    game.addVisual(self);
    digitos.forEach({ digito => digito.aparecer() });
  }

  method actualizarDigitos(){
    const stringDePuntos = puntos.toString();
    const arrayDeDigitos = stringDePuntos.split("");
    const diferenciaDeDigitos = digitos.size() - arrayDeDigitos.size();
   
    (0..(arrayDeDigitos.size() - 1)).forEach{indice => 
      digitos.get(diferenciaDeDigitos + indice).cambiarNumero(arrayDeDigitos.get(indice))
    };
  }

  method reiniciarPuntaje(){
    puntos = 0;
    digitos.forEach({ digito => digito.cambiarNumero("0") });
  }
}