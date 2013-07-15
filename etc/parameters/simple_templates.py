HTML_TEMPLATE = \
'<tr class=\"#{clazz}\"><td align=\"right\" >#{title}</td><td>@_#{key}_@</td></tr>\n';

EXISTS_TEMPLATE = \
'                exists := Exist(params, \"#{key}\");\n';

DIFFERENCES_TEMPLATE = \
"                if (print_all or ( #{defaultVarname} /= #{varname} )) then\n \
                        pre_values := pre_values &  #{defaultVarname}\'Img;\n \
                        post_values := post_values & #{varname}\'Img;\n \
                        titles := titles & \"#{title}\";\n \
                 end if;\n\n";                        

INSERT_TEMPLATE = \
'                tablePos         := tablePos + 1;\
                trans( tablePos ) := \n\
                        Templates_Parser.Assoc\n\
                                (\"#{key}\",\n\
                                 To_String (Output_Str));\n';
BOOLEAN_TEMPLATE = \
'	        html_utils.makeOneInput\n\
                       (varname      => \"#{key}\",\n\
                        Output_Str    => Output_Str,\n\
                        value        => #{varname},\n\
                        Default_Value => #{defaultVarname},\n\
                        option_names => #{labels},\n\
                        help         => \"#{help}\",\n\
                        Param_String  => Get_String( params, \"#{key}\" ),\n\
                        Param_Is_Set   => exists\n\
                        );\n';

MONEY_TEMPLATE = \
'                html_utils.Make_One_Input\n\
                       (varname       => \"$instance_name\",\n\
                        Output_Str    => Output_Str,\n\
                        value         => $qualified_varname,\n\
                        Default_Value => $default_value,\n\
                        help          => \"$description\",\n\
                        Param_String  => Get_String( params, \"$instance_name\" ),\n\
                        Param_Is_Set  => exists,\n\
                        min => $min,\n\
                        max => $max,\n\
                        is_error => is_in_error );\n\
                has_errors := has_errors or is_in_error;\n';

