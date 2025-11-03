import wollok.game.*
import entidades.pista.*
import entidades.puntaje.*
import entidades.flechaIndicadora.*
import entidades.dificultad.*
import src.pantallas.handlerPantalla.*
import src.juego.*

class Nivel {
  var property dificultad
  var cantidadDeCoincidenciasActual = 0
  const pistas = []

  method cantidadDeCoincidenciasActual() = cantidadDeCoincidenciasActual
  method pistas() = pistas
  method image() = dificultad.fondo()
  method position() = game.origin()
  method colores() = dificultad.colores()
  method velocidadDeGeneracion() = dificultad.velocidadDeGeneracion()
  method velocidadDeMovimiento() = dificultad.velocidadDeMovimiento()

  method iniciar() {
    game.addVisual(self)
    puntaje.aparecer()
    self.generarPistas()
    flechaIndicadora.aparecer()
  }

  method limpiarPistasAnteriores() {
    pistas.forEach({ pista => pista.desaparecer() })
    pistas.clear()
  }

  method generarPistas() {
    self.limpiarPistasAnteriores()
    var indiceColor = 0
    dificultad.posicionesDePistas().forEach(
      { posicionBase =>
        const nuevaPista = new Pista(
          nivel = self,
          indiceColorActual = indiceColor,
          position = posicionBase
        )
        pistas.add(nuevaPista)
        nuevaPista.iniciar()
        indiceColor = (indiceColor + 1) % self.colores().size()
      }
    )
    flechaIndicadora.pistas(pistas)
    self.agregarEventoDeColision()
  }

  method agregarEventoDeColision() {
    const pistaTestigo = pistas.get(0)
    game.whenCollideDo(
      pistaTestigo.cuadradoEstatico(),
      { cuadradoDinamico => self.verificarResultado() }
    )
  }

  method verificarResultado() {
    if (self.todasLasPistasHacenMatch()) {
      pistas.forEach({ pista => pista.removerCuadradoDinamico() })
      puntaje.sumarPuntos(10)
      self.chequearCambioDeNivel()
    } else {
      self.perder()
    }
  }

  method perder() {
    handlerPantalla.siguientePantalla()
  }

  method todasLasPistasHacenMatch() = pistas.all({ pista => pista.hayMatch() })

  method chequearCambioDeNivel() {
    if (cantidadDeCoincidenciasActual == dificultad.cantidadDeCoincidenciasParaAvanzar()) {
      cantidadDeCoincidenciasActual = 0
      juego.siguienteDificultad()
      self.generarPistas()
      flechaIndicadora.calibrarPosicion()
    } else {
      cantidadDeCoincidenciasActual += 1
    }
  }
}