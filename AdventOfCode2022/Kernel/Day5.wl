BeginPackage["FaizonZaman`AdventOfCode2022`Day5`"]

Begin["`Private`"]
Needs["PacletTools`"]
source = Import[FileNameJoin[{DirectoryName[$InputFileName, 2], "PuzzleInputs", "input-day5-part1.txt"}]]

(* Split puzzle input into initial state and move instructions *)
{state, instructions} = StringSplit[source, "\n\n"];

instructions //= StringSplit[#, "\n"] &;

(* Split state into rows *)

(* Split state into rows *)
rows = StringSplit[state, "\n"] // Most;
(* Fill data with empty cells *)
complete = rows // Map[StringReplace[" " -> "."]/*StringReplace["...." -> ".[ ]"]];

(* Collect each stack *)
columns = (complete // StringSplit[#, "."] & // ReplaceAll[{"[ ]" -> Missing[]}] // Transpose);
(* Store state in an Association *)
stateAssoc = AssociationThread[Range[9] -> columns];

stateAssoc //= Map[DeleteMissing]
(* ^^ Delete missings (since they're just the top of the stack) *)

(* Split instructions into seperate strings *)
moves = StringSplit[instructions, "\n"];

ClearAll[move, parseMove]
(* Parse `move` string *)
parseMove[mv_String] := StringSplit[
    mv,
    "move " ~~ take : DigitCharacter .. ~~ " from " ~~ source : DigitCharacter .. ~~ " to " ~~ destination : DigitCharacter .. :> 
    <|
        "Take" -> ToExpression[take],
        "Source" -> ToExpression[source],
        "Destination" -> ToExpression[destination]
        |>
        ] // First
Option[move] = {
    "Move" -> Reverse
}
move[stacks_Association][mv_String] := move[stacks, mv]
move[stacks_Association, move_String, OptionsPattern[{move}]] := Block[
    {
        mv = parseMove[move],
        state = stacks,
        si, di,
        srcCol, desCol,
        moving, staying,
        func = OptionValue["Move"]
    },
    si = mv["Source"];
    di = mv["Destination"];
    srcCol = state[si];
    desCol = state[di];
    {moving, staying} = TakeDrop[srcCol, mv["Take"]];
    AssociateTo[state, si -> staying];
    AssociateTo[state, di -> Flatten[{func[moving], desCol}]];
    state
  ]

crane[f: Reverse|Identity] := Fold[
    move[#1, #2, "Move" -> f]&, stateAssoc, instructions
    ] // Map[First] // Values // StringJoin // StringDelete["[" | "]"];

Day5Part1Solution[] := crane[Reverse];


Day5Part2Solution[] := crane[Identity];


FaizonZaman`AdventOfCode2022`$Day5Solution := Dataset[
    {
        <|"Part" -> "Part1", "Solution" -> Day5Part1Solution[]|>,
        <|"Part" -> "Part2", "Solution" -> Day5Part2Solution[]|>
    }
]


End[]

EndPackage[]