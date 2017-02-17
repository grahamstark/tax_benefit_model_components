//
// copyright(c) 2017 Graham Stark/ Virtual Worlds (graham.stark@virtual-worlds.biz)
//
// ////////////////////////////////
//
// This is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 3, or (at your option)
// any later version.
// 
// It is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this software; see the file docs/gpl_v3.  If not, write to
// the Free Software Foundation, Inc., 51 Franklin Street,
// Boston, MA 02110-1301, USA.
// 
//
// Implementation of a Piecewise-Linear function generator. See Stark and Duncan 2001.
//
//
// NOTE: on Linux, compile with:
// mono-csc tests.cs piecewise_linear_generator.cs -out:../../bin/monotest
//
using System;
using System.Collections;
using System.Collections.Generic;

namespace PiecewiseLinearGenerator{

        //
        // just implemment this interface
        //
        public interface NetIncome{
                
                double GetNet( double gross );
                
        }
        
        // copied from: https://msdn.microsoft.com/en-us/library/87cdya3t(v=vs.110).aspx
        public class GeneratorException: Exception{
            public GeneratorException(){
            }
        
            public GeneratorException(string message)
                : base(message)
            {
            }
        
            public GeneratorException(string message, Exception inner)
                : base(message, inner)
            {
            }
        }
        
        
        // note there is a point class in Drawing .. 
        public struct Point{
                public double X {get;set;}
                public double Y {get;set;}
        }
        
        public struct Line{
                public double A {get;set;}
                public double B {get;set;}
        }
        
        
        
        public class Generator{
                
                //
                // fixme maybe make thes settable and nothing static .. 
                //
                const double VERTICAL   = 9999999999.9999;
                const double TOLERANCE  = 0.0001;
                const double INCREMENT  = 0.0001;
                const int MAX_DEPTH     = 500;
                const double MAX_INCOME = 20000.0;
                const double MIN_INCOME = 0.0;
                
                private static Line MakeLine( Point point_1, Point point_2 ){ 
                        Line l;
                        if( point_1.X == point_2.X ){
                                 l.B = point_1.X;
                                 l.A = VERTICAL;
                                 return l;
                        };
                        l.B = (point_1.Y - point_2.Y)/(point_1.X - point_2.X );
                        if( l.B < 0.0 ){
                                l.B = l.B * (-1.0);
                        };
                        l.B = Math.Min( l.B, VERTICAL );
                        if( l.B < 0.0 ){
                                l.B = l.B * (-1.0);
                        }
                        l.A = ( point_1.Y - point_1.X*l.B );                
                        return l;
                }
                
                private static Point FindIntersection( Line line_1, Line line_2 ){
                        Point p;
                        if( line_1.B != line_2.B ){
                                p.X = (line_2.A - line_1.A) / (line_1.B - line_2.B);
                                p.Y = line_1.A + (p.X * line_1.B );
                        } else {
                                 p.X = 0.0;
                                 p.Y = line_1.A;
                        }
                        return p;
                }
                
                private static int ComparePoints( Point point_1, Point point_2 ){
                        if( point_1.X > point_2.X ){
                                return 1;       
                        }
                        if( point_1.X < point_2.X ){
                                return -1;       
                        }
                        if( point_1.Y > point_2.Y ){
                                return 1;               
                        }
                        if( point_1.Y < point_2.Y ){
                                return -1;               
                        }
                        return 0;
                }
                
                private static bool NearlySameLine( Line l1, Line l2 ){
                        return ((( Math.Abs(l1.A-l2.A)) <= TOLERANCE ) && (( Math.Abs (l1.B-l2.B)) <= TOLERANCE ));
                }
        
                // FIXME parameterise this tolerance seperately
                private static bool NearlySamePoint( Point p1, Point p2 ){
                        return ((( Math.Abs(p1.X-p2.X)) < TOLERANCE*10 ) && (( Math.Abs (p1.Y-p2.Y)) < TOLERANCE*10 ));
                }
                
                private static double Trunc( double x ){
                        x *= 100.0;
                        return ((double) Math.Truncate( x )/100.0);
                }
                
