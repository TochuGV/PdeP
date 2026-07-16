# Switch!

## Introducción

El juego consiste en hacer coincidir el color de unos cuadrados estáticos con el color de unos cuadrados dinámicos que se acercan por el lado derecho de la pantalla. El jugador controla una flecha indicadora mediante las flechas de arriba y abajo del teclado para seleccionar la pista y usa la tecla ‘S’ para cambiar el color del cuadrado estático actual, asegurándose de que el color sea el correcto justo antes de que los cuadrados se superpongan entre sí.

## Conceptos aplicados del paradigma

 - **Colecciones:**
Se utilizaron colecciones para almacenar datos como los cuadrados estáticos activos en la pista o los colores disponibles en el nivel.

- **Clases:**
  - **Nivel:** Contiene información como la velocidad de movimiento de los cuadrados dinámicos, la cantidad de pistas disponibles, las verificaciones de resultado, etc.

  - **Cuadrado:** Contiene los métodos necesarios de renderizado para los cuadrados estáticos y dinámicos

  - **CuadradoEstatico:** Son los cuadrados que deberemos switchear para ganar, por el momento contiene los métodos necesarios para cambiar su color

  - **CuadradoDinamico:** Son los cuadrados con los que deberemos matchear, contiene los métodos necesarios para ejecutar un movimiento bajo una velocidad determinada.

- **Herencia:**
Hay una clase ‘**Cuadrado**’, la cual contiene los atributos ‘*image*’ y ‘*position*’, y los métodos ‘*aparecer()*’ y ‘*desaparecer()*’. En base a esta clase, existen dos clases hijas, ‘**CuadradoEstatico**’ y ‘**CuadradoDinamico**’.
Ambas clases tienen el molde para ser un cuadrado. A la primera se le agrega el método de ‘*cambiarColor()*’. El cuadrado dinámico no tiene por qué cambiar de color. En cambio, a la segunda se le añaden métodos tales como ‘*avanzar()*’ o ‘*iniciarMovimiento()*’. Los cuadrados estáticos no deberían moverse.

<img width="1242" height="700" alt="Paradigmas de Programación - Diagrama de Switch! drawio" src="https://github.com/user-attachments/assets/9ce3404d-864c-410f-b800-4759819da656" />
