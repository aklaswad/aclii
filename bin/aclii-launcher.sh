#!/bin/bash

# This is auto generated script by aclii 0.0.1

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


_aclii_debug "Launch aclii..."
_aclii_debug "ARGV $@"
_aclii_debug "$ 0 $0"
_help_nodea57b9426b2e192dba7ba8c15edd1cc79 () {
  cat << 'EOH'
  Name: aclii
    A toolkit for aclii (Abstract Command Line Interface Interface)
  
  aclii, a command line interface interface
  
  Commands:
    playground
      | Sub commands of this playgrond do nothing but just echo the command line inputs as parsed JSON, as main program would receive.
    render
      | Render bash scripts generated from yaml config file. See sub commands for details.
  
  Options:
    --file | Specify aclii config file
    --verbose | 
EOH
}
_help_node620dd4ac0e81767466a282a8b830d9a7 () {
  cat << 'EOH'
  Name: aclii.playground
    Sub commands of this playgrond do nothing but just echo the command line inputs as parsed JSON, as main program would receive.
  
  
  Commands:
    hungry <string>...
      | Eat all args into `.argv`. This is default behavior for commands which have no sub commands.
    stuffed
      | Raise error if non optional values ( started by dash(es) ) are related.
    run-ls-script
      | Inline script demo. You can implement any script in aclii file and execute it instead of main program.
  
  Options:
    --file | Specify aclii config file
    --verbose | 
EOH
}
_help_nodec9e9547ec88bba1cbfa64a3699a294ed () {
  cat << 'EOH'
  Name: aclii.playground.hungry
    Eat all args into `.argv`. This is default behavior for commands which have no sub commands.
  
  
  Commands:
  
  Options:
    --file | Specify aclii config file
    --verbose | 
EOH
}
_help_node1f25010818a63d2f7bcb15a33d6fd818 () {
  cat << 'EOH'
  Name: aclii.playground.stuffed
    Raise error if non optional values ( started by dash(es) ) are related.
  
  
  Commands:
  
  Options:
    --file | Specify aclii config file
    --verbose | 
EOH
}
_help_nodee80eb6db780cc1bef550699e63d9e4e7 () {
  cat << 'EOH'
  Name: aclii.playground.run-ls-script
    Inline script demo. You can implement any script in aclii file and execute it instead of main program.
  
  
  Commands:
  
  Options:
    --file | Specify aclii config file
    --verbose | 
EOH
}
_help_node8648f3fded9fa128e5eb8e0814dfbf76 () {
  cat << 'EOH'
  Name: aclii.render
    Render bash scripts generated from yaml config file. See sub commands for details.
  
  Render generated contents to STDOUT.
  You can choose one of sub command from the list.
  
  Commands:
    completion
      | Render and print bash auto-completion script to STDOUT.
    launcher
      | Render and print bash script to launch other program to STDOUT.
    parser
      | Render and print rendered bare commandline parser, for testing.
  
  Options:
    --file | Specify aclii config file
    --verbose | 
EOH
}
_help_node2e76e740f0ac071ad964481e5d054491 () {
  cat << 'EOH'
  Name: aclii.render.completion
    Render and print bash auto-completion script to STDOUT.
  
  
  Commands:
  
  Options:
    --file | Specify aclii config file
    --verbose | 
EOH
}
_help_nodeba4f9c7cf5e0bfa623ddda7827d13c2c () {
  cat << 'EOH'
  Name: aclii.render.launcher
    Render and print bash script to launch other program to STDOUT.
  
  
  Commands:
  
  Options:
    --file | Specify aclii config file
    --verbose | 
EOH
}
_help_nodeae1e4650e2b5e9fafb8ecbd20b398009 () {
  cat << 'EOH'
  Name: aclii.render.parser
    Render and print rendered bare commandline parser, for testing.
  
  
  Commands:
  
  Options:
    --file | Specify aclii config file
    --verbose | 
EOH
}

