import wollok.game.*
import entidades.pista.*
import entidades.puntaje.*
import entidades.flechaIndicadora.*
class Nivel {
  const colores = [];
  const velocidadDeGeneracion;
  const velocidadDeMovimiento;
  const cantidadDeMatcheosParaGanar;
  const posicionesDePistas = [game.at(1,540 / 50 - 150 / 50), game.at(1,(540 / 50) - (150 / 50) *2 )]; //HARDCODED
  const pistas = [];
  var flechaIndicadora = null;

  method colores () = colores;
  method velocidadDeGeneracion () = velocidadDeGeneracion;
  method velocidadDeMovimiento () = velocidadDeMovimiento;
  method cantidadDeMatcheosParaGanar () = cantidadDeMatcheosParaGanar;

  method iniciar(){
    puntaje.aparecer();

    var indiceColor = 0
    posicionesDePistas.forEach({ posicionBase =>
      const nuevaPista = new Pista(colores = colores, indiceColorActual = indiceColor, position = posicionBase);
      pistas.add(nuevaPista);
      nuevaPista.iniciar(self);
      indiceColor = (indiceColor + 1) % colores.size();
    });

    flechaIndicadora = new FlechaIndicadora( pistas = pistas);
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
      pistas.forEach({pista => pista.removerCuadradoDinamico()})
    } else {
      self.perder();
    }
  }

  method perder(){
    game.removeTickEvent("generarCuadradosDinamicos");
    game.removeTickEvent("movimientoCuadrado");
  }

  method todasLasPistasHacenMatch() = pistas.all({pista => pista.hayMatch()})
}