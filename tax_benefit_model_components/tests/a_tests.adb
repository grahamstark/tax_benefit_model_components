with Ada.Text_IO;

procedure A_Tests is
   
   type AA is array (Natural range <>) of Character;
   
   procedure FA is
   begin
      null;
   end FA;
      
   procedure FA( a : AA ) is
      use Ada.Text_IO;
   begin
      for i in a'range loop
         Put( a(i));
      end loop;
   end FA;
   -- weird but true ..  zero-length array
   ZLA : constant AA := ( Natural'First .. Natural'First-1 => 'a' );
begin
   
   FA(( 'a', 'b' ));
   FA(( 'x', 'y', 'z' ));
   FA(( 1=>'1' ));
   FA( ZLA );
   FA;
   
end A_Tests;
