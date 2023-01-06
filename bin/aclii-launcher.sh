#!/bin/bash

# This is auto generated script by aclii 0.0.3

set -euo pipefail

_aclii_debug () {
  if [ -n "${ACLII_DEBUG+HAS_VALUE}" ]; then
    echo "$@" >> /tmp/aclii-debug.log
  fi
}

_aclii_exec () {
  if [ ${2:0:1} == "/" ] || [ ${2:0:1} == "~" ]; then
    binmame=$2
  else
    binname="$(dirname $0)/$2"
  fi
  local def=$(echo "$1" | base64)
  local b64
  if  [ base64 -w >/dev/null 2>&1 ]; then
    b64=$(echo $1 | base64 -w0)
  else
    b64=$(echo $1 | base64)
  fi
  exec "$binname" "$b64"
}


_aclii_debug "Launch aclii..."
_aclii_debug "ARGV $@"
_aclii_debug "$ 0 $0"
_help_nodea57b9426b2e192dba7ba8c15edd1cc79 () {
  cat << 'EOH'
  Name: aclii
    A toolkit for aclii (Abstract Command Line Interface Interface)
  
  aclii, The toolkit for abstract command line interface interface
  
  Commands:
    playground
      | Sub commands of this playgrond do nothing but just echo the command line inputs as parsed JSON, as main program would receive.
    render
      | Render bash scripts generated from yaml config file. See sub commands for details.
  
  Options:
    --file | filename of aclii config file (aclii.yml)
    --verbose | undefined
EOH
}
_help_nodec9e9547ec88bba1cbfa64a3699a294ed () {
  cat << 'EOH'
  Name: aclii.playground.hungry
    Eat all args into `.argv`. This is default behavior for commands which have no sub commands.
  
  
  Commands:
  
  Options:
    --file | filename of aclii config file (aclii.yml)
    --verbose | undefined
EOH
}
_help_node1f25010818a63d2f7bcb15a33d6fd818 () {
  cat << 'EOH'
  Name: aclii.playground.stuffed
    Raise error if non optional values ( started by dash(es) ) are related.
  
  
  Commands:
  
  Options:
    --file | filename of aclii config file (aclii.yml)
    --verbose | undefined
EOH
}
_help_nodee80eb6db780cc1bef550699e63d9e4e7 () {
  cat << 'EOH'
  Name: aclii.playground.run-ls-script
    Inline script demo. You can implement any script in aclii file and execute it instead of main program.
  
  
  Commands:
  
  Options:
    --file | filename of aclii config file (aclii.yml)
    --verbose | undefined
EOH
}
_help_node2e76e740f0ac071ad964481e5d054491 () {
  cat << 'EOH'
  Name: aclii.render.completion
    Render and print bash auto-completion script to STDOUT.
  
  
  Commands:
  
  Options:
    --file | filename of aclii config file (aclii.yml)
    --verbose | undefined
EOH
}
_help_nodeba4f9c7cf5e0bfa623ddda7827d13c2c () {
  cat << 'EOH'
  Name: aclii.render.launcher
    Render and print bash script to launch other program to STDOUT.
  
  
  Commands:
  
  Options:
    --file | filename of aclii config file (aclii.yml)
    --verbose | undefined
EOH
}
_help_nodeae1e4650e2b5e9fafb8ecbd20b398009 () {
  cat << 'EOH'
  Name: aclii.render.parser
    Render and print rendered bare commandline parser, for testing.
  
  
  Commands:
  
  Options:
    --file | filename of aclii config file (aclii.yml)
    --verbose | undefined
EOH
}
_help_node620dd4ac0e81767466a282a8b830d9a7 () {
  cat << 'EOH'
  Name: aclii.playground
    Sub commands of this playgrond do nothing but just echo the command line inputs as parsed JSON, as main program would receive.
  
  
  Commands:
    hungry
      | Eat all args into `.argv`. This is default behavior for commands which have no sub commands.
    stuffed
      | Raise error if non optional values ( started by dash(es) ) are related.
    run-ls-script
      | Inline script demo. You can implement any script in aclii file and execute it instead of main program.
  
  Options:
    --file | filename of aclii config file (aclii.yml)
    --verbose | undefined
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
    --file | filename of aclii config file (aclii.yml)
    --verbose | undefined
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
    "aclii.playground.hungry") _help_nodec9e9547ec88bba1cbfa64a3699a294ed ;;
    "aclii.playground.stuffed") _help_node1f25010818a63d2f7bcb15a33d6fd818 ;;
    "aclii.playground.run-ls-script") _help_nodee80eb6db780cc1bef550699e63d9e4e7 ;;
    "aclii.render.completion") _help_node2e76e740f0ac071ad964481e5d054491 ;;
    "aclii.render.launcher") _help_nodeba4f9c7cf5e0bfa623ddda7827d13c2c ;;
    "aclii.render.parser") _help_nodeae1e4650e2b5e9fafb8ecbd20b398009 ;;
    "aclii.playground") _help_node620dd4ac0e81767466a282a8b830d9a7 ;;
    "aclii.render") _help_node8648f3fded9fa128e5eb8e0814dfbf76 ;;
  esac
  exit 0
}

