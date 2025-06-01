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
  presupuesto :: Number,
  autos :: [Auto]
} deriving (Show, Eq) 

-- a. Modelar un equipo de competición
holaMundoTeam :: Equipo
holaMundoTeam = UnEquipo { nombre = "HolaMundo", presupuesto = 70000, autos = [] }

costoInscripcion :: Auto -> Number
costoInscripcion auto = velocidadMáxima auto * 1000

-- Agregar un auto al equipo si el costo no supera al presupuesto
agregarAuto :: Auto -> Equipo -> Equipo
agregarAuto nuevoAuto equipo  
  | costoInscripcion nuevoAuto <= presupuesto equipo = equipo { presupuesto = presupuesto equipo - costoInscripcion nuevoAuto, autos = autos equipo ++ [nuevoAuto]}
  | otherwise = equipo

equipo1 :: Equipo
equipo1 = UnEquipo { nombre = "Equipo1", presupuesto = 20000, autos = [ferrariEq, lamborghiniEq] }
equipo2 :: Equipo
equipo2 = UnEquipo { nombre = "Equipo2", presupuesto = 10000, autos = [fiatEq] }
equipo3 :: Equipo
equipo3 = UnEquipo { nombre = "Equipo3", presupuesto = 10000, autos = [ferrariEq, lamborghiniEq] }
equipo4 :: Equipo
equipo4 = UnEquipo { nombre = "Equipo4", presupuesto = 50000, autos = [peugeotEq] }

fiatEq :: Auto
fiatEq = UnAuto { marca = Fiat, modelo = F600, desgasteChasis = 50, desgasteRuedas = 0, velocidadMáxima = 44, tiempoCarrera = 0, apodos = [] }

ferrariEq :: Auto
ferrariEq = UnAuto { marca = Ferrari, modelo = F50, desgasteChasis = 10, desgasteRuedas = 0, velocidadMáxima = 65, tiempoCarrera = 0, apodos = [] }

lamborghiniEq :: Auto
lamborghiniEq = UnAuto { marca = Lamborghini, modelo = Diablo, desgasteChasis = 20, desgasteRuedas = 0, velocidadMáxima = 73, tiempoCarrera = 0, apodos = [] }

peugeotEq :: Auto
peugeotEq = UnAuto { marca = Peugeot, modelo = P504, desgasteChasis = 0, desgasteRuedas = 0, velocidadMáxima = 80, tiempoCarrera = 0, apodos = [] }

-- b. Realizar una reparación en equipo
repararChasis :: Equipo -> Equipo
repararChasis equipo
  | precioReparacion equipo <= presupuesto equipo = equipo { presupuesto = presupuesto equipo - precioReparacion equipo, autos = map reparacion (autos equipo)}
  | otherwise = equipo

precioReparacion :: Equipo -> Number
precioReparacion equipo = calcularPrecio (autos equipo)

calcularPrecio :: [Auto] -> Number
calcularPrecio  = foldr (\ auto -> (+) (desgasteChasis auto * 0.85 * 500)) 0

reparacion :: Auto -> Auto
reparacion auto = auto { desgasteChasis = desgasteChasis auto * 0.15 }

-- c. Optimizar autos en equipo
optimizacion :: Equipo -> Equipo
optimizacion equipo = optimizar (autos equipo) (presupuesto equipo) (nombre equipo)

optimizar :: [Auto] -> Number -> String -> Equipo
optimizar [] presupuesto nombre = UnEquipo nombre presupuesto []
optimizar (auto:autos) presupuesto nombre
  | velocidadMáxima auto * 100 <= presupuesto = casoOptimizado (auto:autos) presupuesto nombre
  | otherwise = casoNoOptimizado (auto:autos) presupuesto nombre

casoOptimizado :: [Auto] -> Number -> String -> Equipo
casoOptimizado (auto:autos) presupuesto nombre =
  agregarAutoAlEquipo (aumentarVelocidad auto) (optimizar autos (presupuesto - velocidadMáxima auto * 100) nombre)

casoNoOptimizado :: [Auto] -> Number -> String -> Equipo
casoNoOptimizado (auto:autos) presupuesto nombre =
  agregarAutoAlEquipo auto (optimizar autos presupuesto nombre)

agregarAutoAlEquipo :: Auto -> Equipo -> Equipo
agregarAutoAlEquipo auto (UnEquipo nombre presupuesto lista) = UnEquipo nombre presupuesto (auto : lista)

aumentarVelocidad :: Auto -> Auto
aumentarVelocidad auto = auto { velocidadMáxima = velocidadMáxima auto * 1.2 }

-- d. Ferrarizar
ferrarizar :: Equipo -> Equipo
ferrarizar equipo = remarcar (autos equipo) (presupuesto equipo) (nombre equipo)

remarcar :: [Auto] -> Number -> String -> Equipo
remarcar [] presupuesto nombre = UnEquipo nombre presupuesto []
remarcar (auto:autos) presupuesto nombre
  | marca auto /= Ferrari && presupuesto >= 3500 = añadirAuto (cambiarMarca auto) (remarcar autos (presupuesto - 3500) nombre)
  | otherwise = añadirAuto auto (remarcar autos presupuesto nombre)

cambiarMarca :: Auto -> Auto
cambiarMarca auto = auto { marca = Ferrari, modelo = F50 }

añadirAuto :: Auto -> Equipo -> Equipo
añadirAuto auto (UnEquipo nombre presupuesto autos) = UnEquipo nombre presupuesto (auto : autos)

-- 2. Costo total de reparación

costoReparacion :: Equipo -> Number
costoReparacion equipo = costoAutos (autos equipo)

costoAutos :: [Auto] -> Number
costoAutos = foldr (\ auto -> (+) (desgasteChasis auto * 500 * 0.85)) 0 

-- 3. Infinia

-- a. Modelar el equipo Infinia
autoFerrariConVelocidad :: Number -> Auto
autoFerrariConVelocidad n = UnAuto Ferrari F50 1 0 (n * 10) 0 []

autosInfinitos :: [Auto]
autosInfinitos = map autoFerrariConVelocidad [1..]

infinia :: Equipo
infinia = UnEquipo "Infinia" 5000 autosInfinitos

--Contestar qué sucede si:
--i. Se realiza una reparación en equipo de ese equipo.
--ii. Se optimizan los autos de ese equipo.
--iii. Se ferrarizan sus autos.
--iv. Se quiere conocer el costo total de reparación del equipo.

-- 3.b - RESPUESTAS
-- 3.b.i:  

-- 3. Infinia
-- a. Modelar el equipo Infinia
-- b. Contestar que sucede si:
--  i. Se realiza una reparación en equipo de ese equipo.
--  ii. Se optimizan los autos de ese equipo.
--  iii. Se ferrarizan sus autos.
--  iv. Se quiere conocer el costo total de reparación del equipo.

-- 4. Modificadores de tramos
-- a.
-- b.
-- c.
-- d.
-- e.
-- 5. Realizar la función que haga pasarPorTramo/2
-- 6. Atravesando pistas
-- a. Crear la vueltaALaManzana
-- b. Crear la superPista
-- c. Hacer la función peganLaVuelta/2
-- 7. ¡¡Y llegaron las carreras!!
-- a.
-- b.
-- c.
-- d.