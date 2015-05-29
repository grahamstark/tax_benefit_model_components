with T_Utils;
with Base_Model_Types;

package Standard_Parameter_Enums is

   use Base_Model_Types;

   type High_Middle_Low_Nil_Type is ( high, middle, low, nil );
   subtype High_Middle_Low_Type is High_Middle_Low_Nil_Type range high .. low;
   
   type Means_Test_Type is (
      guaranteed_pension_credit,
      savings_credit,
      savings_credit_qualifying_income );
   
   package High_Middle_Low_Package is new T_Utils(  
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => High_Middle_Low_Nil_Type );
      
   subtype High_Middle_Low_Array is High_Middle_Low_Package.Amount_Array;  
   
   type High_Low_Nil_Type is ( high, low, nil );

   subtype High_Low_Type is High_Low_Nil_Type range high .. low;

   package High_Low_Package is new T_Utils(  
      Rate_Type    => Rate, 
      Amount_Type  => Amount, 
      Counter_Type => Counter_Type, 
      T            => High_Low_Nil_Type );
      
   subtype High_Low_Array is High_Low_Package.Amount_Array;  
   
end Standard_Parameter_Enums;