# Flag to enable immediate help / validate error
ACLII_EXEC=1

# parser needs @argv
argv=("$@")

__parse_args () {

_aclii_debug "enter parseargs |$@|"
_aclii_debug "num args $#"

local -a def_optionSets
local -a node2options
local -a argvMap
local -a argvTypes # for debug. maybe removed soon.
local -a argvCopy  # for debug. maybe removed soon.

local -a commandPath=("aclii")

local -a inputChain
local -a inputTypes
inputChain=("" "" "3" "")
inputTypes=("file" "switch" "foodgenre" "string")
inputKeys=("file" "verbose" "genre" "food")
inputDefaults=("./aclii.yml" "" "" "")
inputIsMany=("" "" "" "1")
inputIsMulti=("" "" "" "")

local -a foundValues
local -a foundValuesFor
local currentOptionSet="0"
local error=""
local wantType=""
local wantingInputId=""
local cmd="aclii"
local -a trailingArgs
local nth=0
local arg
local optionAcceptable=""

if [ -n "${argv[@]+NOARGS}" ] && [ -n "${argv+ARG}" ]; then
  for arg in "${argv[@]}"
  do
    argvMap[$nth]=""
    argvCopy[$nth]=$(echo $arg | sed s/-//g )
    _aclii_debug "Processing $nth arg |$arg|"
    _aclii_debug "   cmd: $cmd  wantType |$wantType|"


    ## If reading (in)finite args
    if [ -n "$wantType" ]; then
      argvTypes[$nth]="input:$wantType"
      #TODO: Do we need to varldate here?

      _aclii_debug "Save value $arg for id $wantingInputId"
      argvMap[$nth]="$wantingInputId"
      foundValues+=("$arg")
      foundValuesFor+=("$wantingInputId")
      if [ -n "${inputIsMany[$wantingInputId]}" ]; then
        :
      elif [ -n "${inputChain[$wantingInputId]}" ]; then
        local nextId="${inputChain[$wantingInputId]}"
        wantingInputId="$nextId"
        wantType="${inputTypes[$nextId]}"
      else
        wantingInputId=""
        wantType=""
      fi

    # Traditional options terminator
    elif [ "$arg" == "--" ]; then
      optionAcceptable="true"
      argvTypes[$nth]="argterminator"
    elif [ "${arg:0:2}" == '--' ] && [ -z "$optionAcceptable" ]; then
      # It starts with double dash. So this might be an option

      argvTypes[$nth]="option"
      case "$currentOptionSet" in
        '0' )
          case "${arg:2}" in
            'file')
              wantType="file"
              wantingInputId="0"
              _aclii_debug "want $wantType for id $wantingInputId"
              ;;
            'verbose')
              argvMap[$nth]="1"
              foundValues+=("1")
              foundValuesFor+=("1")
              _aclii_debug "want $wantType for id $wantingInputId"
              ;;
            * )
              error="Unknown Option $arg"
              break
          esac
        ;;
        '1' )
          case "${arg:2}" in
            * )
              error="Unknown Option $arg"
              break
          esac
        ;;
        '2' )
          case "${arg:2}" in
            * )
              error="Unknown Option $arg"
              break
          esac
        ;;
        '3' )
          case "${arg:2}" in
            'file')
              wantType="file"
              wantingInputId="0"
              _aclii_debug "want $wantType for id $wantingInputId"
              ;;
            'verbose')
              argvMap[$nth]="1"
              foundValues+=("1")
              foundValuesFor+=("1")
              _aclii_debug "want $wantType for id $wantingInputId"
              ;;
            * )
              error="Unknown Option $arg"
              break
          esac
        ;;
      esac
  # elif
  #   TODO: Short option handling here
    else
      argvTypes[$nth]="subcommand"
      case "$cmd.$arg" in
        "aclii" )
          cmd="aclii"
          commandPath+=("aclii")
          ;;
        "aclii.playground.hungry" )
          cmd="aclii.playground.hungry"
          commandPath+=("hungry")
          wantType="foodgenre"
          wantingInputId="2"
          ;;
        "aclii.playground.stuffed" )
          cmd="aclii.playground.stuffed"
          commandPath+=("stuffed")
          ;;
        "aclii.playground.run-ls-script" )
          cmd="aclii.playground.run-ls-script"
          commandPath+=("run-ls-script")
          ;;
        "aclii.render.completion" )
          cmd="aclii.render.completion"
          commandPath+=("completion")
          ;;
        "aclii.render.launcher" )
          cmd="aclii.render.launcher"
          commandPath+=("launcher")
          ;;
        "aclii.render.parser" )
          cmd="aclii.render.parser"
          commandPath+=("parser")
          ;;
        "aclii.playground" )
          cmd="aclii.playground"
          commandPath+=("playground")
          ;;
        "aclii.render" )
          cmd="aclii.render"
          commandPath+=("render")
          ;;
        * )
          error="Unknown Command $arg"
          break
      esac
    fi
    : $((nth++))
  done

  _aclii_debug "Parse done---------"
  _aclii_debug "    cmd: $cmd"
  _aclii_debug "  error: $error"

  #echo ${values[@]}
