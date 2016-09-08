load '/home/graham_s/OU/DD309/econometrics/tutorials/gnuplot/stats_functions.gnu';
#  see: http://stackoverflow.com/questions/2471884/histogram-using-gnuplot

binwidth=1.0

chisquare_correction( x, n, popn_sdev )=(n-1)*n/(n-1)*x/(popn_sdev**2);

f_dist( sample_var1, pop_var1, sample_var2, pop_var2 ) = ( sample_var1/pop_var1 ) / ( sample_var2/pop_var2 ); 

t_dist( x, popn_mean, n, samp_variance ) = (x-popn_mean)*(n**0.5)/(samp_variance**0.5);

# bin(x,width)=width*floor(x/width)
bin(x,width)=width*floor(x/width) + binwidth/2.0

stats '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/50000_samples_from_uniform_0_59.csv'\
    every ::1;
n =  50000;

set terminal svg size 500,400 enhanced butt solid
set yzeroaxis linetype 0 linewidth 1.000;
set xzeroaxis linetype 0 linewidth 1.000;
set zeroaxis;
set format x "%.1f";
set format y "%.1f";
set style histogram;
set datafile separator ",";

set xrange [ 0 : 60 ]
set output '/home/graham_s/OU/DD309/econometrics/tutorials/images/uniform_samples.svg'

plot \
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/50000_samples_from_uniform_0_59.csv' \
    using (bin($1,binwidth)):(1.0/n) \
    every ::1 smooth freq with lines ti '2',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/50000_samples_from_uniform_0_59.csv' \
    using (bin($4,binwidth)):(1.0/n) \
    every ::1 smooth freq with lines ti '10',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/50000_samples_from_uniform_0_59.csv' \
    using (bin($7,binwidth)):(1.0/n) \
    every ::1 smooth freq with lines  ti '50',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/50000_samples_from_uniform_0_59.csv' \
    using (bin($10,binwidth)):(1.0/n) \
    every ::1 smooth freq with lines  ti '100',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/50000_samples_from_uniform_0_59.csv' \
    using (bin($13,binwidth/5)):(5.0/n) \
    every ::1 smooth freq with lines ti '1,000';
    
    
unset output; # svg output not completed till you do this    

#stats '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv'\
#    every ::1;
#n =  STATS_records;
n =  200000;
binwidth = 0.25
set xrange [ 150 : 200 ]
set output '/home/graham_s/OU/DD309/econometrics/tutorials/images/normal_samples.svg'
plot \
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin($1,binwidth)):(1.0/n) \
    every ::1 smooth freq with lines ti '2',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin($4,binwidth)):(1.0/n) \
    every ::1 smooth freq with lines ti '10',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin($7,binwidth)):(1.0/n) \
    every ::1 smooth freq with lines  ti '50',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin($10,binwidth)):(1.0/n) \
    every ::1 smooth freq with lines  ti '100',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin($13,binwidth)):(1.0/n) \
    every ::1 smooth freq  with lines ti '1,000';

unset output; # svg output not completed till you do this  

binwidth=0.2
set output '/home/graham_s/OU/DD309/econometrics/tutorials/images/mean_vs_median.svg'
set xrange [ 172 : 182 ]
plot \
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin($10,binwidth)):(1.0/n) \
    every ::1 smooth freq with lines  ti 'mean',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin($11,binwidth)):(1.0/n) \
    every ::1 smooth freq with lines ti 'median';
unset output; # svg output not completed till you do this

set xrange [ 0 : 120 ]
binwidth = 2
set output '/home/graham_s/OU/DD309/econometrics/tutorials/images/normal_variances_chisquare.svg'
plot \
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin(chisquare_correction( $6, 10, 8.5 ),binwidth)):(1.0/n) \
    every ::1 smooth freq with lines ti '10',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin( chisquare_correction( $9, 50, 8.5 ),binwidth)):(1.0/n) \
    every ::1 smooth freq with lines  ti '50',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin( chisquare_correction( $12, 100, 8.5 ),binwidth)):(1.0/n) \
    every ::1 smooth freq with lines  ti '100',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin( chisquare_correction( $15, 1000, 8.5 ),binwidth)):(1.0/n) \
    every ::1 smooth freq  with lines ti '1,000';

unset output; # svg output not completed till you do this  

set xrange [ 0 : 120 ]
binwidth = 1
set output '/home/graham_s/OU/DD309/econometrics/tutorials/images/normal_variances.svg'
plot \
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin( $6,binwidth)):(1.0/n) \
    every ::1 smooth freq with lines ti '10',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin( $9,binwidth)):(1.0/n) \
    every ::1 smooth freq with lines  ti '50',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin( $12, binwidth)):(1.0/n) \
    every ::1 smooth freq with lines  ti '100',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin( $15 ,binwidth)):(1.0/n) \
    every ::1 smooth freq  with lines ti '1,000';

unset output; # svg output not completed till you do this  

set xrange [ -5 : 5 ]
binwidth = 0.2
set output '/home/graham_s/OU/DD309/econometrics/tutorials/images/t_dist.svg'
plot \
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin( t_dist( $4, 177, 10, $6 ), binwidth)):(1.0/n) \
    every ::1 smooth freq with lines ti '10',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin( t_dist( $7, 177, 50, $9 ),binwidth)):(1.0/n) \
    every ::1 smooth freq with lines  ti '50',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin( t_dist( $10, 177, 100, $12 ),binwidth)):(1.0/n) \
    every ::1 smooth freq with lines  ti '100',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin( t_dist( $13, 177, 1000, $15 ),binwidth)):(1.0/n) \
    every ::1 smooth freq  with lines ti '1,000';

set xrange [ 0 : 5 ]
binwidth = 0.1
set output '/home/graham_s/OU/DD309/econometrics/tutorials/images/f_dist.svg'
plot \
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin( f_dist( $6, 72.25, $15, 72.25 ), binwidth)):(1.0/n) \
    every ::1 smooth freq with lines ti '10',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin( f_dist( $6, 72.25, $15, 72.25 ) ,binwidth)):(1.0/n) \
    every ::1 smooth freq with lines  ti '50',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin( f_dist( $6, 72.25, $15, 72.25 ),binwidth)):(1.0/n) \
    every ::1 smooth freq with lines  ti '100',\
    '/home/graham_s/OU/DD309/econometrics/tutorials/datasets/200_000_samples_from_normal_177.csv' \
    using (bin( f_dist( $6, 72.25, $15, 72.25 ),binwidth)):(1.0/n) \
    every ::1 smooth freq  with lines ti '1,000';
    
    
unset output; # svg output not completed till you do this  

