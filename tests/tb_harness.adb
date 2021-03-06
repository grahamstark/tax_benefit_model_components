with TB_Suite;
with AUnit.Run;
with AUnit.Reporter.Text;

procedure TB_Harness is

   procedure Run is new AUnit.Run.Test_Runner( TB_Suite );
   reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Run( reporter );
end TB_Harness;
