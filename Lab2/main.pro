implement main
    open core, stdio, file

class facts - football
    team : (integer TeamID, string TeamName, string City, integer Goals).
    stadium : (integer StadiumID, integer TeamID, string StadiumName, string Adress).
    player : (integer PlayerID, string PlayerName, integer TeamID).
    match : (integer MatchId, string Date, integer Score1, integer Score2, string City, string Team1, string Team2, integer StadiumId).

class facts
    winer : (symbol Winer) single.

clauses
    winer("name").

class predicates
    samecity : (string Team1, string Team2) nondeterm anyflow.
    whoswinner : (integer Score1, integer Score2, string Winer) nondeterm anyflow.
    winernames : (string Winer, string PlayerName) nondeterm anyflow.
    how_many_matches : (string Ateam, integer OldAmount, integer NewAmount) nondeterm anyflow.

clauses
    /*какие команды в одном городе*/
    samecity(Team1, Team2) :-
        team(_, Team1, City1, _),
        team(_, Team2, City2, _),
        City1 = City2,
        Team1 <> Team2.

    /*кто победитель,  счет*/
    whoswinner(Score1, Score2, Winer) :-
        match(_, _, Score1, Score2, _, Team1, Team2, _),
        if Score1 < Score2 then
            Winer = Team2,
            stdio::write("The team won ", Winer, " with the score ", Score2, ":", Score1, "\n")
        else
            Winer = Team1,
            stdio::write("The team won ", Winer, " with the score ", Score1, ":", Score2, "\n")
        end if.

/*имена игроков победившей команды*/
    winernames(Winer, PlayerName) :-
        team(TeamId, Winer, _, _),
        player(_, PlayerName, TeamId).

    /*кол-во голов, забитых в недавних матчах одной из команд*/
    how_many_matches(Ateam, OldAmount, NewAmount) :-
        team(_, Ateam, _, OldAmount),
        NewAmount = OldAmount + 7.

clauses
    run() :-
        console::init(),
        file::consult("../database.txt", football),
        fail.

    run() :-
        samecity(Ateam, Bteam),
        stdio::write(Ateam, " и ", Bteam, " из одного города \n"),
        fail.

    run() :-
        whoswinner(Score1, Score2, Winer),
        fail.

    run() :-
        winernames(Winer, PlayerName),
        stdio::write("Names of those who won on the team ", Winer, ":", PlayerName, "\n"),
        fail.

    run() :-
        how_many_matches(Ateam, OldAmount, NewAmount),
        stdio::write(" That's how many goals ", Ateam, " scored last year - ", OldAmount, ". This year they scored - ", NewAmount, "\n"),
        fail.

    run() :-
        stdio::write("End test\n").

end implement main

goal
    console::runUtf8(main::run).