else
  _aclii_debug "No args. Parse has skipped."
fi


  _aclii_debug  "got cmd: $cmd"
  local json='{"command":"'"$cmd"'","args":[],"options":{}}'
  # Now we got the command which to be executed.
  # Handle it as it wants
  case "$cmd" in
    "aclii" )
      _help "$cmd"
      ;;
    "aclii.playground.hungry" )
      local bin="_aclii_main"
      key="file"
      def="./aclii.yml"
      json=$(echo $json | jq --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
      ;;
    "aclii.playground.stuffed" )
      local bin="_aclii_main"
      key="file"
      def="./aclii.yml"
      json=$(echo $json | jq --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
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
      exit $result
      ;;
    "aclii.render.completion" )
      local bin="_aclii_main"
      key="file"
      def="./aclii.yml"
      json=$(echo $json | jq --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
      ;;
    "aclii.render.launcher" )
      local bin="_aclii_main"
      key="file"
      def="./aclii.yml"
      json=$(echo $json | jq --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
      ;;
    "aclii.render.parser" )
      local bin="_aclii_main"
      key="file"
      def="./aclii.yml"
      json=$(echo $json | jq --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
      ;;
    "aclii.playground" )
      _help "$cmd"
      ;;
    "aclii.render" )
      _help "$cmd"
      ;;
    * )
      echo "Unknown command";
      _help;
  esac

# Build Args
  local i=0
  if [ -n "${foundValues[@]+HAS}" ] && [ -n "${foundValues+HAS}" ]; then
    for value in "${foundValues[@]}"
    do
      local inputId="${foundValuesFor[$i]}"
      local key="${inputKeys[$inputId]}"

      if [ -n "${inputIsMulti[$inputId]}" ] || [ -n "${inputIsMany[$inputId]}" ]; then
        json=$(echo $json | jq --arg key "${key}" --arg val "${value}" 'if .options[$key] then .options[$key] += [$val] else .options[$key] =[$val] end')
      else
        json=$(echo $json | jq --arg key "${key}" --arg val "${value}" '.options[$key] = $val')
      fi
      : $((i++))
    done
  fi
  _aclii_debug "got json $json"
  _aclii_exec "$json" $bin
}
__parse_args



