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
  const property tiempoGeneracionCuadrados = 2000;
  const property velocidadDeMovimiento = 500;
  method iniciar(){
  /*self.generarCuadradosEstaticos();*/
    self.generarCuadradosDinamicos();
  }

  method generarCuadradosEstaticos(){
    // Genera dos cuadrados estaticos
  }
  
  method generarCuadradosDinamicos(){
    game.onTick(tiempoGeneracionCuadrados, "cuadradosDinamicos", {self.generarCuadradoDinamico()});
  }

  method generarCuadradoDinamico(){
    const nuevoCuadrado = new CuadradoDinamico(image = "azul.jpg", position = game.center());
    cuadradosDinamicos.add(nuevoCuadrado);
    game.addVisual(nuevoCuadrado);
    nuevoCuadrado.iniciarMovimiento(velocidadDeMovimiento);
  }
}