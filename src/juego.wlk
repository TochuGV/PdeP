import wollok.game.*
import entidades.cuadradoDinamico.*
import entidades.cuadradoEstatico.*
import entidades.pista.*
import entidades.nivel.*

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
  var property cuadradosEstaticos = [];
  
  method iniciar(){
    const nivel = new Nivel(
      colores = ["azul.jpg", "rojo.jpg"],
      velocidadDeGeneracion = 5000,
      velocidadDeMovimiento = 100,
      cantidadDeMatcheosParaGanar = 10
    );
    nivel.iniciar();
  }

  /*
  //self.generarCuadradosDinamicos(nivel.velocidadDeGeneracion(), nivel.velocidadDeMovimiento(), nivel.colores());
  method generarCuadradosDinamicos(velocidadDeGeneracion, velocidadDeMovimiento, colores){
    game.onTick(velocidadDeGeneracion, "cuadradosDinamicos", { self.generarCuadradoDinamico(velocidadDeMovimiento, colores) });
  }

  method generarCuadradoDinamico(velocidadDeMovimiento, colores){
    const nuevoCuadrado = new CuadradoDinamico(image = colores.anyOne(), position = game.center());
    cuadradosDinamicos.add(nuevoCuadrado);
    game.addVisual(nuevoCuadrado);
    nuevoCuadrado.iniciarMovimiento(velocidadDeMovimiento/*, cuadradosEstaticos*///);
  //}
}