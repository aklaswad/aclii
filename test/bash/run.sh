#!/bin/bash
IFS=$'\n'
dir=$(dirname $0)
failed=0

if [ ${#@} -ne 0 ]; then
  tests="$@"
else
  tests=( $( find "$dir" -type f -name '*.test.sh' ) )
fi

rnote () {
  echo "${1-''}" | sed 's/^/# (runner): /g' >&2
}

for file in ${tests[@]}; do
  rnote "running file - $file"
  res=$(bash $file ); code=$?
  rnote "done testing $file"
  echo "$res" | sed 's/^/###RET| /g' >&2
  $( echo "$res" | grep '^[1-9][0-9]*\.\.[1-9][0-9]*$' >/dev/null 2>&1 ); ended=$?
  rnote "tap out"
  if [ "$code" != "0" ]; then
    rnote "FAILED $file returns non zero value"
    : $((failed++))
  elif [ "$ended" != "0" ]; then
    rnote "FAILED $file no ending line"
    : $((failed++))
  else
    rnote "SUCCESS $file"
  fi
done

rnote "failed $failed tests"
if [ $failed -gt 0 ]; then
  exit 1
fi
exit 0
