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
  const posicionesDosPistas = [game.at(2, game.center().y() + 8), game.at(2, game.center().y() + 4)];
  const posicionesTresPistas = [game.at(2, game.center().y() + 10), game.at(2, game.center().y() + 6), game.at(2, game.center().y() + 2)];
  const fondoDosPistas = "fondo-dos-pistas.jpg";
  const fondoTresPistas = "fondo-tres-pistas.jpg";

  const facil = new Dificultad(
    nombre = "FACIL",
    colores = ["azul.png", "rojo.png"],
    fondo = fondoDosPistas,
    velocidadDeGeneracion = 5000,
    velocidadDeMovimiento = 200,
    cantidadDeCoincidenciasParaAvanzar = 1,
    posicionesDePistas = posicionesDosPistas
  );

  const normal = new Dificultad(
    nombre = "NORMAL",
    colores = ["azul.png", "rojo.png", "verde.png"],
    fondo = fondoTresPistas,
    velocidadDeGeneracion = 4000,
    velocidadDeMovimiento = 150,
    cantidadDeCoincidenciasParaAvanzar = 1,
    posicionesDePistas = posicionesTresPistas
  );

  const dificil = new Dificultad(
    nombre = "DIFICIL",
    colores = ["azul.png", "rojo.png", "verde.png", "amarillo.png"],
    fondo = fondoTresPistas,
    velocidadDeGeneracion = 3000,
    velocidadDeMovimiento = 100,
    cantidadDeCoincidenciasParaAvanzar = 1,
    posicionesDePistas = posicionesTresPistas
  );

  const imposible = new Dificultad(
    nombre = "IMPOSIBLE",
    colores = ["azul.png", "rojo.png", "verde.png", "amarillo.png"],
    fondo = fondoTresPistas,
    velocidadDeGeneracion = 2000,
    velocidadDeMovimiento = 100,
    cantidadDeCoincidenciasParaAvanzar = 999,
    posicionesDePistas = posicionesTresPistas
  );
}