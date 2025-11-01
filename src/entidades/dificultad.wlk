class Dificultad {
  const nombre;
  const colores;
  const velocidadDeGeneracion;
  const velocidadDeMovimiento;
  const cantidadDeCoincidenciasParaAvanzar;
}

object dificultades{
  var property lista = [facil, normal, dificil];

  const facil = new Dificultad(
    nombre = "FACIL",
    colores = ["azul.jpg", "rojo.jpg"],
    velocidadDeGeneracion = 5000,
    velocidadDeMovimiento = 200,
    cantidadDeCoincidenciasParaAvanzar = 5
  );

  const normal = new Dificultad(
    nombre = "NORMAL",
    colores = ["azul.jpg", "rojo.jpg", "verde.jpg"],
    velocidadDeGeneracion = 4000,
    velocidadDeMovimiento = 150,
    cantidadDeCoincidenciasParaAvanzar = 10
  );

  const dificil = new Dificultad(
    nombre = "DIFICIL",
    colores = ["azul.jpg", "rojo.jpg", "verde.jpg", "amarillo.jpg"],
    velocidadDeGeneracion = 3000,
    velocidadDeMovimiento = 100,
    cantidadDeCoincidenciasParaAvanzar = 15
  )
}