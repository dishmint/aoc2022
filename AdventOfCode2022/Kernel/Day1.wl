BeginPackage["FaizonZaman`AdventOfCode2022`Day1`"]

Begin["`Private`"]
Needs["PacletTools`"]
d1p1Input = Import[PacletExtensionFiles[PacletObject["FaizonZaman/AdventOfCode2022"], "Resource"] // Values/*Flatten/*Select[FileBaseName/*StringContainsQ["day1-part1"]]/*First]

FaizonZaman`AdventOfCode2022`Day1Part1Solution[] := Block[
    {elfCalories = d1p1Input},
    StringSplit[elfCalories,"\n\n"] // Map[(StringSplit[#,"\n"]&)/*ToExpression/*Total] // TakeLargest[#->{"Element","Index"}, 1]&
    ]

FaizonZaman`AdventOfCode2022`Day1Part2Solution[] := Block[
    {elfCalories = d1p1Input},
    StringSplit[elfCalories,"\n\n"] // Map[(StringSplit[#,"\n"]&)/*ToExpression/*Total] // TakeLargest[#->{"Element","Index"}, 3]& // Transpose // MapAt[Total, #, 1]&
    ]

End[]

EndPackage[]