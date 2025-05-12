module Spec where
import PdePreludat
import Library
import Test.Hspec

correrTests :: IO ()
correrTests = hspec $ do
  describe "Test de ejemplo" $ do
    it "El pdepreludat se instaló correctamente" $ do
      doble 1 `shouldBe` 2
    it "Un auto marca Peugeot, nunca está en buen estado" $ do
      buenEstado auto4 `shouldBe` False
    it "Un auto marca Lamborghini, con tiempo en pista de 99 segundos y desgaste de chasis 7, está en buen estado" $ do
      buenEstado auto2 { tiempoCarrera = 99, desgasteChasis = 7 } `shouldBe` True

