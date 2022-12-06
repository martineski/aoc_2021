import std/strutils
import std/algorithm


proc part1(): int =

    var score: int

    for line in lines("input.txt"):

        let opPlayStr = line.substr(0,1)
        let myPlayStr = line.substr(2,3)

        # for simplicity when comparing, convert opPlayStr to X,Y,Z
        # (same format as myPlayStr)
        #var opPlayStrConverted: string

        let opPlayAscii = int(char(opPlayStr[0])) # convert string to ASCII decimal
        let opPlayStrConv = $char(opPlayAscii + 23) # and back ASCII decimal to string

        #if (opPlayStr == "A"):
        #    opPlayStrConverted = "X"
        #elif (opPlayStr == "B"):
        #    opPlayStrConverted = "Y"
        #elif (opPlayStr == "C"):
        #    opPlayStrConverted = "Z"

        echo "myPlayStr=", myPlayStr, " opPlayStr=", opPlayStrConv

        # initial score just because of play done
        if (myPlayStr == "X"): # rock
            score += 1
        elif (myPlayStr == "Y"): # paper
            score += 2
        elif (myPlayStr == "Z"): # scissors
            score += 3

        # score when compared to rival
        # 1) draw
        if (myPlayStr == opPlayStrConv):
            score += 3
        else:
            # rock beats scissors || scissors beats paper || paper beats rock
            if (myPlayStr == "X" and opPlayStrConv == "Z") or (myPlayStr == "Z" and opPlayStrConv == "Y") or (myPlayStr == "Y" and opPlayStrConv == "X"):
                score += 6

# ====================================================== #

let res1 = part1()
echo "--- part 1: score=", res1


#import std/re
#
#var ss = "A c C Q"
#
#let myRe = re("^(X|Y|Z) (A|B|C)")
#
#var matches: array[2, string]
#echo ss.find(myRe, matches)