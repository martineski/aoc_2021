import std/strutils
import std/algorithm

proc part1(): int =
    var
        maxCal: int
        tmp: int

    for line in lines("input.txt"):
        if line != "":
            tmp += parseInt(line)
        else:
            maxCal = max(tmp, maxCal)
            tmp = 0

    return maxCal

proc part2(): int =
    var
        sCalSum: seq[int]
        tmp: int = 0
    
    for line in lines("input.txt"):
        if line != "":
            tmp += line.parseInt()
        else:
            sCalSum.add(tmp)
            tmp = 0
    
    # from language documentation:
    # - uses iterative mergesort, at O(n logn)
    # - sorted is done in an ascending order of elements
    sCalSum.sort()
    
    let ll = sCalSum.high()
    let calSumBig3 = sCalSum[ll] + sCalSum[ll-1] + sCalSum[ll-2]
    return calSumBig3

# ====================================================== #

let res1 = part1()
echo "--- part 1: max=", res1

let res2 = part2()
echo "--- part 2: sum=", res2