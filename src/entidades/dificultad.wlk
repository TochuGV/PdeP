class Dificultad {
  var property nombre;
  var property colores;
  var property velocidadDeGeneracion;
  var property velocidadDeMovimiento;
  var property cantidadDeCoincidenciasParaAvanzar;
  var property posicionesDePistas = [];
  var property fondo;
}

object dificultades{
  var property lista = [facil, normal, dificil];

  const facil = new Dificultad(
    nombre = "FACIL",
    colores = ["azul.png", "rojo.png"],
    fondo = "fondo-facil.jpg",
    velocidadDeGeneracion = 5000,
    velocidadDeMovimiento = 200,
    cantidadDeCoincidenciasParaAvanzar = 1,
    posicionesDePistas = [game.at(2, game.center().y() + 8), game.at(2, game.center().y() + 4)]
  );

  const normal = new Dificultad(
    nombre = "NORMAL",
    colores = ["azul.png", "rojo.png", "verde.png"],
    velocidadDeGeneracion = 4000,
    fondo = "fondo-normal.jpg",
    velocidadDeMovimiento = 150,
    cantidadDeCoincidenciasParaAvanzar = 999,
    posicionesDePistas = [game.at(2, game.center().y() + 10), game.at(2, game.center().y() + 6), game.at(2, game.center().y() + 2)]
  );

  const dificil = new Dificultad(
    nombre = "DIFICIL",
    colores = ["azul.png", "rojo.png", "verde.png", "amarillo.png"],
    velocidadDeGeneracion = 3000,
    fondo = "fondo-normal.jpg",
    velocidadDeMovimiento = 100,
    cantidadDeCoincidenciasParaAvanzar = 1,
   posicionesDePistas = [game.at(1, game.center().y() + 10), game.at(1, game.center().y() + 6), game.at(1, game.center().y() + 2)]
  )
}