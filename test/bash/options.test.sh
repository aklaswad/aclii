source $(dirname "$0")/util.sh
load_parser 'base'

__arg_parse "--string1" "foo"
eq "get opt1 in string" "$(_q 'string1')" 'foo'

__arg_parse "--switch1" "--string1" "bar"
eq "get switch1 in switch style" "$(_q 'switch1')" '1'
eq "string1 just after switch can get value" "$(_q 'string1')" 'bar'

__arg_parse --string1 foo --string1 bar
  should_fail "normal option can't use multiple times"

__arg_parse --multi1 foo --multi1 bar
  should_success "option with multi can use multiple times"

eq "can get value from first option" \
  "$(_q --pos 0 multi1)" "foo"

eq "can get value from second option" \
  "$(_q --pos 1 multi1)" "bar"



done_testing
