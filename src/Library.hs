module Library where
import PdePreludat

---------------------------------------- ENTREGA 1 ----------------------------------------

-- 1. Modelar el auto 
data Auto = UnAuto { 
  marca :: Marca,
  modelo :: Modelo,
  desgasteChasis :: Number,
  desgasteRuedas :: Number,
  velocidadMáxima :: Number,
  tiempoCarrera :: Number,
  apodos :: [String]
} deriving (Show, Eq) 

data Marca = Lamborghini | Ferrari | Fiat | Peugeot | Tesla deriving (Show, Ord, Eq)
data Modelo = F50 | Diablo | F600 | P504 | X deriving (Show, Ord, Eq)

-- a. Auto Ferrari
ferrari :: Auto
ferrari = UnAuto { marca = Ferrari, modelo = F50, desgasteChasis = 0, desgasteRuedas = 0, velocidadMáxima = 65, tiempoCarrera = 0, apodos = ["La nave", "El fierro", "Ferrucho"] }

-- b. Auto Lamborghini
lamborghini :: Auto
lamborghini = UnAuto { marca = Lamborghini, modelo = Diablo, desgasteChasis = 7, desgasteRuedas = 4, velocidadMáxima = 73, tiempoCarrera = 0, apodos = ["Lambo", "La bestia"] }

-- c. Auto Fiat
fiat :: Auto
fiat = UnAuto { marca = Fiat, modelo = F600, desgasteChasis = 33, desgasteRuedas = 27, velocidadMáxima = 44, tiempoCarrera = 0, apodos = ["La Bocha", "La bolita", "Fitito"] }

-- d. Auto Peugeot
peugeot :: Auto
peugeot = UnAuto { marca = Peugeot, modelo = P504, desgasteChasis = 0, desgasteRuedas = 0, velocidadMáxima = 40, tiempoCarrera = 0, apodos = ["El rey del desierto"] }

-- 2. Estado de salud del auto

-- a. Saber si un auto está en buen estado
buenEstado :: Auto -> Bool
buenEstado UnAuto {marca = Peugeot} = False
buenEstado auto
  | tiempoCarrera auto < 100 = desgasteChasis auto < 20
  | otherwise = desgasteRuedas auto < 60 && desgasteChasis auto < 40
  -- | desgasteRuedas auto < 60 = desgasteChasis auto < 40
  -- | otherwise = False

-- b. Saber si un auto no da más
noDaMas :: Auto -> Bool
noDaMas auto = take 2 (head (apodos auto)) == "La" && desgasteChasis auto > 80 || desgasteRuedas auto > 80

-- c. Saber si un auto es un chiche
cantidadDeApodos :: Auto -> Number
cantidadDeApodos auto = length (apodos auto)

esChiche :: Auto -> Bool
esChiche auto
  | even (cantidadDeApodos auto) = desgasteChasis auto < 20
  | otherwise = desgasteChasis auto < 50

-- d. Saber si un auto es una joya
esJoya :: Auto -> Bool
esJoya auto = desgasteChasis auto == 0 && desgasteRuedas auto == 0 && (cantidadDeApodos auto <= 1) 

-- e. Conocer el nivel de chetez de un auto
nivelDeChetez :: Auto -> Number
nivelDeChetez auto = 20 * cantidadDeApodos auto * length (show (modelo auto))

-- f. Determinar la  capacidad supercalifragilisticaespialidosa de un auto
capacidadSupercalifragilisticaespialidosa :: Auto -> Number
capacidadSupercalifragilisticaespialidosa auto = length (head (apodos auto))

-- g. Calcular qué tan riesgoso es un auto.
riesgo :: Auto -> Number
riesgo auto = velocidadMáxima auto * 0.1 * desgasteRuedas auto

nivelDeRiesgo :: Auto -> Number
nivelDeRiesgo auto
  | not (buenEstado auto) = riesgo auto * 2
  | otherwise = riesgo auto

-- 3. Manos a la obra

