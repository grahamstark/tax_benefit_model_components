load 'stats_functions.gnu';
# set terminal svg size 800,600 ;
# set terminal epslatex 
# size 113.5,112.62 color colortext
# set output 'normal_and_t_test1.tex'
# set terminal postscript eps enhanced color font 'Helvetica,10'
# set output 'normal_and_t_test1.eps'
set terminal svg size 500,400 enhanced butt solid
# set terminal postscript eps enhanced color font 'Helvetica,10'
# set output 'normal_and_t_test_2.eps'
set yzeroaxis linetype 0 linewidth 1.000;
set xzeroaxis linetype 0 linewidth 1.000;
set zeroaxis;
set format x "%.1f";
set format y "%.2f";
set xrange [ 0 : 4 ]
set output '../images/log_normal.svg'
set title "Log Normal Distribution";
plot  lognormal( x, 0, 1 ) linecolor rgb "#8888AA" ti ''
unset output; # svg output not completed till you do this

set xrange [-4:4 ]
set xlabel 'X'
set output '../images/standard_normal.svg'
set title "The Standard Normal Distribution";
plot  normal( x, 0, 1 ) linecolor rgb "#8888AA" with filledcurves above x1=1.96 ti '2.5%', \
      normal( x, 0, 1 ) linecolor rgb "#8888AA" with filledcurves below x1=-1.96 ti '', \
      normal( x, 0, 1 ) linecolor rgb "#444477" with filledcurves above x1=2.575 ti '0.5%', \
      normal( x, 0, 1 ) linecolor rgb "#444477" with filledcurves below x1=-2.575 ti ''
      
unset output; # svg output not completed till you do this


set key inside left top vertical Right noreverse enhanced autotitles box \
   linetype -1 linewidth 1.000;
set title "t PDF (and Gaussian Limit)";

set output '../images/normal_and_t_test1.svg'

plot  normal( x, 0, 1 ) linecolor rgb "#DD6677" with filledcurves below x1=-1.96,\
      normal( x, 0, 1 ) linecolor rgb "#DD6677" with filledcurves above x1=1.96 ti '' ,\
      t( x, 10 ) ti "t(10DF)",\
      t( x, 20 ) ti "t(20DF)";
      
unset output; # svg output not completed till you do this

set format x "%.0f";
# set key inside right top vertical Right noreverse enhanced autotitles;
n=10
mean = 173
sd   = 8.5/(n**0.5)
set arrow from mean,0 to mean, 0.16 nohead lc rgb "grey" lw 0.5 lt 1
set xrange [ 160:190 ]
set xlabel 'Height (cm)'
set output '../images/normal_173_85.svg'
set title "Testing Ho: mean=173";
set xtics 163,5,188
plot  normal( x, mean, sd ) linecolor rgb "#8888AA" with filledcurves above x1=mean+(1.96*sd) ti '', \
      normal( x, mean, sd ) linecolor rgb "#8888AA" with filledcurves below x1=mean+(-1.96*sd) ti '', \
      normal( x, mean, sd ) linecolor rgb "#444477" with filledcurves above x1=179.26 ti '';
unset output; # svg output not completed till you do this

set format x "%.0f";
# set key inside right top vertical Right noreverse enhanced autotitles;
mean = 0
sd   = 1
set arrow from 1,0 to 1, 0.4 nohead lc rgb "grey" lw 0.5 lt 1
set arrow from -1,0 to -1, 0.4 nohead lc rgb "grey" lw 0.5 lt 1
set xrange [ -4:4 ]
set xlabel ''
set output '../images/standard_normal_0_1.svg'
set title "";
set xtics -3,1,3
plot  normal( x, mean, sd ) linecolor rgb "#8888AA" with filledcurves above x1=mean+(1.96*sd) ti '', \
      normal( x, mean, sd ) linecolor rgb "#8888AA" with filledcurves below x1=mean+(-1.96*sd) ti '', \
      normal( x, mean, sd ) linecolor rgb "#444477" with filledcurves above x1=2.33637 ti '';
