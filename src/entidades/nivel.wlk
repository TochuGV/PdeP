import wollok.game.*
import entidades.pista.*

class Nivel {
  const colores = [];
  const velocidadDeGeneracion;
  const velocidadDeMovimiento;
  const cantidadDeMatcheosParaGanar;
  const posicionesDePistas = [game.at(2,2), game.at(20,20)]; //HARDCODED

  method colores () = colores;
  method velocidadDeGeneracion () = velocidadDeGeneracion;
  method velocidadDeMovimiento () = velocidadDeMovimiento;
  method cantidadDeMatcheosParaGanar () = cantidadDeMatcheosParaGanar;

  method iniciar(){
    posicionesDePistas.forEach({ posicionBase => 
      const nuevaPista = new Pista(image = colores.anyOne(), position = posicionBase);
      game.addVisual(nuevaPista);
      nuevaPista.iniciar(self);
    });
  }
}