_help () {
  local page
  if [ -n "${1+HAS_VALUE}" ]; then
    page="$1"
  else
    page="aclii"
  fi
  case "$page" in
    "aclii") _help_nodea57b9426b2e192dba7ba8c15edd1cc79 ;;
    "aclii.playground") _help_node620dd4ac0e81767466a282a8b830d9a7 ;;
    "aclii.playground.hungry") _help_nodec9e9547ec88bba1cbfa64a3699a294ed ;;
    "aclii.playground.stuffed") _help_node1f25010818a63d2f7bcb15a33d6fd818 ;;
    "aclii.playground.run-ls-script") _help_nodee80eb6db780cc1bef550699e63d9e4e7 ;;
    "aclii.render") _help_node8648f3fded9fa128e5eb8e0814dfbf76 ;;
    "aclii.render.completion") _help_node2e76e740f0ac071ad964481e5d054491 ;;
    "aclii.render.launcher") _help_nodeba4f9c7cf5e0bfa623ddda7827d13c2c ;;
    "aclii.render.parser") _help_nodeae1e4650e2b5e9fafb8ecbd20b398009 ;;
  esac
  exit 0
}

# Flag to enable immediate help / validate error
ACLII_EXEC=1

# parser needs @argv
argv=("$@")

__parse_args () {




_aclii_debug "enter parse_args |$@|"
_aclii_debug "num args $#"
local -a values=("")
  values[1]='./aclii.yml'
  values[2]=''

local wantType=""
local wantingObjectId=""
local argvMode=""
local cmd="aclii"
local -a trailingArgs=("DUMMY FOR SUPPRESS -u")
local processed=0 # Just for debug
local arg

if [ -n "${argv[@]+NOARGS}" ] && [ -n "${argv+ARG}" ]; then
  for arg in "${argv[@]}"
  do
    : $((processed++))
    _aclii_debug "Processing $processed arg |$arg|"
    _aclii_debug "   cmd: $cmd  wantType |$wantType|"

    # Now we're already eating remained argv. Just eat it
    if [ -n "$argvMode" ]; then
      #TODO: Do we need to varidate here?
      trailingArgs+=("$arg")
     # args=$(echo $args | jq '.argv += ["'"$arg"'"]')

    elif [ -n "$wantType" ]; then
      #TODO: Do we need to varidate here?

      #args=$(echo $args | jq '.options["'"$wanting"'"] = "'"$arg"'"')
      _aclii_debug "Save value $arg for id $wantingObjectId"
      values[$wantingObjectId]="$arg"
      wantingObjectId=""
      wantType=""

    # Traditional args terminator
    elif [ "$arg" == "--" ]; then
      argvMode="any"
    elif [ "${arg:0:2}" == '--' ]; then
      # It starts with dash. So this might be an option

      #XXX: How to handle help?
      # This launcher will handle help command
      #if [ `echo "$arg" | grep "-help$"` ]; then
      #  _help $cmd
      #fi
      # Check option that if
      # next arg is option valu or not

      comopt="$cmd"'@'"$arg"
      _aclii_debug "adding flag |$comopt|"
      _aclii_debug "Checking option $arg : comopt $comopt"
      case "$comopt" in
# Option for aclii
        'aclii@--file' )
          #args=$(echo $args | jq '.options["file"] = true')
          values[1]="1"
          wantType="file"
          wantingObjectId="1"
          _aclii_debug "want $wantType for id $wantingObjectId"
          ;;
        'aclii@--verbose' )
          #args=$(echo $args | jq '.options["verbose"] = true')
          values[2]="1"
          wantType=""
          wantingObjectId="2"
          _aclii_debug "want $wantType for id $wantingObjectId"
          ;;
# Option for aclii.playground
        'aclii.playground@--file' )
          #args=$(echo $args | jq '.options["file"] = true')
          values[1]="1"
          wantType="file"
          wantingObjectId="1"
          _aclii_debug "want $wantType for id $wantingObjectId"
          ;;
        'aclii.playground@--verbose' )
          #args=$(echo $args | jq '.options["verbose"] = true')
          values[2]="1"
          wantType=""
          wantingObjectId="2"
          _aclii_debug "want $wantType for id $wantingObjectId"
          ;;