-- a. Reparar un Auto 
repararAuto :: Auto -> Auto
repararAuto auto = auto { desgasteChasis = desgasteChasis auto * 0.15, desgasteRuedas = 0 }

-- b. Aplicar una penalidad de tiempo a un auto
aplicarPenalidad :: Auto -> Number -> Auto
aplicarPenalidad auto tiempo = auto { tiempoCarrera = tiempoCarrera auto + tiempo }

-- c. Ponerle nitro a un auto
ponerNitro :: Auto -> Auto
ponerNitro auto = auto { velocidadMáxima = velocidadMáxima auto  * 1.2}

-- d. Bautizar un auto
bautizarAuto :: Auto -> String -> Auto
bautizarAuto auto nuevoApodo = auto {apodos = apodos auto ++ [nuevoApodo] }

-- e. LLevar un auto a un desarmadero
desarmadero :: Auto -> Marca -> Modelo -> Auto
desarmadero auto marcaNueva modeloNuevo = auto { marca = marcaNueva, modelo = modeloNuevo, apodos = ["Nunca taxi"] }

-- 4. ¡Pistas!

-- a. El tramo curva
anguloPeligroso, longitudPeligrosa, anguloTranca, longitudTranca :: Number
anguloPeligroso = 60
longitudPeligrosa = 300
anguloTranca = 110
longitudTranca = 550

calculoDesgasteTramo :: Number -> Number -> Number -> Number
calculoDesgasteTramo desgasteActual longitud angulo = (3 * longitud / angulo) + desgasteActual 

sumaTiempo :: Number -> Number -> Number
sumaTiempo longitud velocidad = longitud / (velocidad / 2)

curvaPeligrosa :: Auto -> Auto
curvaPeligrosa auto = auto { desgasteRuedas = calculoDesgasteTramo (desgasteRuedas auto) longitudPeligrosa anguloPeligroso, tiempoCarrera = tiempoCarrera auto + sumaTiempo longitudPeligrosa (velocidadMáxima auto) }

curvaTranca :: Auto -> Auto
curvaTranca auto = auto { desgasteRuedas = calculoDesgasteTramo (desgasteRuedas auto) longitudTranca anguloTranca, tiempoCarrera = tiempoCarrera auto + sumaTiempo longitudTranca (velocidadMáxima auto) } 

-- b. El tramo recto
longitudTramoRectoClassic, longitudTramito :: Number
longitudTramoRectoClassic = 715
longitudTramito = 260

afectarChasis :: Auto -> Number -> Number
afectarChasis auto longitud = desgasteChasis auto + (0.01 * longitud)

tiempoAgregadoPorTramoRecto :: Auto -> Number -> Number
tiempoAgregadoPorTramoRecto auto longitud = tiempoCarrera auto + longitud / velocidadMáxima auto

tramoRectoClassic :: Auto -> Auto
tramoRectoClassic auto = auto { desgasteChasis = afectarChasis auto longitudTramoRectoClassic, tiempoCarrera = tiempoAgregadoPorTramoRecto auto longitudTramoRectoClassic }

tramito :: Auto -> Auto
tramito auto = auto { desgasteChasis = afectarChasis auto longitudTramito, tiempoCarrera = tiempoAgregadoPorTramoRecto auto longitudTramito }

-- c. El tramo zigzag
cambiosDirecciónZigZagLoco, cambiosDirecciónCasiCurva :: Number
cambiosDirecciónZigZagLoco = 5
cambiosDirecciónCasiCurva = 1

tiempoDeCambios :: Number -> Number
tiempoDeCambios cambios = cambios * 3

desgasteRuedasTramoZigZag :: Auto -> Number -> Number
desgasteRuedasTramoZigZag auto cambios = velocidadMáxima auto * cambios / 10

