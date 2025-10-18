import wollok.game.*
import nivel.*


class NivelDificil inherits Nivel {

method initialize(){ 
  // mostrarMensaje("¡Bienvenido al nivel dificil!")
  super(
      colores = ["azul.jpg", "rojo.jpg", "verde.jpg"], // agregamos un color más
      velocidadDeGeneracion = 800,              // Cuadrados aparecen muy rápido (0.8 segundos)
      velocidadDeMovimiento = 80,               // Cuadrados se mueven muy rápido (0.08 segundos por paso)
      cantidadDeMatcheosParaGanar = 40       // 10 matcheos más tmb.
  )
}
}
