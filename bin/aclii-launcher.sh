#!/bin/bash
set -euo pipefail

_aclii_debug () {
  if [ -n "${ACLII_DEBUG+HAS_VALUE}" ]; then
    echo "$@" >> /tmp/aclii-debug.log
  fi
}

_aclii_exec () {
  binname=$(dirname $0)/$(basename $0)"-main"
  exec "$binname" $(echo "$1" | base64)
}

args='{"options":{}}'

_aclii_debug "Launch aclii..."
_aclii_debug "ARGV $@"
_aclii_debug "$ 0 $0"

_help () {
  local page
  if [ -n "${1+HAS_VALUE}" ]; then
    page="$1"
  else
    page="aclii"
  fi
  case "$page" in
  
    "aclii") cat << EOS
Name: aclii
  A toolkit for aclii (Abstract Command Line Interface Interface)


Commands:

  render | Render bash scripts generated from yaml config file. See sub commands for details.


  test | test something...


  build | 


Options:

  --verbose | 

  --file | 

EOS
    ;;
  
    "aclii.render") cat << EOS
Name: aclii.render
  Render bash scripts generated from yaml config file. See sub commands for details.


Commands:

  completion | Render and print bash auto-completion script to STDOUT.


  launcher | Render and print bash script to launch other program to STDOUT.



Options:

EOS
    ;;
  
    "aclii.render.completion") cat << EOS
Name: aclii.render.completion
  Render and print bash auto-completion script to STDOUT.


Commands:


Options:

  --file | Specify yaml file

EOS
    ;;
  
    "aclii.render.launcher") cat << EOS
Name: aclii.render.launcher
  Render and print bash script to launch other program to STDOUT.


Commands:


Options:

  --file | Specify yaml file

EOS
    ;;
  
    "aclii.test") cat << EOS
Name: aclii.test
  test something...


Commands:

  it | test it. what is it?



Options:

  --all | test all

  --file | test file

  --dir | 

EOS
    ;;
  
    "aclii.test.it") cat << EOS
Name: aclii.test.it
  test it. what is it?


Commands:


Options:

EOS
    ;;
  
    "aclii.build") cat << EOS
Name: aclii.build
  

Commands:


Options:

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
          args=$(echo $args | jq '.options["file"] = true')
          want="file"
          wanting="file"
          ;;
      
        "aclii.render.launcher--file" )
          args=$(echo $args | jq '.options["file"] = true')
          want="file"
          wanting="file"
          ;;
      
        "aclii.test--all" )
          args=$(echo $args | jq '.options["all"] = true')
          want=""
          wanting="all"
          ;;
      
        "aclii.test--file" )
          args=$(echo $args | jq '.options["file"] = true')
          want=""
          wanting="file"
          ;;
      
        "aclii.test--dir" )
          args=$(echo $args | jq '.options["dir"] = true')
          want="dir"
          wanting="dir"
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
      
        * ) echo "Unknown Command: $word"
            echo
            _help $cmd
      esac
    fi

  done

  args=$(echo "$args" | jq --arg com "$cmd" '.command = $com')
  _aclii_debug "Parse done---------"

  # Now we got the command which to be executed.
  # Handle it as it wants
  case "$cmd" in
  
    "aclii" )
    
      _help "$cmd"
    
      ;;
  
    "aclii.render" )
    
      _help "$cmd"
    
      ;;
  
    "aclii.render.completion" )
    
      _aclii_exec "$args"
    
      ;;
  
    "aclii.render.launcher" )
    
      _aclii_exec "$args"
    
      ;;
  
    "aclii.test" )
    
      _aclii_exec "$args"
    
      ;;
  
    "aclii.test.it" )
    
      _aclii_exec "$args"
    
      ;;
  
    "aclii.build" )
    
      _aclii_exec "$args"
    
      ;;
  
    * )
      echo "Unknown command";
      _help;
  esac
}

__parse_args "$@"



