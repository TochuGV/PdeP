module Spec where
import PdePreludat
import Library
import Test.Hspec

correrTests :: IO ()
correrTests = hspec $ do
  describe "Tests - Entrega 1" $ do

  ---------------------------------------- ENTREGA 1 ----------------------------------------

    -- 2. Estado de salud del auto

    -- a. Tests de buenEstado
    it "Un auto marca Peugeot, nunca está en buen estado" $ do
      buenEstado peugeot `shouldBe` False
    it "Un auto marca Lamborghini, con tiempo en pista de 99 segundos y desgaste de chasis 7, está en buen estado" $ do
      buenEstado lamborghini { tiempoCarrera = 99, desgasteChasis = 7 } `shouldBe` True
    it "Un auto marca Fiat, con tiempo en pista de 99 segundos y desgaste de chasis 33, no está en buen estado" $ do
      buenEstado fiat { tiempoCarrera = 99, desgasteChasis = 33 } `shouldBe` False
    it "Un auto marca Ferrari que tiene 130 segundos de tiempo en pista con desgaste de ruedas 50 y chasis 30, está en buen estado" $ do
      buenEstado ferrari { tiempoCarrera = 130, desgasteRuedas = 50, desgasteChasis = 30 } `shouldBe` True
    it "Un auto marca Ferrari que tiene 15 segundos de tiempo en pista con desgaste de ruedas 50 y chasis 45, no está en buen estado" $ do
      buenEstado ferrari { tiempoCarrera = 15, desgasteRuedas = 50, desgasteChasis = 45 } `shouldBe` False
    it "Un auto marca Ferrari que tiene 150 segundos de tiempo en pista con desgaste de ruedas 70 y chasis 30, no está en buen estado" $ do
      buenEstado ferrari { tiempoCarrera = 150, desgasteRuedas = 70, desgasteChasis = 30 } `shouldBe` False

    -- b. Tests de noDaMas
    it "Un auto de marca Ferrari con desgaste de ruedas 20 y chasis 90, no da más" $ do
      noDaMas ferrari { desgasteRuedas = 20, desgasteChasis = 90 } `shouldBe` True
    it "Un auto de marca Ferrari con desgaste de chasis 20, da para más" $ do 
      noDaMas ferrari { desgasteChasis = 20 } `shouldBe` False
    it "Un auto de marca Lamborghini con desgaste de ruedas 90 y desgaste de chasis 20, no da más" $ do
      noDaMas lamborghini { desgasteRuedas = 90, desgasteChasis = 20 } `shouldBe` True
    it "Un auto de marca Lamborghini, da para más" $ do
      noDaMas lamborghini `shouldBe` False

  -- c. Tests de esChiche
    it "Un auto de marca Lamborghini, es un chiche" $ do
      esChiche lamborghini `shouldBe` True
    it "Un auto de marca Lamborghini con desgaste de ruedas 90 y chasis 20, no es un chiche" $ do
      esChiche lamborghini { desgasteRuedas = 90, desgasteChasis = 20 } `shouldBe` False
    it "Un auto de marca Ferrari con desgaste de ruedas 20 y chasis 90, no es un chiche" $ do
      esChiche ferrari { desgasteRuedas = 20, desgasteChasis = 90 } `shouldBe` False
    it "Un auto de marca Ferrari, es un chiche" $ do
      esChiche ferrari `shouldBe` True
  
  -- d. Tests de esJoya
    it "Un auto de marca Peugeot, es una joya" $ do
      esJoya peugeot `shouldBe` True
    it "Un auto de marca Ferrari, no es una joya" $ do
      esJoya ferrari `shouldBe` False

  -- e. Tests de nivelDeChetez
    it "Un auto de marca Ferrari, su nivel de chetez es 180" $ do
      nivelDeChetez ferrari `shouldBe` 180

  -- f. Tests de capacidadSupercalifragilisticaespialidosa
    it "Un auto de marca Ferrari, su capacidad supercalifragilisticaespialidosa es 7" $ do
      capacidadSupercalifragilisticaespialidosa ferrari `shouldBe` 7
  
  -- g. Tests de nivelDeRiesgo
    it "Un auto de marca Lamborghini, su nivel de riesgo es 29.2" $ do
      nivelDeRiesgo lamborghini `shouldBe` 29.2
    it "Un auto de marca Fiat, su nivel de riesgo es 237.6" $ do
      nivelDeRiesgo fiat `shouldBe` 237.6

  -- 3. Manos a la obra

  -- a. Tests de repararUnAuto
    it "Reparar un auto marca Fiat debe dejar un desgaste de ruedas en 0 y de chasis en 4.95" $ do
      repararAuto fiat `shouldBe` fiat { desgasteRuedas = 0, desgasteChasis = 4.95 }
    it "Reparar un auto marca Ferrari debe mantener sus desgastes de ruedas y chasis en 0" $ do
      repararAuto ferrari `shouldBe` ferrari { desgasteRuedas = 0, desgasteChasis = 0 }

  -- b. Tests de aplicarPenalidad
    it "Aplicar penalidad de 20 segundos un auto de marca Ferrari con tiempo 10 segundos en pista, tiene 30 segundos de tiempo en pista" $ do
      aplicarPenalidad ferrari { tiempoCarrera = 10 } 20 `shouldBe` ferrari { tiempoCarrera = 30 }
    it "Aplicar penalidad de 0 segundos a un auto de marca Ferrari con tiempo 10 segundos en pista, tiene 10 segundos en pista" $ do
      aplicarPenalidad ferrari { tiempoCarrera = 10 } 0 `shouldBe` ferrari { tiempoCarrera = 10 }

  -- c. Tests de ponerNitro
    it "Ponerle nitro a un Fiat, tiene una velocidad máxima de 52.8 m/s" $ do
      ponerNitro fiat `shouldBe` fiat { velocidadMáxima = 52.8}
    it "Ponerle nitro a un Fiat con velocidad máxima 0 m/s, mantiene su velocidad máxima" $ do
      ponerNitro fiat { velocidadMáxima = 0 } `shouldBe` fiat { velocidadMáxima = 0 }

  -- d. Tests de bautizarAuto
    it "Bautizar 'El diablo' a un auto marca Lamborghini, debe contener en sus apodos 'El diablo'" $ do
      "El diablo" `elem` apodos (bautizarAuto lamborghini "El diablo") `shouldBe` True
    it "Bautizar 'El diablo' a un auto marca Lamborghini sin apodos, sólo tiene el apodo 'El diablo'" $ do
      bautizarAuto lamborghini { apodos = [] } "El diablo" `shouldBe` lamborghini { apodos = ["El diablo"] }

  -- e. Tests desarmadero
    it "Llevar a un desarmadero a un auto marca Fiat para cambiar por marca 'Tesla' modelo 'X', la marca es 'Tesla', el modelo es 'X' y sólo tiene el apodo 'Nunca Taxi'" $ do
      desarmadero fiat Tesla X `shouldBe` fiat { marca = Tesla, modelo = X, apodos = ["Nunca taxi"] }

  -- 4. ¡Pistas!

  -- a. Tests de curvaPeligrosa y curvaTranca
    it "Transitar una curva peligrosa con un auto marca Ferrari, deja el desgaste de ruedas en 15 y mantiene el desgaste de chasis en 0" $ do
      curvaPeligrosa ferrari `shouldBe` ferrari { desgasteRuedas = 15, desgasteChasis = 0, tiempoCarrera = tiempoCarrera ferrari + sumaTiempo longitudPeligrosa (velocidadMáxima ferrari) }
    it "Transitar una curva peligrosa con un auto marca Peugeot, el tiempo en pista es de 15" $ do
      curvaPeligrosa peugeot `shouldBe` peugeot { desgasteRuedas = calculoDesgasteTramo (desgasteRuedas peugeot) longitudPeligrosa anguloPeligroso, tiempoCarrera = 15 }
    it "Transitar una curva tranca con un auto marca Ferrari, deja el desgaste de ruedas en 15 y mantiene el desgaste de chasis en 0" $ do
      curvaTranca ferrari `shouldBe` ferrari { desgasteRuedas = 15, desgasteChasis = 0, tiempoCarrera = tiempoCarrera ferrari + sumaTiempo longitudTranca (velocidadMáxima ferrari) }
    it "Transitar una curva tranca con un auto marca Peugeot, el tiempo en pista es de 27.5" $ do
      curvaTranca peugeot `shouldBe` peugeot { desgasteRuedas = calculoDesgasteTramo (desgasteRuedas peugeot) longitudTranca anguloTranca, tiempoCarrera = 27.5 }

  -- b. Tests de tramoRectoClassic y tramito
    it "Transitar un tramo recto classic con un auto marca Ferrari, tiene un desgaste de chasis de 7.15 y el tiempo en pista es de 11" $ do
      tramoRectoClassic ferrari `shouldBe` ferrari { desgasteChasis = 7.15, tiempoCarrera = 11 }
    it "Transitar un tramito con un auto marca Ferrari, tiene un desgaste de chasis de 2.6 y el tiempo en pista es de 4" $ do
      tramito ferrari `shouldBe` ferrari { desgasteChasis = 2.6, tiempoCarrera = 4 }

  -- c. Tests de zigZagLoco y casiCurva
    it "Transitar un tramo zigZagLoco con un auto marca Ferrari, tiene un desgaste de chasis de 5, tiene un desgaste de ruedas de 32.5 y el tiempo en pista es de 15" $ do
      zigZagLoco ferrari `shouldBe` ferrari { desgasteChasis = 5, desgasteRuedas = 32.5, tiempoCarrera = 15 }
    it "Transitar un tramo casiCurva con un auto marca Ferrari, tiene un desgaste de chasis de 5, tiene un desgaste de ruedas de 6.5 y el tiempo en pista es de 3" $ do
      casiCurva ferrari `shouldBe` ferrari { desgasteChasis = 5, desgasteRuedas = 6.5, tiempoCarrera = 3 }

  -- d. Tests de ruloClasico y deseoDeMuerte
    it "Transitar un tramo ruloClasico con un auto marca Ferrari, tiene un desgaste de chasis de 0, tiene un desgaste de ruedas de 19.5 y el tiempo en pista es de 1" $ do
      ruloClasico ferrari `shouldBe` ferrari { desgasteChasis = 0, desgasteRuedas = 19.5, tiempoCarrera  = 1 }
    it "Transitar un tramo deseoDeMuerte con un auto marca Ferrari, tiene un desgaste de chasis de 0, tiene un desgaste de ruedas de 39.0 y el tiempo en pista es de 2" $ do
      deseoDeMuerte ferrari `shouldBe` ferrari { desgasteChasis = 0, desgasteRuedas = 39.0, tiempoCarrera = 2 }

  -- 5. Nivel de Joyez

  -- a. Tests de nivelDeJoyez
    it "Un auto Ferrari, un auto Peugeot con un tiempo de carrera de 49 y un auto Peugeot con un tiempo de 50 deben tener un nivel de joyez de 3" $ do
      calcularNivelDeJoyez [ferrari, peugeot { tiempoCarrera = 49 }, peugeot { tiempoCarrera = 50 }] `shouldBe` 3

  -- b. Tests de paraEntendidos
    it "Un grupo de autos con un auto Ferrari cuyo tiempo de carrera es de 201 y otro igual pero con un tiempo de 200 no es para entendidos" $ do
      paraEntendidos [ferrari { tiempoCarrera = 201 }, ferrari {tiempoCarrera = 200 }] `shouldBe` False
    it "Un grupo de autos con un auto Ferrari cuyo tiempo de carrera es de 200 y un auto Peugeot no es para entendidos" $ do
      paraEntendidos [ferrari { tiempoCarrera = 200 }, peugeot] `shouldBe` False
    it "Un grupo de autos con un auto Ferrari cuyo tiempo de carrera es de 200 y otro Lamborghini con tiempo también de 200 es para entendidos" $ do
      paraEntendidos [ferrari { tiempoCarrera = 200 }, lamborghini {tiempoCarrera = 200 }] `shouldBe` True

  -- SEGUNDA ENTREGA

  -- 1. Equipos de competicion

  -- a. Tests de agregarAuto
    it "Un equipo con 70000 de presupuesto debe poder agregar una ferrari a sus autos" $ do
      agregarAuto holaMundoTeam ferrari  `shouldBe` holaMundoTeam {autos = [ferrari], presupuesto = 5000}
    it "Un equipo con 50000 de presupuesto que ya tiene un peugeot debe poder agregar un fiat, quedando con un presupuesto de 44000" $ do
      agregarAuto holaMundoTeam { autos = [peugeot], presupuesto = 50000 } fiat `shouldBe` holaMundoTeam { autos = [peugeot, fiat], presupuesto = 6000 }

  -- b. Tests de reparacion 
    it "Reparar un equipo con un Ferrari cuyo desgaste de chasis es 10, un Lamborghini cuyo desgaste de chasis 20 y un presupuesto de 20000 deberia resultar en un Ferrari con 1.5 de desgaste de chasis, un Lamborghini con 3 de desgaste de chasis y un presupuesto restante de 7250" $ do
      realizarAccionEnEquipo Reparar holaMundoTeam {autos = [ferrari { desgasteChasis = 10 }, lamborghini { desgasteChasis = 20 } ], presupuesto = 20000 } `shouldBe` holaMundoTeam { autos = [ferrari { desgasteChasis = 1.5 }, lamborghini { desgasteChasis = 3, desgasteRuedas = 0 }], presupuesto = 7250 }

    it "Reparar un equipo con un Fiat cuyo desgaste de chasis es 50 y un presupuesto de 10000 deberia resultar en un Fiat con el mismo desgaste y el mismo presupuesto" $ do
      realizarAccionEnEquipo Reparar holaMundoTeam {autos = [fiat {desgasteChasis = 50} ], presupuesto = 10000} `shouldBe` holaMundoTeam {autos = [fiat {desgasteChasis = 50}],  presupuesto = 10000}
  
  -- c. Tests de optimizacion
    it "Optimizar un equipo con un Ferrari, un Lamborghini y un presupuesto de 20000 debe resultar en un Ferrari con v.m. de 78, un Lamborghini con v.m. de 87.6 y un presupuesto de 6200" $ do
      realizarAccionEnEquipo Optimizar holaMundoTeam {autos = [ferrari,lamborghini ], presupuesto = 20000} `shouldBe` holaMundoTeam {autos = [ferrari {velocidadMáxima = 78},lamborghini {velocidadMáxima = 87.6}],  presupuesto = 6200}

    it "Optimizar un equipo con un Ferrari, un Lamborghini y un presupuesto de 10000 debe resultar en un Ferrari con v.m. de 78, un Lamborghini con v.m. de 87.6 y un presupuesto de 6200" $ do
      realizarAccionEnEquipo Optimizar holaMundoTeam {autos = [ferrari,lamborghini ], presupuesto = 10000} `shouldBe` holaMundoTeam {autos = [ferrari {velocidadMáxima = 78},lamborghini],  presupuesto = 3500}

  -- d. Tests de ferrarizacion
    it "Ferrarizar un equipo con un Peugeot, un Lamborghini y un presupuesto de 20000 da como resultado un equipo solo de Ferraris model F50 con unico apodo 'Nunca taxi' y presupuesto restante de 13000" $ do
      realizarAccionEnEquipo Ferrarizar holaMundoTeam {autos = [peugeot,lamborghini ], presupuesto = 20000} `shouldBe` holaMundoTeam {autos = [peugeot{marca = Ferrari, modelo = F50, apodos = ["Nunca taxi"]},lamborghini{marca = Ferrari, modelo = F50, apodos = ["Nunca taxi"]} ], presupuesto = 13000}

    it "Ferrarizar un equipo con un Peugeot, un Lamborghini y un presupuesto de 4000 da como resultado un equipo con un Ferrari modelo F50 con unico apodo 'Nunca taxi', el mismo Lamborghini y presupuesto restante de 500" $ do
      realizarAccionEnEquipo Ferrarizar holaMundoTeam {autos = [peugeot,lamborghini ], presupuesto = 4000} `shouldBe` holaMundoTeam {autos = [peugeot{marca = Ferrari, modelo = F50, apodos = ["Nunca taxi"]},lamborghini ], presupuesto = 500}

    it "Ferrarizar un equipo con un Peugeot, un Lamborghini, una Ferrari y un presupuesto de 20000 da como resultado un equipo con dos Ferraris modelo F50 con unico apodo 'Nunca taxi', una Ferrari modelo F50 con los apodos 'La nave', 'El fierro', 'Ferrucho y presupuesto restante de 13000" $ do
      realizarAccionEnEquipo Ferrarizar holaMundoTeam {autos = [peugeot,lamborghini, ferrari ], presupuesto = 20000} `shouldBe` holaMundoTeam {autos = [peugeot{marca = Ferrari, modelo = F50, apodos = ["Nunca taxi"]},lamborghini{marca = Ferrari, modelo = F50, apodos = ["Nunca taxi"]},ferrari{apodos =["La nave", "El fierro", "Ferrucho"]} ], presupuesto = 13000}

  -- 2. Costo total de reparacion

    it "El costo total de reparación de un equipo con Ferrari cuyo desgaste de chasis es 10 y Lamborghini cuyo desgaste de chasis es 20 sera de 12750" $ do
      calcularCostoReparacionTotal holaMundoTeam {autos = [ferrari{desgasteChasis = 10}, lamborghini{desgasteChasis = 20} ]} `shouldBe` 12750

    it "El costo total de reparación de un equipo con Fiat cuyo desgaste de chasis es 50 y Peugeot cuyo desgaste de chasis es 0 sera de 21250" $ do
      calcularCostoReparacionTotal holaMundoTeam {autos = [fiat{desgasteChasis = 50}, peugeot{desgasteChasis = 0} ]} `shouldBe` 21250

 -- 6 Pegar la vuelta
  {-   it "Pegar la vuelta a la manzana con una Ferrari y un Peugeot cuyo desgaste de ruedas es de 79, debe devolver a la Ferrari con un tiempo de carrera de 9,6 y al Peugeot con tiempo de carrera 11,7" $ do
      peganLaVuelta vueltaALaManzana [ferrari, peugeot{desgasteRuedas = 79}] `shouldBe` [ferrari { tiempoCarrera = 9.6, desgasteChasis = 5.2, desgasteRuedas = 1.7333333333333333}, peugeot { tiempoCarrera = 11.7,desgasteChasis = 3.9, desgasteRuedas = 80.3}]
 -}
-- 7.
    -- Test para verificar si el ordenamiento de posiciones finales es correcta
    it "Ordenar una lista compuesta por un Ferrari cuyo tiempo de carrera es 2, un Lamborghini cuyo tiempo de carrera es 1 y un Peugeot cuyo tiempo de carrera es 3 por su posicion final en la carrera debe resultar en Lamborghini, Ferrari y Peugeot " $ do
      definirPosicionesFinVuelta [ferrari { tiempoCarrera = 2 }, lamborghini { tiempoCarrera = 1 }, peugeot { tiempoCarrera = 3 }] `shouldBe` [lamborghini { tiempoCarrera = 1 }, ferrari { tiempoCarrera = 2 }, peugeot { tiempoCarrera = 3 }]
