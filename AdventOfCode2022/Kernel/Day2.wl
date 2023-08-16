BeginPackage["FaizonZaman`AdventOfCode2022`Day2`"]

Begin["`Private`"]
Needs["PacletTools`"]
source = Import[
    PacletExtensionFiles[PacletObject["FaizonZaman/AdventOfCode2022"], "Resource"] // Values/*Flatten/*Select[FileBaseName/*StringContainsQ["day2-part1"]]/*First]

day2PuzzleInput = StringSplit[source,"\n"] // Map[StringSplit]

(* Rock     [A,X] *)
(* Paper    [B,Y] *)
(* Scissors [C,Z] *)

(* Paper    > Rock *)
(* Rock     > Scissors *)
(* Scissors > Paper *)

(* Scissors > Paper    > Rock     *)
(* Rock     > Scissors > Paper    *)
(* Paper    > Rock     > Scissors *)


me["X"]=1; (* Rock *)
me["Y"]=2; (* Paper *)
me["Z"]=3; (* Scissors *)

ot["A"|"X"]=1; (* Rock *)
ot["B"|"Y"]=2; (* Paper *)
ot["C"|"Z"]=3; (* Scissors *)

(* Draw *)
cmp[x_,y_]:= With[
    {opponent=ot[x], player=ot[y]},
    Which[
        (* Draw *)
        opponent==player, 3,
        True,icmp[opponent,player]
        ]
    ]

icmp[2,1]=0; (* Paper > Rock *)
icmp[1,3]=0; (* Rock > Scissors *)
icmp[3,2]=0; (* Scissors > Paper *)

icmp[1,2]=6; (* Paper > Rock *)
icmp[3,1]=6; (* Rock > Scissors *)
icmp[2,3]=6; (* Scissors > Paper *)

play[opnt:("A"|"B"|"C"), you:("X"|"Y"|"Z")]:= me[you] + cmp[opnt, you]

Day2Part1Solution[] := Total[play@@@day2PuzzleInput]

(* 
    X means you need to lose, 
    Y means you need to end the round in a draw, and 
    Z means you need to win.
 *)

kasc = <|"Rock" -> 1, "Paper" -> 2, "Scissors" -> 3|>;
SetAttributes[play2, HoldAll]
(* draw *)
play2[<|_ -> x_, _ -> x_|>] := kasc[x] + 3
(* lose *)
play2[<|_ -> "Paper", _ -> p : "Rock"|>] := kasc[p] + 0
play2[<|_ -> "Rock", _ -> p : "Scissors"|>] := kasc[p] + 0
play2[<|_ -> "Scissors", _ -> p : "Paper"|>] := kasc[p] + 0
(* win *)
play2[<|_ -> "Rock", _ -> p : "Paper"|>] := kasc[p] + 6
play2[<|_ -> "Scissors", _ -> p : "Rock"|>] := kasc[p] + 6
play2[<|_ -> "Paper", _ -> p : "Scissors"|>] := kasc[p] + 6

krules = <|"A" -> "Rock", "B" -> "Paper", "C" -> "Scissors"|>;
loserules = <|"Rock" -> "Scissors", "Paper" -> "Rock", "Scissors" -> "Paper"|>;
winrules = <|"Scissors" -> "Rock", "Rock" -> "Paper", "Paper" -> "Scissors"|>;
drawrules = <|"Rock" -> "Rock", "Paper" -> "Paper", "Scissors" -> "Scissors"|>;
guide = <|"X" -> loserules, "Y" -> drawrules, "Z" -> winrules|>;

makeplay[o : ("A" | "B" | "C"), selector : ("X" | "Y" | "Z")] := 
    With[
        {op = krules[o]},
        With[
            {mop = guide[selector][op]},
            play2[<|"Player1" -> op, "Player2" -> mop|>]
        ]
    ]

Day2Part2Solution[] := Total[makeplay@@@day2PuzzleInput]

FaizonZaman`AdventOfCode2022`$Day2Solution := Dataset[
    {
        <|"Part" -> "Part1", "Solution" -> Day2Part1Solution[]|>,
        <|"Part" -> "Part2", "Solution" -> Day2Part2Solution[]|>
    }
]

End[]

EndPackage[]