# Option for aclii.playground.hungry
        'aclii.playground.hungry@--file' )
          #args=$(echo $args | jq '.options["file"] = true')
          values[1]="1"
          wantType="file"
          wantingObjectId="1"
          _aclii_debug "want $wantType for id $wantingObjectId"
          ;;
        'aclii.playground.hungry@--verbose' )
          #args=$(echo $args | jq '.options["verbose"] = true')
          values[2]="1"
          wantType=""
          wantingObjectId="2"
          _aclii_debug "want $wantType for id $wantingObjectId"
          ;;
# Option for aclii.playground.stuffed
        'aclii.playground.stuffed@--file' )
          #args=$(echo $args | jq '.options["file"] = true')
          values[1]="1"
          wantType="file"
          wantingObjectId="1"
          _aclii_debug "want $wantType for id $wantingObjectId"
          ;;
        'aclii.playground.stuffed@--verbose' )
          #args=$(echo $args | jq '.options["verbose"] = true')
          values[2]="1"
          wantType=""
          wantingObjectId="2"
          _aclii_debug "want $wantType for id $wantingObjectId"
          ;;
# Option for aclii.playground.run-ls-script
        'aclii.playground.run-ls-script@--file' )
          #args=$(echo $args | jq '.options["file"] = true')
          values[1]="1"
          wantType="file"
          wantingObjectId="1"
          _aclii_debug "want $wantType for id $wantingObjectId"
          ;;
        'aclii.playground.run-ls-script@--verbose' )
          #args=$(echo $args | jq '.options["verbose"] = true')
          values[2]="1"
          wantType=""
          wantingObjectId="2"
          _aclii_debug "want $wantType for id $wantingObjectId"
          ;;
# Option for aclii.render
        'aclii.render@--file' )
          #args=$(echo $args | jq '.options["file"] = true')
          values[1]="1"
          wantType="file"
          wantingObjectId="1"
          _aclii_debug "want $wantType for id $wantingObjectId"
          ;;
        'aclii.render@--verbose' )
          #args=$(echo $args | jq '.options["verbose"] = true')
          values[2]="1"
          wantType=""
          wantingObjectId="2"
          _aclii_debug "want $wantType for id $wantingObjectId"
          ;;
# Option for aclii.render.completion
        'aclii.render.completion@--file' )
          #args=$(echo $args | jq '.options["file"] = true')
          values[1]="1"
          wantType="file"
          wantingObjectId="1"
          _aclii_debug "want $wantType for id $wantingObjectId"
          ;;
        'aclii.render.completion@--verbose' )
          #args=$(echo $args | jq '.options["verbose"] = true')
          values[2]="1"
          wantType=""
          wantingObjectId="2"
          _aclii_debug "want $wantType for id $wantingObjectId"
          ;;
# Option for aclii.render.launcher
        'aclii.render.launcher@--file' )
          #args=$(echo $args | jq '.options["file"] = true')
          values[1]="1"
          wantType="file"
          wantingObjectId="1"
          _aclii_debug "want $wantType for id $wantingObjectId"
          ;;
        'aclii.render.launcher@--verbose' )
          #args=$(echo $args | jq '.options["verbose"] = true')
          values[2]="1"
          wantType=""
          wantingObjectId="2"
          _aclii_debug "want $wantType for id $wantingObjectId"
          ;;
# Option for aclii.render.parser
        'aclii.render.parser@--file' )
          #args=$(echo $args | jq '.options["file"] = true')
          values[1]="1"
          wantType="file"
          wantingObjectId="1"
          _aclii_debug "want $wantType for id $wantingObjectId"
          ;;
        'aclii.render.parser@--verbose' )
          #args=$(echo $args | jq '.options["verbose"] = true')
          values[2]="1"
          wantType=""
          wantingObjectId="2"
          _aclii_debug "want $wantType for id $wantingObjectId"
          ;;
        * )
          if [ -n "${ACLII_EXEC+EXEC}" ]; then
            echo "aclii: Unknown Option $arg"
            _help $cmd
          fi
      esac
  # elif
  #   TODO: Short option handling here
    else
      case "$cmd.$arg" in
        "aclii.playground" )
          cmd="aclii.playground"
          #TODO: Support limited number of args
          ;;
        "aclii.playground.hungry" )
          cmd="aclii.playground.hungry"
          #TODO: Support limited number of args
          argvMode="string"
          wantType="string"
          ;;
        "aclii.playground.stuffed" )
          cmd="aclii.playground.stuffed"
          #TODO: Support limited number of args
          ;;
        "aclii.playground.run-ls-script" )
          cmd="aclii.playground.run-ls-script"
          #TODO: Support limited number of args
          ;;
        "aclii.render" )
          cmd="aclii.render"
          #TODO: Support limited number of args
          ;;
        "aclii.render.completion" )
          cmd="aclii.render.completion"
          #TODO: Support limited number of args
          ;;
        "aclii.render.launcher" )
          cmd="aclii.render.launcher"
          #TODO: Support limited number of args
          ;;
        "aclii.render.parser" )
          cmd="aclii.render.parser"
          #TODO: Support limited number of args
          ;;
        * )
          if [ -n "${ACLII_EXEC+EXEC}" ]; then
            echo "aclii: Unknown Command $arg"
            _help $cmd
          fi
      esac
    fi
  done

  _aclii_debug "Parse done---------"

  #echo ${values[@]}