unset output; # svg output not completed till you do this

set xrange [ -4:4 ]
set xlabel ''
set xtics -3,1,3
set output '../images/ts.svg'
plot\
      t( x, 5 ) linecolor rgb "#FF0000"  ti '5' ,\
      t( x, 10 ) linecolor rgb "#EE00EE"  ti "10",\
      t( x, 20 ) linecolor rgb "#00CCAA"  ti "20",\
      normal( x, 0, 1 ) linecolor rgb "#444477" ti "Std. Normal";
unset output;

set xrange [ -4:4 ]
set xlabel ''
set output '../images/standard_normal_0_1.svg'
set title "";
set xtics -3,1,3
plot\
      t( x, 9 ) linecolor rgb "#DD6677" with filledcurves above x1=1.96 ti '' ,\
      t( x, 9 ) linecolor rgb "#444477" with filledcurves above x1=2.33637 ti ""
unset output;

set output '../images/t_test_heights.svg'
set xrange [ -4:4 ]
set xlabel ''
set xtics -3,1,3
plot\
      t( x, 9 ) linecolor rgb "#444477" with filledcurves above x1=2.172 ti '',\
      t( x, 9 ) linecolor rgb "#8888AA" with filledcurves below x1=-2.262 ti '',\
      t( x, 9 ) linecolor rgb "#8888AA" with filledcurves above x1=2.262 ti '',\
      t( x, 9 ) linecolor rgb "#000000" ti '';
unset output;

set title 'Chi-Square Distribution'
set output '../images/chisquares.svg'
set xrange [ 0.1:14 ]
set xlabel ''
set ylabel ''
set xtics 0,1,14
set format x "%.0f";
set format y "%.1f";
plot\
      chisq( x, 2 )  ti '2',\
      chisq( x, 6 )  ti '6',\
      chisq( x, 12 )  ti '12';
unset output;

set title 'F Distributions for various degrees of freedom'
set output '../images/fs.svg'
set xrange [ 0.1:4 ]
set xlabel ''
set ylabel ''
set xtics 0,1,4
set format x "%.0f";
set format y "%.1f";
plot\
      f( x, 4, 4 )  ti '4,4',\
      f( x, 2, 20 )  ti '2,20',\
      f( x, 20, 20 )  ti '20,20',\
      f( x, 120, 120 )  ti '120,120';
unset output;


set title 'T Confidence Intervals'
set output '../images/t-intervals.svg'
set xrange [ 160:190 ]
set xlabel ''
set ylabel ''
set xtics 160,10,190
set format x "%.0f";
set format y "%.1f";
plot\
      t( x, 9 )  ti '';
unset output;

set output '../images/t_test_blank.svg'
unset title;
unset arrow
unset xlabel
unset yrange
set xrange [ -4:4 ]
set xtics -3,1,3
set format x "";
set format y "";
true_mean = -0.4328
set arrow from true_mean,0 to true_mean,0.05 nohead lc rgb '#888888' lt 0
# set arrow from -2.262,-0.03 to 2.262,-0.03 nohead lc rgb '#8888AA' lt 0
# set arrow from -3.250,-0.04 to 3.250,-0.04 nohead lc rgb '#444477' lt 0
plot\
      t( x, 9 ) linecolor rgb "#8888AA" with filledcurves below x1=-2.262 ti '',\
      t( x, 9 ) linecolor rgb "#8888AA" with filledcurves above x1=2.262 ti '',\
      t( x, 9 ) linecolor rgb "#444477" with filledcurves below x1=-3.250 ti '',\
      t( x, 9 ) linecolor rgb "#444477" with filledcurves above x1=3.250 ti '',\
      t( x, 9 ) linecolor rgb "#000000" ti '';
unset output;
# set yrange [ -0.05:0.4 ]
# set xlabel 'Heights (cm)'