                private static void Round( ref List<Point> points ){
                        int n = points.Count;
                        for( int i = 0; i < n; i++ ){
                                Point p = points[i];
                                p.X = Trunc( p.X );                        
                                p.Y = Trunc( p.Y );
                                points[i] = p;
                        }
                }
                
                private static void Censor( ref List<Point> points ){
                        points.Sort( ComparePoints );
                        int n = points.Count;
                        if( n < 3 ){
                                return;       
                        }
                        int i = 1;
                        Line[] l = new Line[2];
                        Point[] p = new Point[3];
                        while( i < n-1 ){
                                p[0] = points[i-1]; 
                                p[1] = points[i]; 
                                p[2] = points[i+1];
                                l[0] = MakeLine( p[0], p[1] );
                                l[1] = MakeLine( p[1], p[2] );
                                if( NearlySameLine( l[0], l[1] )){
                                        points.RemoveAt( i );
                                        n = points.Count;
                                } else {
                                        i++;       
                                }
                        }
                        i = 0;
                        while( i < n-1 ){
                                if( NearlySamePoint( points[i], points[i+1] )){
                                        points.RemoveAt( i );
                                        n = points.Count;
                                }
                                i++;       
                        }
                }
                
                public static void Generate(
                        NetIncome calculator,
                        ref List<Point> pointsList,
                        ref int depth,
                        double startPos,
                        double endtPos ){
                        if( Math.Abs( startPos - endtPos ) < TOLERANCE ){
                                return;        
                        }
                        if( depth > MAX_DEPTH ){
                                throw new GeneratorException( "Max Depth Exceeded" );                               
                        }
                        double anchor;
                        Point[] points = new Point[5];
                        Line[] lines = new Line[2];
                        //
                        // left line in points 1,2 
                        //
                        points[0].X = startPos;
                        points[0].Y = calculator.GetNet( points[0].X );
                        points[1].X = startPos + INCREMENT;
                        points[1].Y = calculator.GetNet( points[1].X );
                        //
                        // right line in 3,4
                        //
                        points[3].X = endtPos;
                        points[3].Y = calculator.GetNet( points[3].X );
                        points[2].X = endtPos - INCREMENT;
                        points[2].Y = calculator.GetNet( points[2].X );
                        
                        lines[0] = MakeLine( points[0], points[1] );
                        lines[1] = MakeLine( points[2], points[3] );
                        if( NearlySameLine( lines[0], lines[1] )){
                                //
                                // Same line, so the section we're testing represents a single straight segment.
                                // We're done exploring this bit; store the line endpoints and return,
                                //
                                if( ! pointsList.Contains( points[0] )){
                                        pointsList.Add( points[0] );
                                }
                                if( ! pointsList.Contains( points[3] )){
                                        pointsList.Add( points[3] );
                                }
                                return;
                        }
                        //
                        // If we're not done here, find where the lines meet and explore each side of there. 
                        // If the meeting point is out range of the current section being tested, or exactly
                        // at its edge, pick an arbitrary point between the line starts.
                        //
                        points[4] = FindIntersection( lines[0], lines[1] );
                        if(( points[4].X <= startPos ) || ( points[4].X >= endtPos )){
                                anchor = startPos + ( endtPos - startPos ) / 2.0;
                        } else {
                                anchor = points[4].X;
                        }
                        depth += 1;
                        //
                        // recursively explore to the left of our new anchor point
                        //
                        Generate( calculator, ref pointsList, ref depth, startPos, anchor );
                        //
                        // .. then to the right.
                        //
                        Generate( calculator, ref pointsList, ref depth, anchor, endtPos );
                        depth -= 1;                
                }
        
                
                public static List<Point> Generate( NetIncome calculator ){
                        List<Point> points = new List<Point>();
                        int depth = 0;
                        Generate( calculator, ref points, ref depth, MIN_INCOME, MAX_INCOME );
                        Censor( ref points );
                        // make this optional
                        Round( ref points );                        
                        return points;
                }
                
        }
}
