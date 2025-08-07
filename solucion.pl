coleccionista(andy, figurita(2), paquete(1)).
coleccionista(andy, figurita(4), paquete(1)).
coleccionista(andy, figurita(7), paquete(2)).
coleccionista(andy, figurita(6), paquete(2)).
coleccionista(andy, figurita(8), paquete(3)).
coleccionista(andy, figurita(1), paquete(3)).
coleccionista(andy, figurita(3), paquete(3)).
coleccionista(andy, figurita(5), paquete(3)).
coleccionista(andy, figurita(1), recibidaPor(flor)).
coleccionista(flor, figurita(5), paquete(1)).
coleccionista(flor, figurita(5), paquete(2)).
coleccionista(flor, figurita(2), recibidaPor(bobby)).
coleccionista(bobby, figurita(1), recibidaPor(flor)).
coleccionista(bobby, figurita(4), recibidaPor(flor)).
coleccionista(bobby, figurita(6), recibidaPor(flor)).
coleccionista(bobby, figurita(3), paquete(1)).
coleccionista(bobby, figurita(5), paquete(1)).
coleccionista(bobby, figurita(7), paquete(2)).
coleccionista(lala, figurita(3), paquete(1)).
coleccionista(lala, figurita(7), paquete(1)).
coleccionista(lala, figurita(1), paquete(1)).
coleccionista(lala, figurita(5), recibidaPor(pablito)).
coleccionista(pablito, figurita(1), recibidaPor(lala)).
coleccionista(pablito, figurita(2), recibidaPor(toto)).
coleccionista(toto, figurita(1), paquete(1)).
coleccionista(toto, figurita(6), recibidaPor(pablito)).
coleccionista(juanchi, figurita(), recibidaPor()).

% Punto 1

queFiguritasTiene(Persona, Figurita):- 
  coleccionista(Persona, figurita(Figurita), _).

% Punto 2

tieneRepetidas(Persona, Figurita):-
  coleccionista(Persona, figurita(Figurita), _),
  findall(Origen, coleccionista(Persona, figurita(Figurita), Origen), Lista),
  length(Lista, Cantidad),
  Cantidad > 1.

% Punto 3

noSalioEnPrimerosPaquetes(Figurita):- % caso a
  not((coleccionista(_, figurita(Figurita), paquete(N)), N =< 2)).

personasUnicas(PersonasUnicas):-
  findall(Persona, coleccionista(Persona, _, _), Personas),
  sort(Personas, PersonasUnicas).

personasConFigurita(Figurita, PersonasConFiguritaUnicas):-
  findall(Persona, coleccionista(Persona, figurita(Figurita), _), PersonasConFigurita),
  sort(PersonasConFigurita, PersonasConFiguritaUnicas).

esRara(Figurita):-
  noSalioEnPrimerosPaquetes(Figurita).
esRara(Figurita):-
  personasUnicas(ColeccionistasUnicos),
  length(ColeccionistasUnicos, TotalColeccionistas),
  personasConFigurita(Figurita, PersonasConFiguritaUnicas),
  length(PersonasConFiguritaUnicas, CantidadConFigurita),
  CantidadConFigurita < TotalColeccionistas / 2.

% Punto 4

popularidad(kitty, 5).
popularidad(cinnamoroll, 4).
popularidad(badtzMaru, 2).
popularidad(keroppi, 3).
popularidad(pompompurin, 4).
popularidad(myMelody, 3).
popularidad(gudetama, 1).
popularidad(littleTwinStars, 2).
popularidad(kuromi, 5).

figurita(1, rareza(basica), [kitty, keroppi]).
figurita(2, rareza(brillante), [kitty]).
figurita(3, rareza(brillante), [myMelody]).
figurita(4, rareza(basica), []).
figurita(5, parte(rompecabezas(restaurante))).
figurita(6, parte(rompecabezas(restaurante))).
figurita(7, parte(rompecabezas(restaurante))).
figurita(8, rareza(basica), [kitty, cinnamoroll, badtzMaru, keroppi, pompompurin, myMelody, gudetama, littleTwinStars, kuromi]).
%figurita(9, parte(rompecabezas(restaurante))).
%figurita(10, parte(rompecabezas(parque))).

% Punto 5

cantidadPartesRompecabezas(Cantidad, Rompecabezas):-
  findall(Figurita, figurita(Figurita, parte(rompecabezas(Rompecabezas))), Partes),
  length(Partes, Cantidad).

