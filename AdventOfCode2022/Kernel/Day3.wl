BeginPackage["FaizonZaman`AdventOfCode2022`Day3`"]

Begin["`Private`"]
Needs["PacletTools`"]
source = Import[FileNameJoin[{DirectoryName[$InputFileName, 2], "PuzzleInupts", "input-day3-part1.txt"}]]

day3PuzzleInput = StringSplit[source,"\n"]

priorities = Thread[CharacterRange["a","z"]->Range[26]] ~Join~ Thread[CharacterRange["A","Z"]->Range[26]+26];

compartments = Map[StringPartition[#, StringLength[#]/2]&, day3PuzzleInput];

dupetype = Intersection @@@ Characters[compartments];

Day3Part1Solution[] := (ReplaceAll[priorities] /* Flatten /* Total)[dupetype]

elfgroups = Partition[day3PuzzleInput, 3];
grouptype = Intersection @@@ Characters[elfgroups];

Day3Part2Solution[] := (ReplaceAll[priorities] /* Flatten /* Total)[grouptype]

FaizonZaman`AdventOfCode2022`$Day3Solution := Dataset[
    {
        <|"Part" -> "Part1", "Solution" -> Day3Part1Solution[]|>,
        <|"Part" -> "Part2", "Solution" -> Day3Part2Solution[]|>
    }
]


End[]

EndPackage[]