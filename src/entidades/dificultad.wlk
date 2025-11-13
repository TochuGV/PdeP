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
  const todosLosColores = ["azul.png", "rojo.png", "verde.png", "amarillo.png"];
  const posicionesDosPistas = [game.at(2, game.center().y() + 8), game.at(2, game.center().y() + 4)];
  const posicionesTresPistas = [game.at(2, game.center().y() + 10), game.at(2, game.center().y() + 6), game.at(2, game.center().y() + 2)];
  const fondoDosPistas = "fondo-dos-pistas.jpg";
  const fondoTresPistas = "fondo-tres-pistas.jpg";

  const facil = new Dificultad(
    nombre = "FACIL",
    colores = todosLosColores.take(2),
    fondo = fondoDosPistas,
    velocidadDeGeneracion = 5000,
    velocidadDeMovimiento = 200,
    cantidadDeCoincidenciasParaAvanzar = 3,
    posicionesDePistas = posicionesDosPistas
  );

  const normal = new Dificultad(
    nombre = "NORMAL",
    colores = todosLosColores.take(3),
    fondo = fondoTresPistas,
    velocidadDeGeneracion = 4000,
    velocidadDeMovimiento = 150,
    cantidadDeCoincidenciasParaAvanzar = 3,
    posicionesDePistas = posicionesTresPistas
  );

  const dificil = new Dificultad(
    nombre = "DIFICIL",
    colores = todosLosColores,
    fondo = fondoTresPistas,
    velocidadDeGeneracion = 3000,
    velocidadDeMovimiento = 100,
    cantidadDeCoincidenciasParaAvanzar = 3,
    posicionesDePistas = posicionesTresPistas
  );

  const imposible = new Dificultad(
    nombre = "IMPOSIBLE",
    colores = todosLosColores,
    fondo = fondoTresPistas,
    velocidadDeGeneracion = 2000,
    velocidadDeMovimiento = 100,
    cantidadDeCoincidenciasParaAvanzar = 999,
    posicionesDePistas = posicionesTresPistas
  );
}