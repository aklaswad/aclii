source $(dirname "$0")/util.sh
load_parser 'base'

__arg_parse "--string1" "foo"
eq "get opt1 in string" "$(_q 'string1')" 'foo'

__arg_parse "--switch1" "--string1" "bar"
eq "get switch1 in switch style" "$(_q 'switch1')" '1'
eq "string1 just after switch can get value" "$(_q 'string1')" 'bar'

#ok "can parse multi" $([ __arg_parse "--multi1" "foo" "--multi1" "bar" ])


done_testing
