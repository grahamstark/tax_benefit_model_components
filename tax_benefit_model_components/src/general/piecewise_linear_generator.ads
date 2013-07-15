--
-- copyrigh(c) 2009 Graham Stark/ Virtual Worlds (graham.stark@virtual-worlds.biz)
--
-- ////////////////////////////////
--
-- This is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 3, or (at your option)
-- any later version.
-- 
-- It is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this software; see the file docs/gpl_v3.  If not, write to
-- the Free Software Foundation, Inc., 51 Franklin Street,
-- Boston, MA 02110-1301, USA.
-- 
-- /////////////////////////////
-- $Revision: 13529 $
-- $Author: graham_s $
-- $Date: 2012-01-11 11:30:45 +0000 (Wed, 11 Jan 2012) $
--
--
--
-- A generic Piecewise Linear function generator, in ADA 2005. See Stark and Duncan 2001.
--
-- Todo: Maybe get rid of the Vector in the public section? Maybe switch start and stop to the 
-- function call? Maybe kill the inspection stuff?
-- 
pragma License( Modified_GPL );

with Ada.Containers.Vectors;

generic 
   --
   -- This is the floating type we use throughout. 
   --
   type Rate is digits<>;
   
   --
   -- Add increment to the x (e,g. income) values when generating our function.
   -- Test equality of points and lines to within tolerance
   -- Generally, this works best of tolerance is about 10x increment, though
   -- I've never been absolutely clear why.
   -- 
   TOLERANCE : Rate;
   INCREMENT : Rate;
   
   --
   -- The function is recursive: raise a Piecewise_Generator_Exception if calls exceed this depth.
   --
   MAX_DEPTH : Integer;
   
   --
   -- This contains whatever the Calculate_One_Position function needs to do just that.
   -- Possibly, in a tax-benefit model, a household record, and tax system and runs settings.
   --
   type Control_Record is private;
   
   --
   -- This holds the results of one run_inspection call. Perhaps, things like what taxes are payable 
   -- or benefits receivable at that point, or immediately around it.
   --
   type Details is private;

   --
   -- Run some model, with all the parameters, etc. in controls (and fixed)
   -- and x as an input (like hours, earnings, etc..). Return the y - axis number
   -- (net income, for example)
   --
   with function Calculate_One_Position( 
      x        : Rate; 
      controls : Control_Record ) return Rate;
   
   --
   -- Run some inspection routine to find out what's happening at point x,y and
   -- return some data item describing it. Not really needed in the great scheme of things
   -- but handy.
   -- 
   with function Run_Inspector( 
      x, y : Rate; 
      controls : Control_Record ) return Details;
                 
package Piecewise_Linear_Generator is

   type Point is record
      x : Rate;
      y : Rate;
   end record;
   
   type Line is record
      a : Rate;
      b : Rate;
   end record;

   
   package Points_Package is new Ada.Containers.Vectors( Element_Type => Point, Index_Type => Positive );
   package Details_Package is new Ada.Containers.Vectors( Element_Type => Details, Index_Type => Positive );
   subtype Points_List is Points_Package.Vector;
   subtype Details_List is Details_Package.Vector;
   
   --
   -- This generates our piecewise-linear function, returning it as a list of points
   --
   function Generate( 
      controls  : Control_Record;
      start_pos : Rate; 
      end_pos   : Rate ) return Points_List;
   
   --
   -- This takes our list of points generated above and generates from it a list of details about each point.
   --
   procedure Inspect( points : Points_Package.Vector; dets_list : in out Details_List; controls : Control_Record );
    
   Piecewise_Generator_Exception : exception;
   
   function To_String( p : Point ) return String;
   function To_String( l : Line ) return String;

end Piecewise_Linear_Generator;
