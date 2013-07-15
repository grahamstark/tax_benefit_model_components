--
--  $Author: graham_s $
--  $Date: 2008-12-22 19:48:15 +0000 (Mon, 22 Dec 2008) $
--  $Revision: 6555 $
--
--
pragma License( Modified_GPL );

with Model.Incomes;

package body Model.Parameters.Complete is

   
   
   procedure Uprate( params : in out Parameters; m : Rate ) is
   begin
      params.legal_aid := Uprate( params.legal_aid, m );
      Uprate( params.means_tested, m );
      Uprate( params.non_means_tested, m );
   end Uprate;
   
   procedure To_Annual( params : in out Parameters ) is
   begin
      -- FIXME: no such method and would need annual/weekly check 
      -- Legal Aid params.legal_aid := Uprate( params.legal_aid, m );
      To_Annual( params.means_tested );
      To_Annual( params.non_means_tested );
   end To_Annual;
   
   procedure To_Weekly( params : in out Parameters ) is
   begin
      To_Weekly( params.means_tested );
      To_Weekly( params.non_means_tested );
   end To_Weekly;
   
   
   function Get_2007_8_System return Parameters is
      params : Parameters;
      use Model.Incomes;
   begin
      params.legal_aid := Model.Parameters.Legal_Aid.Get_Default_System; -- FIXME Get_2007_8_System;
      params.means_tested := Model.Parameters.Means_Tested_Benefits.Get_2007_8_System;
      params.non_means_tested := Model.Parameters.Non_Means_Tested_Benefits.Get_2007_8_System;
      return params;
   end Get_2007_8_System;
   

end Model.Parameters.Complete;