zigZagLoco :: Auto -> Auto
zigZagLoco auto = auto { desgasteChasis = desgasteChasis auto + 5, desgasteRuedas = desgasteRuedasTramoZigZag auto cambiosDirecciónZigZagLoco, tiempoCarrera = tiempoCarrera auto + tiempoDeCambios cambiosDirecciónZigZagLoco }

casiCurva :: Auto -> Auto
casiCurva auto = auto { desgasteChasis = desgasteChasis auto + 5, desgasteRuedas = desgasteRuedas auto + desgasteRuedasTramoZigZag auto cambiosDirecciónCasiCurva, tiempoCarrera = tiempoCarrera auto + tiempoDeCambios cambiosDirecciónCasiCurva }

-- d. El tramo rulo en el aire
factorDesgasteRulo, factorSumaRulo, diametroClasico, diametroDeMuerte :: Number
factorDesgasteRulo = 1.5
factorSumaRulo = 5
diametroClasico = 13
diametroDeMuerte = 26

calculoDesgasteRulo :: Number -> Number -> Number
calculoDesgasteRulo desgasteActual diametro = desgasteActual + diametro * factorDesgasteRulo

sumaTiempoRulo :: Number -> Number -> Number
sumaTiempoRulo diametro velocidad = factorSumaRulo * diametro / velocidad

ruloClasico :: Auto -> Auto
ruloClasico auto = auto { desgasteRuedas = calculoDesgasteRulo (desgasteRuedas auto) diametroClasico, tiempoCarrera = tiempoCarrera auto + sumaTiempoRulo diametroClasico (velocidadMáxima auto) }

deseoDeMuerte :: Auto -> Auto
deseoDeMuerte auto = auto { desgasteRuedas = calculoDesgasteRulo (desgasteRuedas auto) diametroDeMuerte, tiempoCarrera = tiempoCarrera auto + sumaTiempoRulo diametroDeMuerte (velocidadMáxima auto) }

-- 5. Nivel de joyez

-- a. Calcular nivel de joyez para una serie de autos
calcularNivelDeJoyez :: [Auto] -> Number
calcularNivelDeJoyez autos = sum (map calcularUnidadesJoyez autos)

calcularUnidadesJoyez :: Auto -> Number
calcularUnidadesJoyez auto 
  | not (esJoya auto) = 0
  | tiempoCarrera auto < 50 = 1
  | otherwise = 2

-- b. Determinar si un grupo de autos son para entendidos
tiempoValido :: Auto -> Bool
tiempoValido auto = tiempoCarrera auto <= 200

paraEntendidos :: [Auto] -> Bool
paraEntendidos autos = all buenEstado autos && all tiempoValido autos

--------- ENTREGA 2 -----------------

-- 1. Equipos de competición
data Equipo = UnEquipo { 
  nombre :: String,
  autos :: [Auto],
  presupuesto :: Number
} deriving (Show, Eq) 

data Accion = Inscribir | Reparar | Optimizar | Ferrarizar deriving (Show, Ord, Eq)

-- a. Modelar un equipo de competición y agregar un auto a un equipo
holaMundoTeam :: Equipo
holaMundoTeam = UnEquipo { nombre = "HolaMundo", autos = [], presupuesto = 70000 }

agregarAuto :: Equipo -> Auto -> Equipo
agregarAuto equipo auto
  | tienePresupuestoParaAccion Inscribir auto (presupuesto equipo) = equipo { autos = autos equipo ++ [auto], presupuesto = presupuesto equipo - calcularCostoAccion Inscribir auto }
  | otherwise = equipo

tienePresupuestoParaAccion :: Accion -> Auto -> Number -> Bool
tienePresupuestoParaAccion accion auto presupuestoEquipo = ((<presupuestoEquipo) . calcularCostoAccion accion) auto

calcularCostoAccion :: Accion -> Auto -> Number
calcularCostoAccion Inscribir auto = velocidadMáxima auto * 1000
calcularCostoAccion Optimizar auto = velocidadMáxima auto * 100
calcularCostoAccion Reparar auto = ((*500) . puntosChasisReparar) (desgasteChasis auto)
calcularCostoAccion Ferrarizar auto 
  | marca auto == Ferrari = 0
  | otherwise = 3500

