use strict;
use warnings;
use List::Util qw(uniqstr);

our $GROUP_SIZE = 3;

####################################################################
sub rucksack_organization_2
{
    my $part = shift;
    return -1 unless ($part == 1 || $part == 2);

    my $filename = "input.txt";
    open(my $info, '<', $filename) || DIE("Cant open $!");

    my @lines = <$info>;
    my $sumPrios = 0;
    for (my $lineIx = 0; $lineIx < scalar(@lines); $lineIx += $GROUP_SIZE)
    {
        my @group = @lines[$lineIx..($lineIx + ($GROUP_SIZE-1))];
        # remove duplicities (for string 0 of the 3 available)
        my $stringsIx = 0;
        my @uniques0 = List::Util::uniqstr(split('', $group[$stringsIx++]));

        for (; $stringsIx < $GROUP_SIZE; $stringsIx++)
        {
            my @uniquesCompare = List::Util::uniqstr(split('', $group[$stringsIx]));

            # look for intersection between uniques0 and uniquesCompare
            my %tmpHash;
            @tmpHash{@uniquesCompare} = (1) x @uniquesCompare;
            @uniques0 = grep { $tmpHash{$_} } @uniques0;
        }

        # at this point there should only be a letter left in uniques0 (if at all)
        $sumPrios += _getPrio($uniques0[0]);
    }

    return $sumPrios;
}

####################################################################
sub rucksack_organization_1
{
    my $part = shift;
    return -1 unless ($part == 1 || $part == 2);

    my $filename = "input.txt";
    open(my $info, '<', $filename) || DIE("Cant open $!");

    my $sumPrios = 0;
    while (my $line = <$info>)
    {
        if ($line =~ /^([a-zA-Z]*)$/)
        {
            my $lineLen = length($line);
            my $comp1 = substr($line, 0, $lineLen/2);
            my $comp2 = substr($line, $lineLen/2);

            my $isMatch = _findMatchTwoStrs($comp1, $comp2);

            $sumPrios += _getPrio($isMatch) if ($isMatch ne "");
        }
    }
    close($info) || DIE("Couldnt close $!");

    return $sumPrios;
}

####################################################################
sub _getPrio
{
    my $isMatch = shift;
    return 0 if ($isMatch eq "");

    my $asciiVal = ord($isMatch); # converts from string to decimal ASCII
    my $priority = ($isMatch =~ /[a-z]/) ? ($asciiVal - 96) : ($asciiVal - 38);

    return $priority;
}

sub _findMatchTwoStrs
{
    my ($str1, $str2) = @_;

    my $isMatch;
    foreach my $c1 (split('', $str1, length($str1)))
    {
        foreach my $c2 (split('', $str2, length($str2)))
        {
            if ($c1 eq $c2)
            {
                $isMatch = $c1;
            }
        }
    }

    return (defined $isMatch) ? $isMatch : "";
}

####################################################################

printf "RESULT P1=%u\n", rucksack_organization_1(1);
printf "RESULT P2=%u\n", rucksack_organization_2(2);

__END__