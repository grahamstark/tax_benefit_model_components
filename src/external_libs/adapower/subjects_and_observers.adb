--
-- by Matthew Heaney
-- http://www.adapower.com/index.php?Command=Class&ClassID=Patterns&CID=273
-- 
package body Subjects_And_Observers is

   procedure Notify (Subject : in out Root_Subject_Type'Class) is
      Observer : Observer_Access := Subject.Head;
   begin
      while Observer /= null loop
         Update (Observer);
         Observer := Observer.Next;
      end loop;
   end Notify;


   procedure Initialize (Control : in out Observer_Control) is

      Observer : constant Observer_Access :=
        Control.Observer.all'Unchecked_Access;

      Subject : Root_Subject_Type'Class renames
        Observer.Subject.all;

   begin
      Observer.Next := Subject.Head;
      Subject.Head := Observer;
   end;


   procedure Finalize (Control : in out Observer_Control) is

      Observer : constant Observer_Access :=
        Control.Observer.all'Unchecked_Access;

      Subject : Root_Subject_Type'Class renames
        Observer.Subject.all;

      Prev  : Observer_Access;
      Index : Observer_Access;
   begin
      if Subject.Head = Observer then
         Subject.Head := Subject.Head.Next;
      else
         Prev := Subject.Head;
         Index := Subject.Head.Next;

         while Index /= Observer loop
            Prev := Index;
            Index := Index.Next;
         end loop;

         Prev.Next := Index.Next;
      end if;
   end Finalize;


end Subjects_And_Observers;
