import src.entidades.nivel.*
import wollok.game.*
import entidades.cuadradoDinamico.*
import entidades.*

/*
src
  entidades
    cuadrado.wlk
    cuadradoEstatico.wlk
    cuadradoDinamico.wlk
    flechaIndicadora.wlk
    pista.wlk
  modificadores
    modificador.wlk
    multicolor.wlk
    lentitud.wlk
    duplicadorPuntuacion.wlk
  modos
    niveles.wlk
    infinito.wlk
  juego.wlk
  programa.wpgm
assets
*/

object juego {
  var property cuadradosDinamicos = [];
  method iniciar(){
  /*self.generarCuadradosEstaticos();*/
  const nivel = new Nivel(colores = ["azul.jpg", "rojo.jpg"], velocidadDeGeneracion = 5000, velocidadDeMovimiento = 500, cantidadDeMatcheosParaGanar = 10);
  self.generarCuadradosDinamicos(nivel.velocidadDeGeneracion(), nivel.velocidadDeMovimiento(), nivel.colores());
  }

  method generarCuadradosEstaticos(){
    // Genera dos cuadrados estaticos
  }
  
  method generarCuadradosDinamicos(velocidadDeGeneracion, velocidadDeMovimiento, colores){
    game.onTick(velocidadDeGeneracion, "cuadradosDinamicos", {self.generarCuadradoDinamico(velocidadDeMovimiento, colores)});
  }

  method generarCuadradoDinamico(velocidadDeMovimiento, colores){
    const nuevoCuadrado = new CuadradoDinamico(image = colores.anyOne(), position = game.center());
    cuadradosDinamicos.add(nuevoCuadrado);
    game.addVisual(nuevoCuadrado);
    nuevoCuadrado.iniciarMovimiento(velocidadDeMovimiento);
  }
}