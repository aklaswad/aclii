#!/bin/bash
si=$IFS
IFS=$'\n'
shopt -s expand_aliases
__TAP_IGNORE=""
_tests=0
_failed=0

q() {
  _q "$@" || true
}

load_parser () {
  IFS=$si
  fn="$1"
  local SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
  local JSON=$(printf '{"command":"aclii.render.parser","options":{"file":"%s/%s.yml"}}' "$SCRIPTPATH" "$fn")
  local BASE64=$(echo "$JSON" | base64)
  #echo "json $JSON"
  #echo "b64 $BASE64"
  IFS=''
  local PARSER=$(npm exec "$SCRIPTPATH/../../bin/cli.js" "$BASE64")
  tmp=$(mktemp)
  #echo "$PARSER" > "rendered-parser.sh"
  echo "$PARSER" > $tmp
  source $tmp
  IFS=$'\n'
}

_tap () {
  local testnumber
  args=("$@")
  if [ -n "${__TAP_IGNORE}" ]; then
    testnumber="${__TAP_IGNORE}"
  else
    : $((_tests++))
    testnumber="$_tests"
  fi
  if [ "${args[1]}" = "0" ]; then
    echo "ok $testnumber - ${args[0]}"
  else
    IFS=$si
    origin=($(caller "1"))
    IFS=$'\n'
    echo "not ok $testnumber - ${args[0]}"
    echo "#   Failed test '${args[0]}'"
    echo "#   at ${origin[2]} line ${origin[0]}."
    IFS=$si
    for line in "${args[@]:2}"
    do
      echo "$line" | sed 's/^/# /g'
    done
    IFS=$'\n'
    if [ -z "$__TAP_IGNORE" ]; then
      : $((_failed++))
    fi
  fi
}

bailout () {
  echo "Bail out!"
  exit 1
}

truthy () {
  msg="$1"
  shift
  si="$IFS"
  IFS=' '
  cmd="$*"
  if [ $cmd ] ; then
    IFS="$si"
    _tap $msg 0
  else
    IFS="$si"
    note "got $?"
    _tap $msg 1 "\"${cmd}\" is not truthy"
  fi
}

must_truthy () {
  msg="$1"
  shift
  si="$IFS"
  IFS=' '
  cmd="$*"
  if [ $cmd ] ; then
    IFS="$si"
    _tap $msg 0
  else
    IFS="$si"
    note "got $?"
    _tap $msg 1 "\"${cmd}\" is not truthy"
    bailout $msg
  fi
}

falsy () {
  msg="$1"
  shift
  si="$IFS"
  IFS=' '
  cmd="$*"
  if [ $cmd ] ; then
    IFS="$si"
    _tap $msg 1 "\"${cmd}\" it not falsy"
  else
    IFS="$si"
    _tap $msg 0
  fi
}

# Usage: ok 'error name' $([ $test = $command ])
# or
# $([ test = $command ])
#   should_success "this must be ok"
should_success () {
  local lastExit="$?"
  _tap "$1" "$lastExit" "expect truthy but got failed status $lastExit"
}

alias ok='should_success'

must_success () {
  local lastExit="$?"
  if [ "$lastExit" != "0" ]; then
    echo "Bail out! Failed at test $1"
    exit 1
  fi
  _tap "$1" "$lastExit" "expect truthy but got failed status $lastExit"
}

should_fail () {
  local lastExit="$?"
  local isFailed="0"
  if [ "$lastExit" = "0" ]; then
    isFailed="1"
  fi
  _tap "$1" "$isFailed" "expect false but got success status $lastExit"
}

should_equal () {
  local args=("$@")
  [ "${args[1]}" = "${args[2]}" ]
  local test=$?
  _tap ${args[0]} $test $(printf "expect [%s] but got [%s]" "${args[2]}" "${args[1]}")
}

alias eq='should_equal'

should_not_equal () {
  args=("$@")
  [ "${args[1]}" != "${args[2]}" ]
  local test=$?
  _tap ${args[0]} $test "expect [$3] but got [$2]"
}

alias ne='should_not_equal'

like () {
  local args=("$@")
  local name="${args[0]}"
  local got="${args[1]}"
  local expected="${args[2]}"
  $( echo "$got" | grep "$expected" > /dev/null 2>&1 )
  local test=$?
  _tap $name $test $(printf "value [%s] doesn't match to expected regex [%s]" "$got" "$expected")
}

note () {
  while [ $# -gt 0 ] ; do
    echo "$1" | sed 's/^/# /g'
    shift
  done
}

done_testing () {
  if [ $_failed -ne 0 ]; then
    echo "# failed $_failed sub tests"
    _tests=0
    _failed=0
  elif [ $_tests -eq 0 ]; then
    echo "# no tests"
    _tests=0
    _failed=0
  fi
  echo "1..${_tests}"
  _tests=0
  _failed=0
}

