with Ada.Text_IO;
with Ada.Containers;
with Text_Utils;
with Line_Extractor;

package body Model.Charging.IO is

   use Ada.Text_IO;
   use UK_Key_Value_IO;
   use Text_Utils;
   use Line_Extractor;
   
   function Equals( charge1, charge2 : Charges_Type ) return Boolean is
   begin
      if( charge1.name /= charge2.name ) then return False; end if;
      if( charge1.charge_amount /= charge2.charge_amount ) then return False; end if;
      if( charge1.discount /= charge2.discount ) then return False; end if;
      if( charge1.period /= charge2.period ) then return False; end if;
      if( charge1.frequency /= charge2.frequency ) then return False; end if;
      if( charge1.interest_rate /= charge2.interest_rate ) then return False; end if;
      if( charge1.join /= charge2.join ) then return False; end if;
      return True;
   end Equals;
   
   
   procedure Write( 
      file :  File_Type; 
      charge : Charges_Type;
      prefix : Unbounded_String;
      charge_num : Positive ) is
      key : constant Unbounded_String := prefix & Make_Key( "charge", charge_num, "" );
   begin
      Write( file, key & "name", charge.name );
      Write( file, key & "charge_amount", charge.charge_amount );
      Write( file, key & "discount", charge.discount );
      Write( file, key & "period", Periods'Image( charge.period ));
      Write( file, key & "frequency", Rate'Image( charge.frequency ));
      Write( file, key & "interest_rate", charge.interest_rate );
      Write( file, key & "join", Join_Type'Image( charge.join ));
   end Write;
   
   function Read( 
      file :  File_Type;
      prefix : Unbounded_String;
      charge_num : Positive ) return Charges_Type is
      charge : Charges_Type;
      key : constant Unbounded_String := prefix  & Make_Key( "charge", charge_num, "" );
   begin
      charge.name := Read( file, key & "name" );
      charge.charge_amount := Read( file, key & "charge_amount" );
      charge.discount := Read( file, key & "discount" );
      charge.period := Periods'Value( Read( file, key & "period"));
      charge.frequency := Rate'Value( Read( file, key & "frequency"));
      charge.interest_rate := Read( file, key & "interest_rate" );
      charge.join := Join_Type'Value( Read( file, key & "join"));
      return charge;
   end Read;
   
   
   
   
   procedure Write( file :  File_Type; target : Target_Type; prefix : Unbounded_String; target_num : Positive ) is
     key : constant Unbounded_String := prefix & Make_Key( "target", target_num, "" );
   begin
      Write( file, key & "name", To_String( target.name ));
      Write( file, key & "min_age", target.min_age );
      Write( file, key & "max_age", target.max_age );
      Write( file, key & "genders", Gender_Package.To_String( target.genders ));
      Write( file, key & "benefits", Broad_Benefits_Package.To_String( target.benefits ));
      Write( file, key & "employment", Employment_Package.To_String( target.employment ));
      Write( file, key & "max_charges", target.max_charges );
      Write( file, key & "num_charges", Natural( Charges_Package.Length( target.charges ) ));
      for i in 1 .. Charges_Package.Length( target.charges ) loop
         Write( file, Charges_Package.Element( target.charges, Natural(i) ), key, Natural(i) );
      end loop;
      Write( file, key & "is_exclusive", target.isExclusive );
   end Write;
   
   function Read( 
      file : File_Type; 
      prefix : Unbounded_String; 
      target_num : Positive ) return Target_Type is
      
      target : Target_Type;
      s : Unbounded_String;
      num_charges : Natural;
      charge : Charges_Type;
      key : constant Unbounded_String := prefix & Make_Key( "target", target_num, "" );
   begin
      target.name := Read( file, key & "name" );
      target.min_age := Read( file, key & "min_age" );
      target.max_age := Read( file, key & "max_age"  );
      s := Read( file, key & "genders" );
      Gender_Package.From_String( TS(s), target.genders );
      s := Read( file, key & "benefits");
      Broad_Benefits_Package.From_String( TS(s), target.benefits );
      s := Read( file,  key & "employment" ); 
      Employment_Package.From_String(  TS(s), target.employment );
      
      target.max_charges := Read( file, key & "max_charges" );
      
      num_charges := Read( file, key & "num_charges" );
      for i in 1 .. num_charges loop
         charge := Read( file, key, i );
         Charges_Package.Append( target.charges, charge );
      end loop;
      target.isExclusive := Read( file, key & "is_exclusive" );
      return target;
   end Read;
   
   procedure Write( 
      file :  File_Type; 
      application : Application_Type; 
      prefix : Unbounded_String; 
      application_num : Positive ) is
      num_targets : Natural;
      key : constant Unbounded_String := prefix & Make_Key( "application", application_num, "" );  
   begin
      Write( file, key & "name", application.name );
      Write( file, key & "description", application.description );
      Write( file, key & "max_people", application.max_people );
      Write( file, key & "max_children", application.max_children );
      Write( file, key & "max_adults", application.max_adults );
      num_targets := Natural( Target_Package.length( application.targets ));
      Write( file, key & "num_targets", num_targets );
      for i in 1 .. num_targets loop
         Write( file, Target_Package.Element( application.targets, i ), key, i ); 
      end loop;
   end Write;
   
   function Read( 
      file : File_Type;
      prefix : Unbounded_String; 
      application_num : Positive ) return Application_Type is
      application : Application_Type;
      num_targets : Positive;
      target : Target_Type;
      key : constant Unbounded_String := prefix  & Make_Key( "application", application_num, "" );  
  begin
      application.name := Read( file, key & "name" );
      application.description := Read( file, key & "description" );
      application.max_people := Read( file, key & "max_people"  );
      application.max_children := Read( file, key & "max_children" );
      application.max_adults := Read( file, key & "max_adults" );
      num_targets := Read( file, key & "num_targets"  );
      for i in 1 .. num_targets loop
         target := Read( file, key, i );
         Target_Package.append( application.targets, target );
      end loop;
      return application;
   end Read;

   procedure Write( file :  File_Type; regime : Charging_Regime ) is
      key : constant Unbounded_String := TuS("regime.");  
      num_applications : Natural := Natural( Application_Package.length( regime.applications ));
   begin
      Write( file,  key & "name", regime.name );
      Write( file, key & "description", regime.description );
      Write( file, key & "num_applications", num_applications );
      for i in 1 .. num_applications loop
         Write( file, Application_Package.Element( regime.applications, i ), key, i ); 
      end loop;
   end Write;
   
   function Read( file :  File_Type; peek_only : Boolean := false ) return Charging_Regime is
      regime : Charging_Regime;
      application : Application_Type;
      num_applications : Positive;
      key : constant Unbounded_String := TuS("regime.");
   begin
      regime.name := Read( file,  key & "name" );
      regime.description := Read( file, key & "description" );
      if( peek_only ) then
         return regime;
      end if;
      num_applications := Read( file, key & "num_applications" );
      for i in 1 .. num_applications loop
         application := Read( file, key, i );
         Application_Package.append( regime.applications, application );
      end loop;
      return regime;
   end Read;
   

   
end Model.Charging.IO;
