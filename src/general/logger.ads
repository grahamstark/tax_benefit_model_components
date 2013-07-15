--
-- This is Graham's really simple logger. Instead of having error/warn/info/debug (although you could use it like that),
-- this is indended to log sections of code. So, use something like:
-- 
--      type Log_Test is ( t1, t2, t3 );
--      package t_log is new Logger( Target_Type=> Log_Test );
--   begin
--      t_log.Add_Target( t2 );
--      t_log.Log( t2, "This should be 1st log message " );
--      t_log.Remove_Target( t2 );
--      t_log.Log( t2, "this should not appear  #2" );
-- 
-- 
-- Logs to standard output until Set_Output is called with a non zero length name, after which it writes to that file. File is deleted
-- on open. None of the usual file rotation things are there, and it's probably not thread safe, but I don't care for now.
--      ...
--  messages look like:        
--  T1: 2008-04-10 14:25:21 : This should be 1st log message in my_log_file
--
--  svn info:
--  $Author: graham_s $
--  $Date: 2010-12-09 17:14:41 +0000 (Thu, 09 Dec 2010) $
--  $Revision: 10286 $
--
pragma License( Modified_GPL );

generic
   
   type Target_Type is (<>);
   
package Logger is

   --
   -- write a message like: T1: 2008-04-10 14:25:21 : This should be 1st log message in my_log_file
   --
   subtype TRange is Target_Type range Target_Type'First .. Target_Type'Last;
   procedure Log( which : Target_Type; s : String );
   procedure Add_Target( which : Target_Type );
   procedure Add_All_Targets;
   
   procedure Remove_Target( which : Target_Type );
   procedure Clear_All_Targets;
   --
   -- Writes to the file with the given name if string length is > 0
   -- call with "" to write to std_output.
   --
   procedure Set_Output( name : String );
   --
   -- Close current output file.
   --
   procedure Flush;
        
end Logger;
