binname /Users/akira/dev/aclii/build/node_modules/.bin/aclii-main
#!/bin/bash
set -euo pipefail

_aclii_debug () {
  if [ -n "$ACLII_DEBUG" ]; then
    echo "$@" >> /tmp/aclii-debug.log
  fi
}

args='{"options":{}}'

_aclii_debug "Launch aclii..."
_aclii_debug "ARGV $@"
_aclii_debug "$ 0 $0"

_help () {
  case "$1" in
  
    "aclii") cat << EOS
aclii  A toolkit for aclii (Abstract Command Line Interface Interface)


Options

  --verbose | 

  --file | 

EOS
    ;;
  
    "aclii.render") cat << EOS
aclii.render  Render bash scripts generated from yaml config file. See sub commands for details.


Options

EOS
    ;;
  
    "aclii.render.completion") cat << EOS
aclii.render.completion  Render and print bash auto-completion script to STDOUT.


Options

  --file | Specify yaml file

EOS
    ;;
  
    "aclii.render.launcher") cat << EOS
aclii.render.launcher  Render and print bash script to launch other program to STDOUT.


Options

  --file | Specify yaml file

EOS
    ;;
  
    "aclii.test") cat << EOS
aclii.test  test something...


Options

  --all | test all

  --file | test file

  --dir | 

EOS
    ;;
  
    "aclii.test.it") cat << EOS
aclii.test.it  test it. what is it?


Options

EOS
    ;;
  
    "aclii.build") cat << EOS
aclii.build  

Options

EOS
    ;;
  
  esac
  exit 0
}

__parse_args () {
  processed=0
  _aclii_debug "enter parse_args |$@|"
  local want
  local wanting
  local cmd="aclii"
  for word in "$@"
  do
    : $((processed++))
    _aclii_debug "Processing $processed th arg |$word|"
    _aclii_debug "   cmd: $cmd  want |$want|"

    # Run the path to know where I am
    if [ -n "$want" ]; then
      #TODO: Do we need to varidate here?

      args=$(echo $args | jq '.options["'"$wanting"'"] = "'"$word"'"')
      wanting=""
      want=""
    elif [ "${word:0:1}" == '-' ]; then
      # It starts with dash.

      # This launcher will handle help command
      if [ `echo "$word" | grep "-help$"` ]; then
        _help $cmd
      fi
      # Check option that if
      # next arg is option valu or not

      comopt="$cmd$word"
      _aclii_debug "adding flag |$comopt|"
      _aclii_debug "Checking option $word : comopt $comopt"
      case "$comopt" in
      
        "aclii.render.completion--file" )
          args=$(echo $args | jq '.options["'"$comopt"'"] = true')
          want="file"
          wanting="$comopt"
          ;;
      
        "aclii.render.launcher--file" )
          args=$(echo $args | jq '.options["'"$comopt"'"] = true')
          want="file"
          wanting="$comopt"
          ;;
      
        "aclii.test--all" )
          args=$(echo $args | jq '.options["'"$comopt"'"] = true')
          want=""
          wanting="$comopt"
          ;;
      
        "aclii.test--file" )
          args=$(echo $args | jq '.options["'"$comopt"'"] = true')
          want=""
          wanting="$comopt"
          ;;
      
        "aclii.test--dir" )
          args=$(echo $args | jq '.options["'"$comopt"'"] = true')
          want="dir"
          wanting="$comopt"
          ;;
      
        * ) echo "Unknown Option $word"
          exit
          ;;
      esac
    else
      case "$cmd.$word" in
      
        "aclii.render" )
          cmd="aclii.render"
          ;;
      
        "aclii.render.completion" )
          cmd="aclii.render.completion"
          ;;
      
        "aclii.render.launcher" )
          cmd="aclii.render.launcher"
          ;;
      
        "aclii.test" )
          cmd="aclii.test"
          ;;
      
        "aclii.test.it" )
          cmd="aclii.test.it"
          ;;
      
        "aclii.build" )
          cmd="aclii.build"
          ;;
      
      esac
    fi

  done
  args=$(echo "$args" | jq --arg com "$cmd" '.command = $com')
  _aclii_debug "Parse done---------"

}
__parse_args "$@"

#XXX: 
binname=$(dirname $0)/$(basename $0)"-main"
echo "binname $binname"
exec "$binname" $(echo "$args" | base64)

