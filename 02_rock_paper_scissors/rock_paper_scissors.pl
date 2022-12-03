use strict;
use warnings;

####################################################################
sub rock_paper_scissors_solver 
{
    my $part = shift;
    return -1 unless ($part == 1 || $part == 2);

    my $score = 0;

    my $filename = "input.txt";
    open(my $info, '<', $filename) || DIE("Cant open $!");

    while (my $line = <$info>)
    {
        if ($line =~ /([A-Z])\s([A-Z])/)
        {
            my $firstLetter = $1;
            my $secondLetter = $2;

            my $thisMatch += ($part == 1) ? part_1($firstLetter, $secondLetter) :
                ($part == 2) ? part_2($firstLetter, $secondLetter) :
                -1; # wrong function call, should not happen!

            $score += $thisMatch;
        }
    }
    close($info) || DIE("Couldnt close $!");

    if ($score < 0)
    {
        print "unexpected result";
    }

    return $score;
}

####################################################################
sub part_2
{
    my ($opPlay, $roundEnd) = (@_);

    my $myPlay = "";

    # need to lose
    if ($roundEnd eq "X")
    {
        $myPlay = ($opPlay eq "A") ? "Z" : ($opPlay eq "B") ? "X" : "Y";
    }
    # need to draw
    elsif ($roundEnd eq "Y")
    {
        $myPlay = ($opPlay eq "A") ? "X" : ($opPlay eq "B") ? "Y" : "Z";
    }
    # need to win
    elsif ($roundEnd eq "Z")
    {
        $myPlay = ($opPlay eq "A") ? "Y" : ($opPlay eq "B") ? "Z" : "X";
    }

    return part_1($opPlay, $myPlay);
}
####################################################################
sub part_1
{
    my ($opPlay, $myPlay) = (@_);

    my $score = 0;

    # convert to same convetion X,Y,Z eq ROCK,PAPER,SCISSORS
    $myPlay = ($myPlay eq "X") ? "A" : ($myPlay eq "Y") ? "B" : "C";

    if ($myPlay eq "A")
    {
        $score += 1;
    }
    elsif ($myPlay eq "B")
    {
        $score += 2;
    }
    elsif ($myPlay eq "C")
    {
        $score += 3;
    }

    # score when compared to rival
    # 1) draw
    if ($myPlay eq $opPlay)
    {
        $score += 3;
    }
    # 2) win
    # rock beats scissors || scissors beats paper || paper beats rock
    elsif (
        (($myPlay eq "A") && ($opPlay eq "C")) ||
        (($myPlay eq "C") && ($opPlay eq "B")) ||
        (($myPlay eq "B") && ($opPlay eq "A")) )
    {
        $score += 6;
    }

    return $score;
}

printf "RESULT P1=%u\n", rock_paper_scissors_solver(1);
printf "RESULT P2=%u\n", rock_paper_scissors_solver(2);

__END__