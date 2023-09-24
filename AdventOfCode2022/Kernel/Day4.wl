BeginPackage["FaizonZaman`AdventOfCode2022`Day4`"]

Begin["`Private`"]
Needs["PacletTools`"]
source = Import[
    PacletExtensionFiles[PacletObject["FaizonZaman/AdventOfCode2022"], "Resource"] // Values/*Flatten/*Select[FileBaseName/*StringContainsQ["day4-part1"]]/*First]

day4PuzzleInput = StringSplit[source,"\n"]

stringpairs = StringSplit[day4PuzzleInput, ","];
intervalpairs = stringpairs // Map[Interval@*Function[ToExpression@StringSplit[#, "-"]], #, {2}] &

Day4Part1Solution[] := Select[ intervalpairs,
  AnyTrue[
    Through[{Identity, Reverse}[#]],
    Apply[IntervalMemberQ]
    ]&
  ] // Length;


Day4Part2Solution[] := intervalpairs // MapApply[IntervalIntersection] // DeleteCases[Interval[]] // Length;


FaizonZaman`AdventOfCode2022`$Day4Solution := Dataset[
    {
        <|"Part" -> "Part1", "Solution" -> Day4Part1Solution[]|>,
        <|"Part" -> "Part2", "Solution" -> Day4Part2Solution[]|>
    }
]


End[]

EndPackage[]