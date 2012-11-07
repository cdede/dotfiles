#!/usr/bin/perl
use Getopt::Std;
use File::Temp qw/ tempfile  /;

sub easter_egg1(){
  use strict;
   use warnings;
    use Date::Calc qw(Delta_Days);

    my @today = (localtime)[5,4,3];
    $today[0] += 1900;
    $today[1]++;

    my @birthday = ($_[0], $_[1],$_[2]);

    my $days = Delta_Days(@birthday, @today);

    my ($fh, $filename) = tempfile();
    open FILE, ">$filename" 
      or die $!;
    my $head1  = <<EOF1;
set terminal png   background "#556B2F"
set output "%s"
start = %d
EOF1

$head1=sprintf $head1,$ENV{'HOME'}.'/sin.png',$days-3;

  print FILE $head1;
  

    print FILE <<'EOF';
m2=27.32166155
m1=m2*5.0/6.0
m3=m2*7.0/6.0
bio(day, cycle) =  sin((real(day-1+start)/cycle)*2*pi) * 100
set xlabel "Biorhythm Chart "
set grid
set xtics 1,1,7
set yrange [-100:100]
set xtics add ("now" 4)
t1=bio(4,m1)
set ytics add (gprintf("body: %g", t1) t1)
t2=bio(4,m2)
set ytics add (gprintf("feel: %g", t2) t2)
t3=bio(4,m3)
set ytics add (gprintf("mind: %g", t3) t3)

plot [x=1:7] \
  bio(x,m1) title 'body', \
  bio(x,m2) title 'feel', \
  bio(x,m3) title 'mind'

EOF

    close FILE;
    my $cmd=sprintf "gnuplot %s ",  $filename;
    system ("$cmd");

    exit 0;
  }

sub make_password(){
  use Digest::SHA1  qw(sha1_hex );
  my %ret=();
  $ret{'pass'}=`cat /dev/urandom | tr -cd 'A-Za-z0-9_#&%' | head -c $_[0]`;
  $ret{'hash'}=substr(sha1_hex($ret{'pass'}),0,7);
  %ret;
}
sub check(){ 
  if ($_[0] == 0)
  {
    print 'you win',"\n";
    1;
  }
  else
  {
    print 'you lose',"\n";
    0;
  }
}
sub easter_egg2(){

$test=$_[0];
$win=0;
do
{
$max_num=96;
if(test){
$n01=int(`echo "0\n1" |shuf  --random-source=/dev/urandom -n 1`);
}else{
$n01=int(`echo "0\n1" |shuf  --random-source=/dev/random -n 1`);
}
$n10=($n01+1)%2;
%data1=&make_password($max_num+$n01);
%data2=&make_password($max_num+$n10);

        print '0  :',$data1{'hash'},"\n" ;
        print '1  :',$data2{'hash'},"\n" ;
        print "what is your choice\n" ;
        if ($test){
          $win+=&check($n01);
        }
        else{
        $line=<STDIN>;
        chomp $line;
        if ($line eq '0')
        {&check($n01);}
        else
        {&check($n10);}
      }
        $echo1='echo -n "'.$data1{'pass'}.'" | sha1sum';
        $echo2='echo -n "'.$data2{'pass'}.'" | sha1sum';
        print $echo1,"\n";
        print $echo2,"\n";

   $calc += 1;
} while $calc <100;
print $win,"\n";
}

my %options;
getopts('e:h', \%options);
$options{h} && usage();
sub usage
{
 print <<FILE;
eggs.pl  [-h] [-e eggnum] 
FILE
exit;
}
my $eggnum = $options{e} || '0';
if ($eggnum eq '0' ){

$str1=$ARGV[0];
@time1=split /\//, $str1;
&easter_egg1($time1[0],$time1[1],$time1[2]);
  exit 0
}
if ($eggnum eq '1' ){
&easter_egg2($ARGV[0]);
  exit 0
}
