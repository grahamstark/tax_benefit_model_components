with System;
with Interfaces.C.Strings;
with AWS.LDAP.Thin;
with System.Address_To_Access_Conversions;

package body LDAP_Utils is
   
   package ic renames Interfaces.C;
   package thin renames  AWS.LDAP.Thin;

   function ldap_set_option( 
      ld     : thin.LDAP_Type;
      option : ic.int;
      value  : System.Address ) return ic.int;
   pragma Import( C, ldap_set_option );
     
   function ldap_get_option( 
      ld     : thin.LDAP_Type;
      option : ic.int;
      value  : System.Address ) return ic.int;
   pragma Import( C, ldap_get_option );

   package Integer_Pointers is new System.Address_To_Access_Conversions( Integer );
   
   procedure Set_Option( dir : in out ldap.Directory; option : Integer; value : Boolean ) is
      err : ic.Int;
   begin
      err := ldap_set_option( dir, ic.int( option ), value'Address );
   end Set_Option;

   procedure Set_Option( dir : in out ldap.Directory; option : Integer; value : Integer ) is
      err : ic.Int;
   begin
      err := ldap_set_option( dir, ic.int( option ), value'Address );
   end Set_Option;
 
   function Get_Option( dir : ldap.Directory; option : Integer ) return Integer is
      err : ic.Int;
      value : aliased Integer;
      addr  : System.Address := value'Address;
   begin
      err := ldap_get_option( dir, ic.int( option ), addr );
      return value;
   end Get_Option;

   function Get_Option( dir : ldap.Directory; option : Integer ) return Boolean is
      err : ic.Int;
      value : aliased Boolean;
      addr  : System.Address := value'Address;
   begin
      err := ldap_get_option( dir, ic.int( option ), addr );
      return value;
   end Get_Option;
 
   
end LDAP_Utils;
