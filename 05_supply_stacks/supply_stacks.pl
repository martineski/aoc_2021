#!/usr/bin/perl
use strict;
use warnings;
use List::Util qw(min);

my $part = $ARGV[0] // '1';
print "DOING PART $part\n";

# read file line by line and store in array
my @lines = _getLinesFromFile();

# TODO: find way to parse inital state smartly (e.g. Transpose?)
#
# initial state of the stacks (let's call it 'hangar')
my $hangar =
{
    1 => "LNWTD",
    2 => "CPH",
    3 => "WPHNDGMJ",
    4 => "CWSNTQL",
    5 => "PHCN",
    6 => "THNDMWQB",
    7 => "MBRJGSL",
    8 => "ZNWGVBRT",
    9 => "WGDNPL",
};

my @moves = _getMoves(@lines);

####################################################################
# PART 1: process all moves
foreach my $mm (@moves)
{
    my $posToPop;
    my $posToPush;
    my $numMoves;
    foreach my $k (sort keys %$mm)
    {
        if ($k =~ m/fromMove/)
        {
            $posToPop = $mm->{$k};
        }
        elsif ($k =~ m/toMove/)
        {
            $posToPush = $mm->{$k};
        }
        elsif ($k =~ m/numMove/)
        {
            $numMoves = $mm->{$k};
        }
    }

    if ($part eq '1')
    {
        while ($numMoves--)
        {
            my $vv = _pop(\$hangar->{"$posToPop"});
            _push(\$hangar->{"$posToPush"}, $vv);
        }
    }
    else
    {
        # avoid going over max number of elements available at the given stack in the hangar
        $numMoves = List::Util::min($numMoves, length($hangar->{"$posToPop"}));
        my $chunk = substr($hangar->{"$posToPop"}, -$numMoves);

        # reduce the stack that is being "popped"
        $hangar->{"$posToPop"} = substr($hangar->{"$posToPop"}, 0, -$numMoves);
        # incrase the hangar that is being "pushed" with the chunk
        $hangar->{"$posToPush"} .= $chunk;
    }
}
# PART 1
_showTopCrates($hangar, "PART $part: ");

####################################################################
# HELPER FUNCTIONS
####################################################################
# get the input file, as an array (each containing a line)
sub _getLinesFromFile
{
    my $filename = $ARGV[1] // "input.txt";
    open(my $info, '<', $filename) || die("Cant open $!");
    my @lines = <$info>;
    return @lines;
}

# pop a crate (and return it) of the desired stack
sub _pop
{
    my $stckRef = shift // "";
    # if stack is empty, return nothing!
    return "" if ($stckRef eq "");

    my $lastChar = chop($$stckRef);;
    return $lastChar;
}

# push a crate to the desired stack
sub _push
{
    my ($stckRef, $el) = @_;

    $$stckRef .= $el;
    return;
}

# get the number of stacks in the input file
sub _getNumOfStacks
{
    my @lines = @_;

    my $numOfStacks = -1;
    foreach my $line (@lines)
    {
        if ($line =~ m/([0-9]+)\s+/)
        {
            my @arr = split(' ', $line);
            $numOfStacks = $arr[-1];

        }
        # blank line
        if ($line =~ /^\s*$/)
        {
            last;
        }
    }

    return $numOfStacks;
}

# extract all the move sequences from the input file
sub _getMoves
{
    my @lines = @_;

    my $oneMove = { numMove => -1, fromMove => -1, toMove => -1};
    my @moves = ();
    foreach my $line (@lines)
    {
        # get the moves
        if ($line =~ m/^move (\d+) from (\d+) to (\d+)$/)
        {
            my $numMove = $1;
            my $fromMove = $2;
            my $toMove = $3;

            $oneMove = { numMove => $numMove, fromMove => $fromMove, toMove => $toMove };
            push (@moves, $oneMove);
        }
    }

    return @moves;
}

# show the top crate of each stack in order
# (as part to solution of part 1)
sub _showTopCrates
{
    my $hangar = shift;
    my $stringToShow = shift;

    print $stringToShow;
    foreach my $k (sort keys %$hangar)
    {
        printf("%s", substr($hangar->{$k}, -1));
    }
    printf("\n");
}

__END__