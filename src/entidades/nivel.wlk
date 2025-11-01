import wollok.game.*
import entidades.pista.*
import entidades.puntaje.*
import entidades.flechaIndicadora.*

class Nivel {
  const colores = [];
  const velocidadDeGeneracion;
  const velocidadDeMovimiento;
  const cantidadDeCoincidenciasParaGanar;
  var cantidadDeCoincidenciasActual = 0;
  const alturaBase = (540 / 50) - (150 / 50);
  const separadorDePosicionesDePistas = 2.25;
  const posicionesDePistas = [game.at(2, alturaBase), game.at(2, (540 / 50) - (150 / 50) * separadorDePosicionesDePistas)];
  // La segunda pista hay que escribirla de esa forma porque sino no aparece.
  // Habría que buscar una forma de hacer que tome la altura de la pantalla y las dimensiones de los cuadrados.
  const pistas = [];

  method colores () = colores;
  method velocidadDeGeneracion () = velocidadDeGeneracion;
  method velocidadDeMovimiento () = velocidadDeMovimiento;
  method cantidadDeCoincidenciasParaGanar () = cantidadDeCoincidenciasParaGanar;
  method cantidadDeCoincidenciasActual () = cantidadDeCoincidenciasActual;
  method pistas () = pistas;

  method iniciar(){
    puntaje.aparecer();

    var indiceColor = 0;
    posicionesDePistas.forEach({ posicionBase =>
      const nuevaPista = new Pista(
        colores = colores, 
        indiceColorActual = indiceColor, 
        position = posicionBase
      );
      pistas.add(nuevaPista);
      nuevaPista.iniciar(self);
      indiceColor = (indiceColor + 1) % colores.size();
    });

    flechaIndicadora.pistas(pistas);
    flechaIndicadora.aparecer();
    self.agregarEventoDeColision();
  }

  method agregarEventoDeColision(){
    const pistaTestigo = pistas.get(0);
    game.whenCollideDo(pistaTestigo.cuadradoEstatico(), { cuadradoDinamico => self.verificarResultado()})
  }

  method verificarResultado(){
    if(self.todasLasPistasHacenMatch()){
      puntaje.sumarPuntos(10);
      pistas.forEach({ pista => pista.removerCuadradoDinamico() });
      self.aumentarCantidadDeCoincidenciasActual();
      //if (cantidadDeCoincidenciasActual == 10) {
        //self.aumentarDificultad();
      //}
    } else {
      self.perder();
    }
  }

  method perder(){
    game.removeTickEvent("generarCuadradosDinamicos");
    game.removeTickEvent("movimientoCuadrado");
  }

  method todasLasPistasHacenMatch() = pistas.all({pista => pista.hayMatch()})

  method aumentarCantidadDeCoincidenciasActual(){
    cantidadDeCoincidenciasActual += 1;
  }

  /*
  method ganar(){
    if(cantidadDeMatcheosActual == cantidadDeCoincidenciasParaGanar){
      //Mostrar un texto de victoria.
    }
  }
  */
}