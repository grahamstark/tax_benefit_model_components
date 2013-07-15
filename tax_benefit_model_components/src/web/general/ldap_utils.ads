with AWS.LDAP.Client;

package LDAP_Utils is

   package ldap renames AWS.LDAP.Client;
   
   procedure Set_Option( dir : in out ldap.Directory; option : Integer; value : Boolean );
   procedure Set_Option( dir : in out ldap.Directory; option : Integer; value : Integer );
   function Get_Option( dir : ldap.Directory; option : Integer ) return Boolean;
   function Get_Option( dir : ldap.Directory; option : Integer ) return Integer;
   
end LDAP_Utils;
