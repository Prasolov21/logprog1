﻿% Факты
город(москва).
город(санкт_петербург).
город(краснодар).
город(ростов_на_дону).
город(казань).

команда(01, спартак, москва).
команда(02, цск, москва).
команда(03, динамо, москва).
команда(04, зенит, санкт_петербург).
команда(05, кубань, краснодар).
команда(06, ростов, ростов_на_дону).
команда(07, рубин, казань).

футболист(01, илья_свинов, 01).
футболист(02, тимур_акмурзин, 01).
футболист(03, александр_селихов, 01).
футболист(01, скотников_всеволод, 02).
футболист(02, гамзин_дмитрий, 02).
футболист(03, диц_даррен, 02).
футболист(01, михаил_кержаков, 03).
футболист(02, даниил_одоевский, 03).
футболист(03, александр_васютин, 03).
футболист(01, артем_исмагилов, 04).
футболист(02, юрий_дюпин, 04).
футболист(03, александр_беленов, 04).
футболист(01, евдокимов_сергей, 05).
футболист(02, ещенко_юрий, 05).
футболист(03, нестеренко_азат, 05).
футболист(01, никита_медведев, 06).
футболист(02, евгений_чернов, 06).
футболист(03, алексей_миронов, 06).
футболист(01, артем_исмагилов, 07).
футболист(02, юрий_дюпин, 07).
футболист(03, александр_беленов, 07).

стадион(01, открытие_арена, москва_волоколамское_шоссе_69).
стадион(02, арена_цск, москва_3-я_песчаная_улица_2а).
стадион(03, арена_динамо, москва_ленинградский_пр-т_36).
стадион(04, газпром_арена, санкт_петербург_футбольная_аллея_1).
стадион(05, стадион_кубань, краснодар_железнодорожная_49).
стадион(06, ростов_арена, ростов_на_дону_левобережная_2б).
стадион(07, стадион_рубин, казань_копылова_2).

матч(1, '2023-05-07', 3, 1, москва, спартак, цск, 2).
матч(2, '2023-05-08', 2, 4, москва, динамо, спартак, 3).
матч(01, '2023-07-01', 2, 1, москва, спартак, зенит, 1).
матч(02, '2023-07-10', 0, 1, казань, динамо, кубань, 7).
матч(03, '2023-07-22', 3, 2, питер, цск, рубин, 4).
матч(04, '2023-07-22', 1, 0, ростов, ростов, динамо, 6).
матч(05, '2023-07-25', 2, 0, ростов, зенит, кубань, 6).
матч(06, '2023-07-10', 1, 1, москва, спартак, рубин, 1).
матч(07, '2023-07-01', 3, 2, питер, цск, ростов, 4).

чемпионат(1, 'Российская Премьер-лига', 'Россия').
турнирная_таблица(1, 1, 1, 1, 1, 0, 0, 2, 0).
турнирная_таблица(2, 1, 2, 1, 0, 0, 1, 0, 2).

% Правила
% по ведущему счету, определяет победителя в матче.
% случай победы первой команды
выиграла(Матч) :-
    матч(Матч, _, Счет1, Счет2, _, Команда1, Команда2, _),
    Счет1 > Счет2,
    write(Команда1), write(' выиграла матч против '), write(Команда2).
% случай победы второй команды
выиграла(Команда1, Команда2, Матч) :-
    матч(Матч, _, Счет1, Счет2, _, Команда1, Команда2, _),
    Счет1 < Счет2,
    write(Команда2), write(' выиграла матч против '), write(Команда1).

?-выиграла(1).

% Запросы
% Команды из одного города
команды_из_одного_города(Ком1, Ком2, Гор) :-
    город(Гор),
    команда(Команда1, _, Гор),
    команда(Команда2, _, Гор),
    Команда1 \= Команда2.

% Команды, выступающие на одном стадионе.
один_стадион(Команда1, Команда2) :-
    команда(Команда1, _, _),
    команда(Команда2, _, _),
    стадион(Стадион, _, _),
    матч(_, _, _, Команда1, Команда2, Стадион).