esValiosa(Figurita):- 
  figurita(Figurita, _, _),
  esRara(Figurita).
esValiosa(Figurita):-
  atractivo(Figurita, Atractivo),
  Atractivo > 7.

atractivo(Figurita, Atractivo):-
  figurita(Figurita, rareza(brillante), Personajes),
  findall(Popularidad, (member(Personaje, Personajes), popularidad(Personaje, Popularidad)), Popularidades),
  sumlist(Popularidades, Suma),
  Atractivo is 5 * Suma.
atractivo(Figurita, Atractivo):-
  figurita(Figurita, rareza(basica), Personajes),
  findall(Popularidad, (member(Personaje, Personajes), popularidad(Personaje, Popularidad)), Popularidades),
  sumlist(Popularidades, Atractivo).
atractivo(Figurita, 2):-
  figurita(Figurita, parte(rompecabezas(Rompecabezas))),
  cantidadPartesRompecabezas(Cantidad, Rompecabezas),
  Cantidad =< 2.
atractivo(Figurita, 0):-
  figurita(Figurita, parte(rompecabezas(Rompecabezas))),
  cantidadPartesRompecabezas(Cantidad, Rompecabezas),
  Cantidad > 2.

% Punto 6

imagenMasAtractiva(Persona, Figurita):-
  coleccionista(Persona, figurita(Figurita), _),
  figurita(Figurita, _, _),
  atractivo(Figurita, Atractivo),
  forall((coleccionista(Persona, figurita(OtraFigurita), _), OtraFigurita \= Figurita, atractivo(OtraFigurita, OtroAtractivo)), Atractivo >= OtroAtractivo).

% Punto 7

figuritasNuevas(Persona, Figuritas, FiguritasNuevas):-
  findall(Figurita, (member(Figurita, Figuritas), not(queFiguritasTiene(Persona, Figurita))), FiguritasNuevas).

hayAlgunaRara(Figuritas):-
  member(Figurita, Figuritas),
  esRara(Figurita).

atractivoTotal(Figuritas, AtractivoTotal):-
  findall(Atractivo, (member(Figurita, Figuritas), atractivo(Figurita, Atractivo)), Atractivos),
  sumlist(Atractivos, AtractivoTotal).

queTanInteresanteEs(Persona, Figuritas, Interes):-
  figuritasNuevas(Persona, Figuritas, FiguritasNuevas),
  hayAlgunaRara(FiguritasNuevas),
  atractivoTotal(FiguritasNuevas, Atractivo),
  Interes is Atractivo + 20.
queTanInteresanteEs(Persona, Figuritas, Interes):-
  figuritasNuevas(Persona, Figuritas, FiguritasNuevas),
  not(hayAlgunaRara(FiguritasNuevas)),
  atractivoTotal(FiguritasNuevas, Interes).

% Punto 8

tieneTodasLasFiguritas(Persona, Figuritas):-
  forall(member(Figurita, Figuritas), queFiguritasTiene(Persona, Figurita)).

canjeValido(Persona1, FiguritasRecibidas, Persona2, FiguritasEntregadas):-
  tieneTodasLasFiguritas(Persona1, FiguritasRecibidas),
  tieneTodasLasFiguritas(Persona2, FiguritasEntregadas).

validaPaquete(Figuritas):-
  forall(member(Figurita, Figuritas), figurita(Figurita, _, _)).

% Punto 9

hayAlgunaValiosa(Figuritas):-
  member(Figurita, Figuritas),
  esValiosa(Figurita).

haceNegocio(Beneficiado, FiguritasRecibidas, Perjudicado, FiguritasEntregadas):-
  canjeValido(Beneficiado, FiguritasRecibidas, Perjudicado, FiguritasEntregadas),    
  hayAlgunaValiosa(FiguritasRecibidas),
  not(hayAlgunaValiosa(FiguritasEntregadas)).

% Punto 10

noTieneFigurita(Persona, Figurita):- 
  coleccionista(Persona, _, _),
  figurita(Figurita, _, _),
  not(queFiguritasTiene(Persona, Figurita)).

noTieneFigurita(Persona, Figurita):- 
  coleccionista(Persona, _, _),
  figurita(Figurita, parte(_)),
  not(queFiguritasTiene(Persona, Figurita)).

