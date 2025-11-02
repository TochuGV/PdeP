import wollok.game.*
import entidades.pista.*
import entidades.puntaje.*
import entidades.flechaIndicadora.*
import entidades.dificultad.*
import src.pantallas.handlerPantalla.*
import src.juego.*
class Nivel {
  var property dificultad;
  var cantidadDeCoincidenciasActual = 0;
  
  const alturaBase = (540 / 50) - (150 / 50);
  const separadorDePosicionesDePistas = 2.25;
  const posicionesDePistas = [game.at(2, alturaBase), game.at(2, (540 / 50) - (150 / 50) * separadorDePosicionesDePistas)];
  // La segunda pista hay que escribirla de esa forma porque sino no aparece.
  // Habría que buscar una forma de hacer que tome la altura de la pantalla y las dimensiones de los cuadrados.
  const pistas = [];

  method cantidadDeCoincidenciasActual () = cantidadDeCoincidenciasActual;
  method pistas () = pistas;

  method colores() = dificultad.colores()
  method velocidadDeGeneracion() = dificultad.velocidadDeGeneracion()
  method velocidadDeMovimiento() = dificultad.velocidadDeMovimiento()

  method iniciar(){
    puntaje.aparecer();

    var indiceColor = 0;
    posicionesDePistas.forEach({ posicionBase =>
      const nuevaPista = new Pista(
        nivel = self,
        indiceColorActual = indiceColor, 
        position = posicionBase
      );
      pistas.add(nuevaPista);
      nuevaPista.iniciar();
      indiceColor = (indiceColor + 1) % self.colores().size();
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
      self.chequearCambioDeNivel();
      //if (cantidadDeCoincidenciasActual == 10) {
        //self.aumentarDificultad();
      //}
    } else {
      self.perder();
    }
  }

  method perder(){
    handlerPantalla.siguientePantalla();
  }

  method todasLasPistasHacenMatch() = pistas.all({pista => pista.hayMatch()})

  method chequearCambioDeNivel(){
    if(cantidadDeCoincidenciasActual == dificultad.cantidadDeCoincidenciasParaAvanzar()){
      cantidadDeCoincidenciasActual = 0;
      juego.siguienteDificultad();
    }
    else {
      cantidadDeCoincidenciasActual += 1;
    }
  }


}