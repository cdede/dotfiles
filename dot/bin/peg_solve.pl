#!/usr/bin/perl

use 5.10.0;
use encoding 'utf-8';

$line=$ARGV[0];
@array = split(/[:]/,$line);
@array1 = split(/x/,$array[0]);
my $N = $array1[0]+1;    # length of a board row (+1 for \n)
my $N2 = $array1[0];   
my $N1 = $array1[1];  

# The board must be surrounded by 2 illegal fields
# in each direction so that move() doesn't need to
# check the board boundaries. Periods represent
# illegal fields, P are pegs, and H are holes.
my @board =unpack( "a$N2 "x$N1, $array[1]);

$a1=join("\n",@board)."\n";

my @board = unpack(
    'C*',$a1);
# center is the position of the center hole if
# there is a single one; otherwise it is -1.
my $center;

{
    my $n = 0;
    for (my $i = 0 ; $i <= $#board ; ++$i) {
        if (chr $board[$i] eq 'H') {
            $center = $i;
            $n++;
            last;
        }
    }

    if ($n != 1) {
        $center = -1;    # no single hole
    }
}

$center=-1;
my $moves;               # number of times move is called

# move tests if there is a peg at position pos that
# can jump over another peg in direction dir. If the
# move is valid, it is executed and move returns true.
# Otherwise, move returns false.
sub move {
    my ($pos, $dir) = @_;
    ++$moves;
    if (chr $board[$pos] eq 'P' and chr $board[$pos + $dir] eq 'P' and chr $board[$pos + 2 * $dir] eq 'H') {
        $board[$pos]            = ord 'H';
        $board[$pos + $dir]     = ord 'H';
        $board[$pos + 2 * $dir] = ord 'P';
        return 1;
    }
    return 0;
}

# unmove reverts a previously executed valid move.
sub unmove {
    my ($pos, $dir) = @_;
    $board[$pos]            = ord 'P';
    $board[$pos + $dir]     = ord 'P';
    $board[$pos + 2 * $dir] = ord 'H';
    return 1;
}

# solve tries to find a sequence of moves such that
# there is only one peg left at the end; if center is
# >= 0, that last peg must be in the center position.
# If a solution is found, solve prints the board after
# each move in a backward fashion (i.e., the last
# board position is printed first, all the way back to
# the starting board position).
sub solve {
    my ($last, $n);

    foreach my $pos (0 .. $#board) {

        # try each board position
        if (chr $board[$pos] eq 'P') {

            # found a peg
            foreach my $dir (-1, -$N, +1, +$N) {

                # try each direction
                if (move($pos, $dir)) {

                    # a valid move was found and executed,
                    # see if this new board has a solution
                    if (solve()) {
                        unmove($pos, $dir);
                        say map { chr } @board;
                        return 1;
                    }
                    unmove($pos, $dir);
                }
            }
            $last = $pos;
            $n++;
        }
    }

    # tried each possible move
    if ($n == 1 && ($center < 0 || $last == $center)) {

        # there's only one peg left
        say map { chr } @board;
        return 1;
    }

    # no solution found for this board
    return 0;
}

if (!solve()) {
    say "no solution found";
}

say "$moves moves tried";
