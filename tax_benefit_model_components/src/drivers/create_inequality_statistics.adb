with Ada.Text_IO;
with Ada.Command_Line;
with Inequality_Generator;
with Inequality_Generator.Utils;

procedure Create_Inequality_Statistics is
   
   package IQ is new Inequality_Generator( Amount=>Long_Float, Rate=>Long_Float );
   package IQ_IO is new IQ.Utils;

use Ada.Text_IO;
use Ada.Command_Line;
   infile : String :=  Ada.Command_Line.Argument( 1 );
   weight_column : Positive := Integer'Value( Ada.Command_Line.Argument( 2 ));
   income_column : Positive := Integer'Value( Ada.Command_Line.Argument( 3 ));
   incomes_pre_weighted : Boolean := Boolean'Value( Ada.Command_Line.Argument( 4 ));
   ql      : IQ.Quantile_List;
   a       : IQ.Inequality_Array;
begin
   ql := IQ_IO.Read_From_File( infile, weight_column, income_column );
   a := IQ.Generate( ql, incomes_pre_weighted );
   Put_Line( IQ.To_String( a ));
end Create_Inequality_Statistics;
