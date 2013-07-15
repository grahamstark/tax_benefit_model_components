#! /usr/bin/env python
#
# inequality.py 1.3.4 inequality computations for welfare economics
# GPL(c): Goetz Kluge, Munich 2004-09-17, http://poorcity.richcity.org
#
# programming language:
#     Python, http://www.python.org
# download Python for Windows:
#     http://gnuwin.epfl.ch/apps/Python/en/index.html
#
# This program originally was written in Lua and has been converted to Python.
# The Lua program inequal.lua is here:
#     http://poorcity.richcity.org/LuaIneq
#
# "Societal aversion against inequality" is epsilon. Example:
#     epsilon = 1:   undistorted data (I recommend that setting)
#     epsilon = 0.5: low aversion against inequality
#     epsilon = 2:   high aversion against inequality


# initialization ----------------------------------------------------------

# use math library
import math


# define classes -----------------------------------------------------------

#---------------------------------------------------------------------------
class Object:
  def __init__(self):
    """ nothing to construct """
    pass
# def get(self,name):
#   """ makes getattr a method of this object """
#   return getattr(self,name)
# def set(self,name,value):
#   """ makes setattr a method of this object """
#   setattr(self,name,value)
  def prt(self,namelist):
    """ print selected elements of object """
    for name in namelist:
      print name+": %.3f" % getattr(self,name)
      
#---------------------------------------------------------------------------
class Redundancy(Object):
  def prt(self,namelist,epsilon):
    """ print selected elements of Redundancy """
    for name in namelist:
      print name.replace("_","-")+" redundancy: %.3f" % ((getattr(self,name)) * epsilon*100)
   
#---------------------------------------------------------------------------
class Equality(Object):
  def prt(self,namelist,epsilon):
    """ print selected elements of Equality """
    for name in namelist:
      print name.replace("_","-")+" equality: %.1f%%" % (((getattr(self,name)) ** epsilon)*100)
   
#---------------------------------------------------------------------------
class Inequality(Object):
  def prt(self,namelist,epsilon):
    """ print selected elements of Inequality """
    for name in namelist:
      print name.replace("_","-")+" inequality: %.1f%%" % ((1 - (1-getattr(self,name)) ** epsilon)*100)
   
#---------------------------------------------------------------------------
class Variation(Object):
  def prt(self,namelist):
    """ print selected elements of Variation """
    for name in namelist:
      print name.replace("_","-")+" variation: %.3f" % getattr(self,name)
   
#---------------------------------------------------------------------------
class Sum(Object):
  def prt(self,namelist):
    """ print selected elements of Sum """
    for name in namelist:
      print name.replace("_","-")+" total: %.3f" % getattr(self,name)
   


# define functions ---------------------------------------------------------

#---------------------------------------------------------------------------
def ineq(in_dataset):
  """ compute inequalities from a set of quantiles """

  # add to quantile: ln(e[i]/a[i]) and i
  # (example: a people in a quantile together earn an income of e)
  dataset = []
  for q in in_dataset:
    quantile = Object() # new quantile
    quantile.population= (q[0] + 1E-66)
    quantile.income = (q[1] + 1E-66)
    quantile.log = math.log(quantile.income/quantile.population)
    quantile.oldi = len(dataset)  # we memorize the original sequence just in case...
    dataset.append(quantile)
  n = len(dataset)

  # sort table by ln(e[i]/a[i]) (only necessary for Gini)
  dataset.sort(
    lambda firstquantile,secondquantile:
      cmp(firstquantile.log,secondquantile.log)
  )

  # computations (Lorenz curve and growth)
  dataset[0].popn_accum = dataset[0].population # initialize accu a
  dataset[0].income_accum = dataset[0].income  # initialize accu e
  dataset[0].growth = 0.0
  for i in range(len(dataset)-1):
    quantile = dataset[i+1]
    quantile.popn_accum = dataset[i].popn_accum + quantile.population # x (could be used for Lorenz curve)
    quantile.income_accum = dataset[i].income_accum + quantile.income  # y (could be used for Lorenz curve)
    quantile.growth = math.exp(quantile.log - dataset[i].log)  # (experimental)
    dataset[i+1] = quantile
  
  for q in dataset:
    print "income %f population %f log %f p %d income_accum %f popn_accum %f growth %f " % ( q.income, q.population, q.log, q.oldi, q.income_accum, q.popn_accum, q.growth )

  # compute totals
  sum = Sum()
  sum.population= dataset[-1].popn_accum
  sum.income = dataset[-1].income_accum
  sum.logxa = 0.
  sum.logxe = 0.
  sum.lorenz = 0.
  sum.abs = 0.
  sum.square = 0.
  sum.var = 0.
  for quantile in dataset:
    x = ((quantile.income/quantile.population-sum.income/sum.population)**2) * quantile.population/sum.population
    sum.var += x
    print " adding %f to sum.var " % ( x )
    x = abs(quantile.income/sum.income - quantile.population/sum.population)
    sum.abs +=  x
    sum.square += x*x
    sum.logxa += quantile.log * quantile.population
    sum.logxe += quantile.log * quantile.income
    sum.lorenz += (quantile.income_accum * 2 - quantile.income) * quantile.population

  print "sum.population=%f sum.income=%f sum.square=%f  sum.abs=%f sum.logxa=%f sum.logxe=%f sum.lorenz=%f sum.var=%f" % ( sum.population, sum.income, sum.square, sum.abs,sum.logxa, sum.logxe,sum.lorenz,sum.var);
  # compute redundancies and inequalities
  # (actual "redundancy" is max. entropy minus actual entropy)
  equality = Equality()
  inequality = Inequality()
  redundancy = Redundancy()
  variation = Variation()
  x = math.log(sum.population) - math.log(sum.income)
  redundancy.Theil = sum.logxe/sum.income + x
  redundancy.Theil_swapped = -sum.logxa/sum.population- x
  redundancy.Kullback_Leibler = (redundancy.Theil + redundancy.Theil_swapped)/2
  equality.MacRae = math.exp(-redundancy.Theil)
  inequality.Atkinson = 1 - equality.MacRae
  inequality.Kullback_Leibler = 1 - math.exp(-redundancy.Kullback_Leibler)
  inequality.Hoover = sum.abs/2
  inequality.Gini = 1 - (sum.lorenz/sum.income)/sum.population
  equality.Europe = (1-inequality.Gini)/(1+inequality.Gini)
  inequality.Europe = 1 - equality.Europe
  # inequality.Herfindahl = sum.square  # not okay
  inequality.Coulter = math.sqrt(sum.square/2)
  variation.Williamson = math.sqrt(sum.var)*sum.population/sum.income

  # compute Platon inequality
  kli = inequality.Kullback_Leibler
  dkli = 1
  inequality.Platon = 1
  while ((abs(dkli)>0.00001) and (kli<1)):
    pareto = math.asin((1-kli)**(kli*0.06+0.61))/math.pi
    dkli = 0
    if (pareto>0):
      inequality.Platon = 1-2*pareto  # e.g. (0.4+1)/2=0.7: 70% own 30%, 30% own 70%
      dkli = (1/pareto-1)**(-inequality.Platon) - 1 + inequality.Kullback_Leibler
      if (inequality.Platon > 0.97):
        dkli = dkli/10
    kli += dkli

  return inequality,redundancy,equality,variation,sum


