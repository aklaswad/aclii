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

__arg_parse cmdD foo
  should_success "cmdD can take arg"
eq "it's foo" $(_q cmdDarg) "foo"

__arg_parse cmdD --cmdDopt bar
  should_success "cmdD can also take option"
eq "it's foo" $(_q cmdDopt) "bar"

__arg_parse cmdD --cmdDopt fizz buzz
  should_success "cmdD can take both option and arg"
eq "arg is buzz" $(_q cmdDarg) "buzz"
eq "opt is fizz" $(_q cmdDopt) "fizz"

__arg_parse cmdD hey --cmdDopt ho
  should_success " (?) can put option after arg if arg is not many type"
eq "got opt val" "$(_q cmdDopt)" "ho"
eq "got opt val" "$(_q cmdDarg)" "hey"

__arg_parse cmdD --cmdDopt
  should_success "Also, this should fail since option value is missing"
eq "got empty opt val" "$(_q cmdDopt)" ""

__arg_parse cmdD -- --cmdDopt
  should_success "option terminator works"
eq "arg can take string looks like option" $(_q cmdDarg) "--cmdDopt"

done_testing