else
  _aclii_debug "No args. Parse has skipped."
fi


  #local want=""
  #local wanting=""
  #local args
  #local argvMode
  #local cmd="aclii"

  _aclii_debug  "got cmd: $cmd"
  _aclii_debug  "    values: ${#values[@]} items ${values[@]}"
  _aclii_debug  "    trails: ${#trailingArgs[@]} items ${trailingArgs[@]}"
  # Now we got the command which to be executed.
  # Handle it as it wants
  local json='{"command":"'"$cmd"'","args":[],"options":{}}'
  local trail
  for trail in "${trailingArgs[@]:1}" # skip dummy element
  do
    json=$(echo $json | jq '.args+=["'"$trail"'"]')
  done
  case "$cmd" in
    "aclii" )
      _help "$cmd"
      ;;
    "aclii.playground" )
      _help "$cmd"
      ;;
    "aclii.playground.hungry" )
# Build Args
      json=$(echo $json | jq '.options["file"] = "'"${values[1]}"'"')
      json=$(echo $json | jq '.options["verbose"] = "'"${values[2]}"'"')
      _aclii_debug "got json $json"
      _aclii_exec "$json"
      ;;
    "aclii.playground.stuffed" )
# Build Args
      json=$(echo $json | jq '.options["file"] = "'"${values[1]}"'"')
      json=$(echo $json | jq '.options["verbose"] = "'"${values[2]}"'"')
      _aclii_debug "got json $json"
      _aclii_exec "$json"
      ;;
    "aclii.playground.run-ls-script" )
      tmp=$(mktemp)
      echo '#!/usr/bin/env bash' > $tmp
      cat << '__END_OF_ACLII_SCRIPT__' >> $tmp
echo "Hello from aclii inline script!"
echo "I'll show you the list of files!"
ls
echo "That's all. Thanks!"

__END_OF_ACLII_SCRIPT__
      chmod +x $tmp
      result=0
      $tmp || result=$?
      rm $tmp
      if [ ! "$result" == "0" ]; then
        echo "(aclii:: script exited with $result)"
      else
        echo "(aclii:: script done.)"
      fi
      ;;
    "aclii.render" )
      _help "$cmd"
      ;;
    "aclii.render.completion" )
# Build Args
      json=$(echo $json | jq '.options["file"] = "'"${values[1]}"'"')
      json=$(echo $json | jq '.options["verbose"] = "'"${values[2]}"'"')
      _aclii_debug "got json $json"
      _aclii_exec "$json"
      ;;
    "aclii.render.launcher" )
# Build Args
      json=$(echo $json | jq '.options["file"] = "'"${values[1]}"'"')
      json=$(echo $json | jq '.options["verbose"] = "'"${values[2]}"'"')
      _aclii_debug "got json $json"
      _aclii_exec "$json"
      ;;
    "aclii.render.parser" )
# Build Args
      json=$(echo $json | jq '.options["file"] = "'"${values[1]}"'"')
      json=$(echo $json | jq '.options["verbose"] = "'"${values[2]}"'"')
      _aclii_debug "got json $json"
      _aclii_exec "$json"
      ;;
    * )
      echo "Unknown command";
      _help;
  esac
}

__parse_args