tieneTodasLasDemas(Persona, Figurita):-
  figurita(Figurita, _),
  findall(OtraFigurita, (figurita(OtraFigurita, _, _), OtraFigurita \= Figurita), FiguritasDistintas),
  forall(member(FiguritaRestante, FiguritasDistintas), queFiguritasTiene(Persona, FiguritaRestante)).

tieneTodasLasDemas(Persona, Figurita):-
  figurita(Figurita, parte(rompecabezas(Rompecabezas))),
  formaParteDeRompecabezas(Figurita, Rompecabezas),
  findall(OtraFigurita, (formaParteDeRompecabezas(OtraFigurita, Rompecabezas), OtraFigurita \= Figurita), FiguritasRestantes),
  forall(member(FiguritaRestante, FiguritasRestantes), queFiguritasTiene(Persona, FiguritaRestante)).

formaParteDeRompecabezas(Figurita, Rompecabezas):- 
  figurita(Figurita, parte(rompecabezas(Rompecabezas))).

comparteRompecabezas(Persona, Figurita):-
  formaParteDeRompecabezas(Figurita, Rompecabezas),
  queFiguritasTiene(Persona, OtraFigurita),
  formaParteDeRompecabezas(OtraFigurita, Rompecabezas),
  Figurita \= OtraFigurita.

necesitaConUrgencia(Persona, Figurita):-
  figurita(Figurita, _, _),
  noTieneFigurita(Persona, Figurita),
  tieneTodasLasDemas(Persona, Figurita).

necesitaConUrgencia(Persona, Figurita):-
  figurita(Figurita, parte(rompecabezas(_))),
  noTieneFigurita(Persona, Figurita),
  comparteRompecabezas(Persona, Figurita).

% Punto 11

haceNegocioEnAlguno(Persona, Canjes):-
  member(canje(FiguritasEntregadas, OtraPersona, FiguritasRecibidas), Canjes),
  haceNegocio(Persona, FiguritasEntregadas, OtraPersona, FiguritasRecibidas).

saleGanandoEnTodos(Persona, Canjes):-
  forall(member(canje(FiguritasEntregadas, OtraPersona, FiguritasRecibidas), Canjes),
    (
    queTanInteresanteEs(Persona, FiguritasEntregadas, InteresEntregadas),
    queTanInteresanteEs(OtraPersona, FiguritasRecibidas, InteresRecibidas),
    InteresRecibidas > InteresEntregadas
    )
  ).

esAmenaza(Persona, Canjes):-
  haceNegocioEnAlguno(Persona, Canjes),
  saleGanandoEnTodos(Persona, Canjes).

% Punto 12

esClasico(Persona, Figuritas):-
  coleccionista(Persona, _, _),
  forall(member(Figurita, Figuritas), not(queFiguritasTiene(Persona, Figurita))).

esDescartador(Persona, Figuritas):-
  coleccionista(Persona, _, _),
  forall(member(Figurita, Figuritas), tieneRepetidas(Persona, Figurita)).

esCazafortunas(Persona, Figuritas):-
  coleccionista(Persona, _, _),
  member(Figurita, Figuritas),
  esValiosa(Figurita).

esUrgido(Persona, Figuritas):-
  coleccionista(Persona, _, _),
  member(Figurita, Figuritas),
  necesitaConUrgencia(Persona, Figurita).

tieneFiguritaRepetidaEn(Figuritas, Persona):-
  member(Figurita, Figuritas),
  tieneRepetidas(Persona, Figurita).

tieneEstiloParaCanje(Persona, FiguritasEntregadas, FiguritasRecibidas):-
  esClasico(Persona, FiguritasRecibidas).
tieneEstiloParaCanje(Persona, FiguritasEntregadas, FiguritasRecibidas):-
  esDescartador(Persona, FiguritasEntregadas).
tieneEstiloParaCanje(Persona, FiguritasEntregadas, FiguritasRecibidas):-
  esCazafortunas(Persona, FiguritasRecibidas).
tieneEstiloParaCanje(Persona, FiguritasEntregadas, FiguritasRecibidas):-
  esUrgido(Persona, FiguritasRecibidas).

canjePosible(Persona1, Persona2, FiguritasEntregadas, FiguritasRecibidas):-
  canjeValido(Persona1, FiguritasRecibidas, Persona2, FiguritasEntregadas),
  tieneFiguritaRepetidaEn(FiguritasEntregadas, Persona1),
  tieneEstiloParaCanje(Persona2, FiguritasEntregadas, FiguritasRecibidas).