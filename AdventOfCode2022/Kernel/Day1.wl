BeginPackage["FaizonZaman`AdventOfCode2022`Day1`"]

Begin["`Private`"]
Needs["PacletTools`"]
source = Import[
    PacletExtensionFiles[PacletObject["FaizonZaman/AdventOfCode2022"], "Resource"] // Values/*Flatten/*Select[FileBaseName/*StringContainsQ["day1-part1"]]/*First]

day1PuzzleInput = StringSplit[source,"\n\n"] // Map[(StringSplit[#,"\n"]&)/*ToExpression/*Total]

Day1Part1Solution[] := TakeLargest[day1PuzzleInput->{"Element","Index"}, 1] // First // AssociationThread[{"TotalCalories","Elves"} -> #]&

Day1Part2Solution[] := TakeLargest[day1PuzzleInput->{"Element","Index"}, 3] // Transpose // MapAt[Total, #, 1]& // AssociationThread[{"TotalCalories","Elves"} -> #]&

FaizonZaman`AdventOfCode2022`$Day1Solution := Dataset[
    {
        <|"Part" -> "Part1", "Solution" -> Day1Part1Solution[] |>,
        <|"Part" -> "Part2", "Solution" -> Day1Part2Solution[] |>
    }
]

End[]

EndPackage[]