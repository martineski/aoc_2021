import std/sequtils

proc part1(): int =
  let inputFile: string = readFile("input.txt")
  let windowSize: int = 4

  var
    ixStartPacketDone: int = 1
    arr: array[4, char]
    writeIx: int = 0

  for val in items(inputFile):

    writeIx = min(ixStartPacketDone mod windowSize, windowSize-1)
    arr[writeIx] = val

    let deArr = arr.deduplicate()
    if ((ixStartPacketDone >= windowSize) and (deArr.len() == 4)):
      echo "got a match at: ", ixStartPacketDone
      echo arr
      return ixStartPacketDone # we just need the first match

    ixStartPacketDone += 1

  # solution not found
  return -1

proc part2(): int =
  let inputFile: string = readFile("input.txt")
  let windowSize: int = 14

  var
    ixStartPacketDone: int = 1
    arr: array[14, char]
    writeIx: int = 0

  for val in items(inputFile):

    writeIx = min(ixStartPacketDone mod windowSize, windowSize-1)
    arr[writeIx] = val

    let deArr = arr.deduplicate()
    if ((ixStartPacketDone >= windowSize) and (deArr.len() == 14)):
      echo "got a match at: ", ixStartPacketDone
      echo arr
      return ixStartPacketDone # we just need the first match

    ixStartPacketDone += 1

  # solution not found
  return -1

# ==================================================== #

let res1 = part1()
echo "--- part1: max=", res1

let res2 = part2()
echo "--- part2: max=", res2