module Library where
import PdePreludat

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
buenEstado auto = marca auto /= Peugeot && (tiempoCarrera auto < 100 && desgasteChasis auto < 20 || tiempoCarrera auto >= 100 && desgasteChasis auto < 40 && desgasteRuedas auto < 60)

-- b. Saber si un auto no da más
noDaMas :: Auto -> Bool
noDaMas auto = take 2 (head (apodos auto)) == "La" && (desgasteChasis auto > 80 || desgasteRuedas auto > 80)

-- c. Saber si un auto es un chiche
cantidadDeApodos :: Auto -> Number
cantidadDeApodos auto = length (apodos auto)

esChiche :: Auto -> Bool
esChiche auto = (desgasteChasis auto < 20 && even (cantidadDeApodos auto)) || (desgasteChasis auto < 50 && odd (cantidadDeApodos auto))

-- d. Saber si un auto es una joya
esJoya :: Auto -> Bool
esJoya auto = desgasteChasis auto == 0 && (cantidadDeApodos auto <= 1) 

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
repararAuto auto = auto {desgasteChasis = desgasteChasis auto * 0.15, desgasteRuedas = 0}

-- b. Aplicar una penalidad de tiempo a un auto
aplicarPenalidad :: Auto -> Number -> Auto
aplicarPenalidad auto tiempo = auto {tiempoCarrera = tiempoCarrera auto + tiempo}

-- c. Ponerle nitro a un auto
ponerNitro :: Auto -> Auto
ponerNitro auto = auto{velocidadMáxima = velocidadMáxima auto  * 1.2}

-- d. Bautizar un auto
bautizarAuto :: Auto -> String -> Auto
bautizarAuto auto nuevoApodo = auto {apodos = apodos auto ++ [nuevoApodo]}

-- e. LLevar un auto a un desarmadero
desarmadero :: Auto -> Marca -> Modelo -> Auto
desarmadero auto marcaNueva modeloNuevo = auto {marca = marcaNueva, modelo = modeloNuevo, apodos = ["Nunca taxi"] }

-- 4. ¡Pistas!

-- a. El tramo curva
anguloPeligroso, longitudPeligrosa, anguloTranca, longitudTranca, factorMultiplicativo, factorDivision :: Number
anguloPeligroso = 60
longitudPeligrosa = 300
anguloTranca = 110
longitudTranca = 550
factorMultiplicativo = 3
factorDivision = 2

calculoDesgasteTramo :: Number -> Number -> Number -> Number
calculoDesgasteTramo desgasteActual longitud angulo = (factorMultiplicativo * longitud / angulo) + desgasteActual 

sumaTiempo :: Number -> Number -> Number
sumaTiempo longitud velocidad = longitud / (velocidad / factorDivision)

curvaPeligrosa :: Auto -> Auto
curvaPeligrosa auto = auto { desgasteRuedas = calculoDesgasteTramo (desgasteRuedas auto) longitudPeligrosa anguloPeligroso, tiempoCarrera = tiempoCarrera auto + sumaTiempo longitudPeligrosa (velocidadMáxima auto)}

curvaTranca :: Auto -> Auto
curvaTranca auto = auto { desgasteRuedas = calculoDesgasteTramo (desgasteRuedas auto) longitudTranca anguloTranca, tiempoCarrera = tiempoCarrera auto + sumaTiempo longitudTranca (velocidadMáxima auto)} 

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
casiCurva auto = auto { desgasteChasis = 5, desgasteRuedas = desgasteRuedasTramoZigZag auto cambiosDirecciónCasiCurva, tiempoCarrera = tiempoCarrera auto + tiempoDeCambios cambiosDirecciónCasiCurva}

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