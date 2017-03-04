--
-- copyright(c) 2007 Graham Stark/ Virtual Worlds (graham.stark@virtual-worlds.biz)
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
-- $Revision: 15649 $
-- $Author: graham_s $
-- $Date: 2012-11-07 13:48:55 +0000 (Wed, 07 Nov 2012) $
--
--
-- Implementation of a Piecewise-Linear function generator. See Stark and Duncan 2001.
--
pragma License( Modified_GPL );

with Ada.Exceptions; 
with Maths_Functions;

package body Piecewise_Linear_Generator is

   VERTICAL : constant := 9999999999.9999;
   package maths is new Maths_Functions( Rate );
   
   --
   -- make a line of the form y = a + bx from two points
   -- slightly trickier than it sounds because of overflows from
   -- vertical or near-vertical lines
   --
   function Make_Line( point_1 : Point; point_2 : point ) return Line is
      l : Line;
      line_as_rate : Rate;
   begin
      if( point_1.x = point_2.x )then
         l.b := point_1.x;
         l.a := VERTICAL;
         return l;
      end if;
      line_as_rate := (point_1.y - point_2.y)/(point_1.x - point_2.x );
      line_as_rate := Rate'Min( line_as_rate, VERTICAL );
      l.b := Rate( line_as_rate );
      l.a := ( point_1.y - point_1.x*l.b );
      return l;
   end Make_Line;

   --
   -- The point at which two lines intersect
   -- 
   --
   function Find_Intersection( line_1 : Line; line_2 : Line ) return Point is
      p : Point;
   begin
      if line_1.b /= line_2.b then
         p.x := (line_2.a - line_1.a) / (line_1.b - line_2.b);
         p.y := line_1.a + (p.x * line_1.b);
      else 
         p.x := 0.0;
         p.y := line_1.a;
      end if;
      return p;
   end Find_Intersection;

   --
   -- Convenience function to calculate an effective marginal rate between two points, as a percentage.
   -- Not actually used.
   -- 
   function Calc_Marginal_Rate( point_1: Point; point_2 : point ) return Rate is
      mr : Rate;
   begin
      if( point_2.x /= point_1.x ) then
         mr := 100.0 * (point_2.y-point_1.y) / (point_2.x - point_1.x);
      else
         mr := 0.0;
      end if;
      mr := 100.0 - mr;
      return mr;
   end Calc_Marginal_Rate;

   --
   -- Ordering function for two points, return true if point_2 is
   -- to the right of point_2, or they have the same x but point_2 is above.  
   -- 
   function Compare_Points( point_1, point_2 : Point ) return boolean is
   begin
      return (point_1.x < point_2.x) or ( (point_1.x = point_2.x) and (point_1.y < point_2.y) );
   end Compare_Points;

   package Sorter is new Points_Package.Generic_Sorting( "<" => Compare_Points ); 
   
   function To_String( p : Point ) return String is
   begin
      return " x = " & Rate'Image(p.x) & " y = " & Rate'Image(p.y);
   end To_String;
   
   function To_String( l : Line ) return String is
   begin
      return " a = " & Rate'Image(l.a) & " b = " & Rate'Image(l.b);
   end To_String;
   
   function Nearly_Same_Line( l1, l2 : Line ) return Boolean is
   begin
      return (( (abs (l1.a-l2.a)) < TOLERANCE) and ( (abs (l1.b-l2.b)) < TOLERANCE));
   end Nearly_Same_Line;
   
   function Nearly_Same_Point( l1, l2 : Point; reltol : Rate := 10.0 ) return Boolean is
      tol : constant Rate := reltol*TOLERANCE;
   begin
      return (( (abs (l1.x-l2.x)) < tol ) and ( (abs (l1.y-l2.y)) < tol ));
   end Nearly_Same_Point;
   
   procedure Round(  
      points_l   : in out  Points_List;
      precision  : Natural := 2 ) is
      use Points_Package;
      
      procedure Round_One( pos : Cursor ) is
         pt : Point := Element( pos );
      begin
         pt.x := maths.Truncate_To( pt.x, precision );
         pt.y := maths.Truncate_To( pt.y, precision );
         points_l.Replace_Element( pos, pt );    
      end Round_One;
      
   begin
      Iterate( points_l, Round_One'Access );
   end Round;
   
   -- 
   -- Sort the points into ascending x values,
   -- Then attempt to delete near-duplicate points, or points on the same straight line other than
   -- the endpoints.
   -- 
   procedure Censor( 
      points_l     : in out  Points_List ) is
      npoints      : Natural := Natural( points_l.Length );
      l : array( 1 .. 2 ) of Line;
      p : array( 1 .. 3 ) of Point;
      i : Natural;
    begin
      
      Sorter.Sort( points_l );
      if( npoints <= 3 ) then
         return;
      end if;
      --
      -- starting at 2 and ending and n-1 ensures we always keep the
      -- start and endpoints.
      -- 
      i := 2;
      loop
         p(1) := points_l.Element( i-1 );
         p(2) := points_l.Element( i );
         p(3) := points_l.Element( i+1 );
         l(1) := Make_Line( p(1), p(2) );
         l(2) := Make_Line( p(2), p(3) );
         if Nearly_Same_Line( l(1), l(2) ) then
            --
            -- 2 lines are the same? Delete the middle point.
            --
            points_l.Delete( i );
            npoints := npoints - 1;
         else
            i := i+1;
         end if;
         exit when ( i >= npoints );
      end loop;
      i := 1;
      loop
         p(1) := points_l.Element( i );
         p(2) := points_l.Element( i+1 );
         if Nearly_Same_Point( p(1), p(2) ) then
            --
            -- 2 points are same? Delete one or the other.
            --
            points_l.Delete( i );
            npoints := npoints - 1;
         end if;
         i := i + 1;
         exit when ( i > npoints-1 );
      end loop;
   end Censor;
   
   procedure Generate(
      points_l   : in out Points_List;
      controls   : Control_Record; 
      depth      : in out Integer; 
      start_pos  : Rate; 
      end_pos    : Rate ) is
      anchor : Rate;
      points : array( 1 .. 5 ) of Point;
      lines  : array( 1 .. 2 ) of Line;
   begin
      if( abs(start_pos - end_pos) < TOLERANCE ) then
         return;      
      end if;
      if( depth > MAX_DEPTH ) then
         Ada.Exceptions.Raise_Exception( 
            Piecewise_Generator_Exception'Identity, 
            "generate_points: depth exceeded max is " & Integer'Image( MAX_DEPTH ));
      end if;
      --
      -- left line in points 1,2 
      --
      points(1).x := start_pos;
      points(1).y := Calculate_One_Position( points(1).x, controls );
      points(2).x := start_pos + INCREMENT;
      points(2).y := Calculate_One_Position( points(2).x, controls );
      --
      -- right line in 3,4
      --
      points(4).x := end_pos;
      points(4).y := Calculate_One_Position( points(4).x, controls );
      points(3).x := end_pos - INCREMENT;
      points(3).y := Calculate_One_Position( points(3).x, controls );
      lines(1) := Make_Line( points(1), points(2) );
      lines(2) := Make_Line( points(3), points(4) );
      if Nearly_Same_Line( lines(1), lines(2)) then
         --
         -- Same line, so the section we're testing represents a single straight segment.
         -- We're done exploring this bit; store the line endpoints and return,
         --
         if( not Points_Package.Contains( points_l, points(1))) then
            Points_Package.append( points_l, points(1));
         end if;
         if( not Points_Package.Contains( points_l, points(4))) then
            Points_Package.Append( points_l, points(4));
         end if;
         return;         
      end if;
      --
      -- If we're not done here, find where the lines meet and explore each side of there. 
      -- If the meeting point is out range of the current section being tested, or exactly
      -- at its edge, pick an arbitrary point between the line starts.
      -- 
      points(5) := Find_Intersection( lines(1), lines(2));
      if( points(5).x <= start_pos ) or ( points(5).x >= end_pos ) then
         anchor := start_pos + ( end_pos - start_pos ) / 2.0;
      else
         anchor := points(5).x;
      end if;
      depth := depth + 1;
      --
      -- recursively explore to the left of our new anchor point
      --
      Generate( points_l, controls, depth, start_pos, anchor );
      --
      -- .. then to the right.
      --
      Generate( points_l, controls, depth, anchor, end_pos );
      depth := depth - 1;
   end Generate;

   function Generate( 
      controls   : Control_Record;
      start_pos  : Rate; 
      end_pos    : Rate ) return Points_List is
   points : Points_List; 
   depth  : integer := 0;
   begin
      Generate( points, controls, depth, start_pos, end_pos );
      Censor( points );
      Round( points );
      return points;
   end Generate;
     
   procedure Inspect( points : Points_List; dets_list : in out Details_List; controls : Control_Record ) is

      procedure inspect_one( pos : Points_Package.Cursor ) is
         p : point :=  Points_Package.element( pos );
         d : Details; 
      begin
         d := Run_Inspector( p.x, p.y, controls );
         Details_Package.Append( dets_list, d ); 
      end inspect_one;
      
   begin      
      Points_Package.Iterate( points, inspect_one'Access );
   end Inspect;
   
end Piecewise_Linear_Generator;