puntosChasisReparar :: Number -> Number
puntosChasisReparar desgasteChasis = desgasteChasis * 0.85

-- b. c. d. -> Reparar, optimizar y ferrarizar en equipo
realizarAccionEnEquipo :: Accion -> Equipo -> Equipo
realizarAccionEnEquipo accion equipo = equipo { autos = realizarAccionAutos accion (presupuesto equipo) (autos equipo), presupuesto = determinarPresupuestoRestante accion (presupuesto equipo) (autos equipo) } 

determinarPresupuestoRestante :: Accion -> Number -> [Auto] -> Number
determinarPresupuestoRestante _ presupuesto [] = presupuesto
determinarPresupuestoRestante accion presupuesto (x:xs)
  | tienePresupuestoParaAccion accion x presupuesto = determinarPresupuestoRestante accion (presupuesto - calcularCostoAccion accion x) xs
  | otherwise = presupuesto

realizarAccionAutos :: Accion -> Number -> [Auto] -> [Auto]
realizarAccionAutos _ presupuesto [] = []
realizarAccionAutos accion presupuesto (x:xs)
  | tienePresupuestoParaAccion accion x presupuesto = aplicarAccion accion x : realizarAccionAutos accion (presupuesto - calcularCostoAccion accion x) xs
  | otherwise = x:xs

aplicarAccion :: Accion -> Auto -> Auto
aplicarAccion Reparar auto = repararAuto auto 
aplicarAccion Optimizar auto = ponerNitro auto
aplicarAccion Ferrarizar auto
  | marca auto == Ferrari = auto
  | otherwise = desarmadero auto Ferrari F50

-- 2. Calcular costo accion total

calcularCostoReparacionTotal :: Equipo -> Number
calcularCostoReparacionTotal  = calcularCostoAccionTotal Reparar 

calcularCostoAccionTotal :: Accion -> Equipo -> Number
calcularCostoAccionTotal accion equipo = foldr ((+) . calcularCostoAccion accion) 0 (autos equipo)

-- 3. Infinia

-- a. Modelar el equipo Infinia
infinia :: Equipo 
infinia = UnEquipo { nombre = "Infinia", autos = generarFerrarisInfinitos 1, presupuesto = 5000 }

generarFerrari :: Number -> Auto
generarFerrari multiplicadorVelocidad = ferrari { velocidadMáxima = velocidadMáxima ferrari * multiplicadorVelocidad }

generarFerrarisInfinitos :: Number -> [Auto]
generarFerrarisInfinitos multiplicadorVelocidad = generarFerrari multiplicadorVelocidad : generarFerrarisInfinitos (multiplicadorVelocidad + 1)

-- b. Contestar que sucede si:
  
  -- i. Se realiza una reparación en equipo de ese equipo.
    -- Se reparan tantos autos como el presupuesto lo permita, es decir, hasta que el presupuesto sea menor al costo de la reparación.
  
  -- ii. Se optimizan los autos de ese equipo.
    -- Se optimizan tantos autos como el presupuesto lo permita, es decir, hasta que el presupuesto sea menor al costo de la optimización.
  
  -- iii. Se ferrarizan sus autos.
    -- Se ferrarizan tantos autos como el presupuesto lo permita, es decir, hasta que el presupuesto sea menor al costo de la ferrarización.
  
  -- iv. Se quiere conocer el costo total de reparación del equipo.
    -- Va a entrar en un bucle infinito, por lo que el costo total de reparación nunca finalizará de calcularse debido a que la lista de autos es infinita.

-- 4. Modificadores de tramos                       TRAMOS: 1. TRAMITO 2. CURVA TRANCA 3. CURVA PELIGROSA 4. ZIG ZAG LOCO 5. RULO CLASICO 6. DESEO DE MUERTE 7. TRAMO RECTO CLASSIC 8. CASI CURVA

