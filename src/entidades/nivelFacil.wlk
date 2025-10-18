import wollok.game.*
import nivel.*


class NivelFacil inherits Nivel {

method initialize(){
  // mostrarMensaje("¡Bienvenido al nivel fácil!")
  super(
      colores = ["azul.jpg", "rojo.jpg"],        // Solo 2 colores
      velocidadDeGeneracion = 2500,             // Cuadrados aparecen lentamente (2.5 segundos)
      velocidadDeMovimiento = 250,              // Cuadrados se mueven lentamente (0.25 segundos por paso)
      cantidadDeMatcheosParaGanar = 20           // 20 matcheos
  )
}
}
