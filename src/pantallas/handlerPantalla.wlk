import wollok.game.*
import pantallas.menu.*
import pantallas.juego.*
import pantallas.resultado.*
object handlerPantalla{
    const pantallas = [new Menu(), new Juego(), new Resultado()];
    var indicePantallaActual = 0;
    
    method inicializar(){
        pantallas.get(indicePantallaActual).aparecer();
    }

    method siguientePantalla(){
        pantallas.get(indicePantallaActual).desaparecer();
        indicePantallaActual = self.obtenerSiguientePantalla();
        pantallas.get(indicePantallaActual).aparecer();
    }

    method obtenerSiguientePantalla(){
        return (indicePantallaActual + 1) % pantallas.size();
    }
}