#include <stdio.h>
#include <stdlib.h>

//#define VERBOSE

int part1(char *fileName)
{
    int cntFullyContained = 0;

    FILE* fp = fopen(fileName, "r");

    int start1, start2, end1, end2;
    while (fscanf(fp, "%d-%d,%d-%d\n", &start1, &end1, &start2, &end2) == 4)
    {
#if defined(VERBOSE)
        printf("%d-%d,%d-%d\n", start1, end1, start2, end2);
#endif
        // case 1: second contained in first
        // case 2: first contained in second
        if (((start2 >= start1) && (end2 <= end1)) ||
                ((start1 >= start2) && (end1 <= end2)))
        {
            cntFullyContained++;
        }
    }

    fclose(fp);

    return cntFullyContained;
}

int part2(char *fileName)
{
    int cntPartlyContained = 0;

    FILE* fp = fopen(fileName, "r");

    int start1, start2, end1, end2;
    while (fscanf(fp, "%d-%d,%d-%d\n", &start1, &end1, &start2, &end2) == 4)
    {
#if defined(VERBOSE)
        printf("%d-%d,%d-%d\n", start1, end1, start2, end2);
#endif
        // check if within limits
        //
        // note that we check if slice 2 is contained in slice 1
        // and then if slice 1 is in slice 2 (even if partially, these are two different cases)
        if ( (((start2 >= start1) && (start2 <= end1)) || ((end2 >= start1) && (end2 <= end1))) ||
                (((start1 >= start2) && (start1 <= end2)) || ((end1 >= start2) && (end1 <= end2))) )
        {
            cntPartlyContained++;
        }
    }

    fclose(fp);

    return cntPartlyContained;
}

int main()
{
    char* fileName = "input.txt";
    int cntContained = -1;

    cntContained = part1(fileName);
    printf("PART1=%u\n", cntContained);

    cntContained = part2(fileName);
    printf("PART2=%u\n", cntContained);
}
