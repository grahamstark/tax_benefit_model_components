set terminal svg size 800,600 enhanced butt solid
set yzeroaxis linetype 0 linewidth 1.000;
set xzeroaxis linetype 0 linewidth 1.000;
set zeroaxis;
set format x "%.1f";
set format y "%.1f";
set style histogram;
set datafile separator ",";


load '/home/graham_s/OU/DD309/econometrics/tutorials/gnuplot/stats_functions.gnu';
# see: http://stackoverflow.com/questions/2471884/histogram-using-gnuplot
# dice graph only
binwidth=0.2

# bin(x,width)=width*floor(x/width)
bin(x,width)=width*floor(x/width) + binwidth/2.0

# stats '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/100000_samples_from_uniform_0_59.csv'\
#    every ::1;
n =  1000000;


set xrange [ 1 : 6 ]
set output '/home/graham_s/OU/DD309/econometrics/tutorials/images/dice_1000_000_samples.svg'
plot \
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/1000_000_samples_from_dice2.csv' \
    using (bin($1,binwidth)):(1.0/n) \
    every ::1 smooth freq with lines  ti '2',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/1000_000_samples_from_dice2.csv' \
    using (bin($4,binwidth)):(1.0/n) \
    every ::1 smooth freq with lines  ti '10',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/1000_000_samples_from_dice2.csv' \
    using (bin($7,binwidth)):(1.0/n) \
    every ::1 smooth freq with lines  ti '50',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/1000_000_samples_from_dice2.csv' \
    using (bin($10,binwidth)):(1.0/n) \
    every ::1 smooth freq with lines  ti '100',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/1000_000_samples_from_dice.csv' \
    using (bin($13,binwidth)):(1.0/n) \
    every ::1 smooth freq with lines ti '1,000',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/1000_000_samples_from_dice2.csv' \
    using (bin($13,binwidth)):(1.0/n) \
    every ::1 smooth freq with lines ti '10,000';

unset output; # svg output not completed till you do this    

