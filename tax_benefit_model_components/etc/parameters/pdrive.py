#!/usr/bin/env python
#
# copyrigh(c) 2007 Graham Stark (graham.stark@virtual-worlds.biz)
#
# ////////////////////////////////
#
# This is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
# 
# It is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this software; see the file docs/gpl_v3.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.
# 
# /////////////////////////////
# $Revision: 7751 $
# $Author: graham_s $
# $Date: 2009-07-23 07:29:40 +0100 (Thu, 23 Jul 2009) $
#

import sys, os
from ada_generator import AdaRecordGenerator
from mpaths import WORKING_PATHS
from parameters_model import parseParametersSchema, iterate

if( len(sys.argv[1]) < 1 ):
        print "use python pdrve.py [target dir; should have schemas in xml/ dir]"

print "***** using the following paths ********"

print WORKING_PATHS ## a global variable, I'm afraid

WORKING_PATHS.makeTargetDirs();

xmlFileName = WORKING_PATHS.xmlDir + 'parameters.xml'

params = parseParametersSchema( xmlFileName )

xp = params.toXMLDocument()

print xp.toprettyxml( "       " )

generator = AdaRecordGenerator()

iterate( params, params, generator, 0 )

generator.writeEnumsAds()

generator.writeEnumsAdb()

generator.writeAds()

generator.writeAdb()

