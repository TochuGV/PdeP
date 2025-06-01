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

  -- a. Tests para agregar autos a un equipo
    it "Un ferrari con costo 65000 es agregado a un equipo con un presupuesto de 70000" $ do
      agregarAuto ferrariEq holaMundoTeam `shouldBe` UnEquipo {nombre = "HolaMundo", presupuesto = 5000, autos = [ferrariEq]}
    it "Un fiat con costo 44000 es agregado a un equipo con un presupuesto de 50000 reduciendolo a 6000" $ do
      agregarAuto fiatEq equipo4 `shouldBe` UnEquipo {nombre = "Equipo4", presupuesto = 6000, autos = [peugeotEq, fiatEq] }
 
  -- b. Tests para realizar una reparacion en equipo 
    it "Un equipo con un ferrari y un lamborghini de chasis 10 y 20 respectivamente y un presupuesto de 20000 repara los coches quedando con 1.5 de chasis el ferrari, 3 de chasis el lamborghini y un presupuesto de 7250" $ do  
      repararChasis equipo1 `shouldBe` UnEquipo {nombre = "Equipo1", presupuesto = 7250, autos = [UnAuto { marca = Ferrari, modelo = F50, desgasteChasis = 1.5, desgasteRuedas = 0, velocidadMáxima = 65, tiempoCarrera = 0, apodos = []}, UnAuto { marca = Lamborghini, modelo = Diablo, desgasteChasis = 3, desgasteRuedas = 0, velocidadMáxima = 73, tiempoCarrera = 0, apodos = []}]}
    it "Un equipo con un fiat de chasis 50 y un presupuesto de 10000 quiere reparar el coche pero no alcanza el presupuesto quedando en condiciones iniciales" $ do  
      repararChasis equipo2 `shouldBe` equipo2

