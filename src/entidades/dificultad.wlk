class Dificultad {
  var property nombre;
  var property colores;
  var property fondo;
  var property velocidadDeGeneracion;
  var property velocidadDeMovimiento;
  var property cantidadDeCoincidenciasParaAvanzar;
  var property posicionesDePistas;
}

object dificultades{
  var property lista = [facil, normal, dificil, imposible];

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
    fondo = "fondo-normal.jpg",
    velocidadDeGeneracion = 4000,
    velocidadDeMovimiento = 150,
    cantidadDeCoincidenciasParaAvanzar = 1,
    posicionesDePistas = [game.at(2, game.center().y() + 10), game.at(2, game.center().y() + 6), game.at(2, game.center().y() + 2)]
  );

  const dificil = new Dificultad(
    nombre = "DIFICIL",
    colores = ["azul.png", "rojo.png", "verde.png", "amarillo.png"],
    fondo = "fondo-normal.jpg",
    velocidadDeGeneracion = 3000,
    velocidadDeMovimiento = 100,
    cantidadDeCoincidenciasParaAvanzar = 1,
    posicionesDePistas = [game.at(2, game.center().y() + 10), game.at(2, game.center().y() + 6), game.at(2, game.center().y() + 2)]
  );

  const imposible = new Dificultad(
    nombre = "IMPOSIBLE",
    colores = ["azul.png", "rojo.png", "verde.png", "amarillo.png"],
    fondo = "fondo-normal.jpg",
    velocidadDeGeneracion = 2000,
    velocidadDeMovimiento = 100,
    cantidadDeCoincidenciasParaAvanzar = 999,
    posicionesDePistas = [game.at(2, game.center().y() + 10), game.at(2, game.center().y() + 6), game.at(2, game.center().y() + 2)]
  );
}