#---------------------------------------------------------------------------
def printresults(container):
  inequality,redundancy,equality,variation,sum = container
  epsilon = 1   # keep epsilon = 1 for undistorted data
  inequality.prt(("Kullback_Leibler","Atkinson","Gini","Europe","Hoover","Coulter","Platon"),epsilon)
  equality.prt(("MacRae",),epsilon) # okay, but not so interesting
  variation.prt(("Williamson",)) # okay, but not so interesting
  redundancy.prt(("Kullback_Leibler","Theil"),epsilon) # okay, but not so interesting
  print



# ----- main ----- start program -------------------------------------------

# (1) inequality computation for
# total income after taxation, 1995, Germany (western part)
# source: section 20.10.4 in "Statistisches Jahrbuch 1999"
# Sequence in Quantile: [taxpayers, their total income]
print "(1) inequality computation fortotal income after taxation, 1995, Germany (western part)"
printresults(ineq((\
  (1145008,2954.348),\
  (1274868,9680.002),\
  (1489169,18586.468),\
  (1309984,22810.086),\
  (1227877,27624.267),\
  (1333681,36713.66),\
  (3136635,110401.129),\
  (3619401,162869.097),\
  (3105688,170061.277),\
  (3252768,217926.704),\
  (3383398,291369.018),\
  (3126897,420418.974),\
  (207672,68629.438),\
  (49031,32752.279),\
  (13820,18659.358),\
  (5249,15461.399),\
  (1247,8458.446),\
  (686,14801.379),\
)))


# (2) inequality computation for
# total assets, 1995, Germany (western part)
# source: German federal parlament, protocol 13/7828
# Sequence in Quantile: [taxpayers, their total assets]
container = ineq((\
  (50,2.5),\
  (40,47.5),\
  (9,27),\
  (1,23),\
))
print "(2) inequality computation for total assets, 1995"
printresults(container)


# (3) playing with the Platon inequality from
# computation (2)
inequality,redundancy,equality,variation,sum = container
x=(inequality.Platon+1)/2
printresults(ineq((\
  (x,1-x),\
  (1-x,x),\
)))

print "(3) playing with the Platon inequality from computation (2)";

# (4) extreme inequality
container = ineq((\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1),\
  (1,1E8),\
))
print "(4) all 1s"
printresults(container)



# = result: =========================
# >C:\Python23\python -u "inequality.py"
# Kullback-Leibler inequality: 32.3%
# Atkinson inequality: 32.8%
# Gini inequality: 42.2%
# Hoover inequality: 29.7%
# Coulter inequality: 13.4%
# Platon inequality: 42.8%
#
# Kullback-Leibler inequality: 68.7%
# Atkinson inequality: 64.1%
# Gini inequality: 64.5%
# Hoover inequality: 47.5%
# Coulter inequality: 39.5%
# Platon inequality: 68.8%
#
# Kullback-Leibler inequality: 68.7%
# Atkinson inequality: 68.7%
# Gini inequality: 68.8%
# Hoover inequality: 68.8%
# Coulter inequality: 68.8%
# Platon inequality: 68.8%
#
# Kullback-Leibler inequality: 100.0%
# Atkinson inequality: 97.3%
# Gini inequality: 97.3%
# Hoover inequality: 97.3%
# Coulter inequality: 69.7%
# Platon inequality: 100.0%
#
# >Exit code: 0
#===================================

