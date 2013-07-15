with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
package RW_File is

   procedure Read_File (Filename : String;
                        Content : out Unbounded_String);

   procedure Write_File (Filename : String;
                         Content : Unbounded_String);

   procedure Process_Lines (S : Unbounded_String;
                            Process_Line : access procedure (Line : String));

end RW_File;
