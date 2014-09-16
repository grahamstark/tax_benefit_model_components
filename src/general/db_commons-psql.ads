--
-- Created by ada_generator.py on 2014-09-16 15:28:40.011209
-- 
with GNATCOLL.SQL.Exec;
with Ada.Strings.Unbounded;

-- === CUSTOM IMPORTS START ===
-- === CUSTOM IMPORTS END ===

package DB_Commons.PSQL is

   use Ada.Strings.Unbounded;
  
   package dexec renames GNATCOLL.SQL.Exec; 
     
   -- === CUSTOM TYPES START ===
   -- === CUSTOM TYPES END ===
   
   procedure Execute_Script( connection : dexec.Database_Connection; script : String );
   procedure Check_Result( conn : dexec.Database_Connection );
   
   generic 
      type Some_Discrete_Type is (<>);
   function Make_SQL_Parameter_Discrete( t : Some_Discrete_Type ) return dexec.SQL_Parameter;
      
   generic
      type Some_Floating_Type is digits <>;
   function Make_SQL_Parameter_Float( f : Some_Floating_Type ) return dexec.SQL_Parameter;
      
   function "+" ( s : Unbounded_String ) return dexec.SQL_Parameter;
   
   -- === CUSTOM PROCS START ===
   -- === CUSTOM PROCS END ===
   
end DB_Commons.PSQL;
