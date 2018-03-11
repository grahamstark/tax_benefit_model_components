generic
  type T is (<>);
package Safe_Conversions is
  
  function Is_Valid( s : String ) return Boolean;
  function Convert( s : String; default : T := T'First ) return T;
  function Valid_Values( delim : String := ", " )  return String;
  
end Safe_Conversions;
   