type Tramo = Auto -> Auto

-- a. Tramo con boxes
tramoConBoxes :: Tramo -> Auto -> Auto 
tramoConBoxes tramo auto
  | not (buenEstado (tramo auto)) = repararAuto (aplicarPenalidad (tramo auto) 10)
  | otherwise = tramo auto

-- b. Tramo mojado
tramoMojado :: Tramo -> Auto -> Auto 
tramoMojado tramo auto = tramo auto { tiempoCarrera = tiempoCarrera (tramo auto) * 1.5 }

-- c. Tramo con ripio
tramoConRipio :: Tramo -> Auto -> Auto
tramoConRipio tramo auto = tramo auto { desgasteChasis = desgasteChasis (tramo auto) * 2, desgasteRuedas = desgasteRuedas (tramo auto) * 2, tiempoCarrera = tiempoCarrera (tramo auto) * 2 }

-- d. Tramo con alguna obstrucción
tramoConObstruccion :: Number -> Tramo -> Auto -> Auto
tramoConObstruccion metrosObstruidos tramo auto = tramo auto { desgasteRuedas = desgasteRuedas (tramo auto) + (metrosObstruidos * 2) }

-- e. Tramo con turbo
tramoTurboDurante :: Tramo -> Auto -> Auto
tramoTurboDurante tramo auto = tramo auto {velocidadMáxima = velocidadMáxima auto * 2}

tramoTurboDespues :: Tramo -> Auto -> Auto
tramoTurboDespues tramo auto = tramo auto {velocidadMáxima = velocidadMáxima auto / 2}

--tramoConTurbo :: Tramo -> Auto -> Auto
--tramoConTurbo tramo auto = (tramo (auto { velocidadMáxima = velocidadMáxima auto * 2 })) { velocidadMáxima = velocidadMáxima auto }

-- 5. Realizar la función que haga pasarPorTramo/2
pasarPorTramo :: Tramo -> Auto -> Auto
pasarPorTramo tramo auto
  | noDaMas (tramo auto) = auto
  | not (noDaMas (tramo auto)) = tramo auto

-- pasarPorTramo (curvaTranca con Ripio) auto

-- 6. Atravesando pistas

data Pista = UnaPista {
  nombrePista :: String,
  pais :: String,
  precioBaseEntrada :: Number,
  tramos :: [Tramo]
} deriving (Show, Ord, Eq)

-- a. Crear la vueltaALaManzana

longitudTramoRecto, longitudCurva, anguloCurva :: Number
longitudTramoRecto = 130
longitudCurva = 13
anguloCurva = 90 --Revisar esto

tramoRecto :: Tramo
tramoRecto auto = auto { desgasteChasis = afectarChasis auto longitudTramoRecto , tiempoCarrera = tiempoAgregadoPorTramoRecto auto longitudTramoRecto }

curva :: Tramo
curva auto = auto { desgasteRuedas = calculoDesgasteTramo (desgasteRuedas auto) longitudCurva 90, tiempoCarrera = tiempoCarrera auto + sumaTiempo longitudCurva (velocidadMáxima auto) }

vueltaALaManzana :: Pista
vueltaALaManzana = UnaPista { nombrePista = "La manzana", pais = "Italia", precioBaseEntrada = 30, tramos = [tramoRecto, curva, tramoRecto, curva, tramoRecto, curva, tramoRecto, curva] }

-- b. Crear la superPista

-- c. Hacer la función peganLaVuelta/2

-- 7. ¡¡Y llegaron las carreras!!

-- a. Modelar una carrera

-- b. Representar el tourBuenosAires

-- c.

  --i. El auto ganador luego de todas las vueltas de la carrera.
    --
  --ii. El tiempo total del segundo.
    --
  --iii. El tiempo parcial tras 2 vueltas del primer auto.
    --
  --iv. Cantidad de autos que terminaron la carrera.
    --

-- d.