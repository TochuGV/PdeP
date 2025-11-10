import wollok.game.*

class EfectoSonido {
  const nombre
  const sonido = game.sound(nombre)

  method reproducir() {
    sonido.play()
  }
}