with Ada.Text_IO;

with AWS.Default;
with AWS.Server;
with AWS.Services.Dispatchers.URI;
with AWS.Services.Page_Server;
with AWS.Config; use AWS.Config;
with AWS.Config.Set; use AWS.Config.Set;
with test_callback;
with AWS.Log;

with AWS.Services; use AWS.Services;

procedure AWS_Tests is
        MY_PORT       : constant := 9099;
        my_server     : AWS.Server.HTTP;
        my_dispatcher : AWS.Services.Dispatchers.URI.Handler;
        my_config     : AWS.Config.Object := AWS.Config.Get_Current;
        SERVER_ROOT   : constant String :=  "/home/graham_s/VirtualWorlds/projects/tax_benefit_model_components/tests/resources/";

begin
        aws.log.start ( log=>la_log.logger, split=>aws.log.each_run, filename_prefix=>"la_logger" );

        Ada.Text_IO.Put_Line
               ("Call me on port" &
                Positive'Image ( MY_PORT ) &
                "press q to stop me ...");

        AWS.Config.Set.Server_Port( my_config, 9090 );
        AWS.Config.Set.WWW_Root ( my_config, SERVER_ROOT );
        AWS.Config.Set.Max_Connection ( my_config, 10 );
        AWS.Config.Set.Session ( my_config, true );
        Dispatchers.URI.Register_Regexp ( my_dispatcher, "/css/.*|/js/.*|/images/.*|/.*\.html",
                                         AWS.Services.Page_Server.callback'Access );
        Dispatchers.URI.Register ( my_dispatcher, "/actions/",  legal_aid_callback.input_callback'Access );

        AWS.Server.Start( my_server,
           Dispatcher => my_dispatcher,
           Config => my_config );
--                Max_Connection => 10,
--                Port           => MY_PORT,
--                Session        => true

        AWS.Server.Wait( AWS.Server.forever ); -- (AWS.Server.Q_Key_Pressed);

        AWS.Server.Shutdown (my_server);
end AWS_Tests;
