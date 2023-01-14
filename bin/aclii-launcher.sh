#!/bin/bash

# This is auto generated script by aclii 0.0.8

set -euo pipefail

_aclii_debug () {
  if [ -n "${ACLII_DEBUG+HAS_VALUE}" ]; then
    echo "$@" >> /tmp/aclii-debug.log
  fi
}

_aclii_exec_json () {
  if [ "${1:0:1}" = "/" ] || [ "${1:0:1}" = "~" ]; then
    binname=$1
  else
    binname="$(dirname "$0")"/"$1"
  fi
  exec "$binname" "$2"
}

_aclii_exec () {
  if [ "${1:0:1}" = "/" ] || [ "${1:0:1}" = "~" ]; then
    binname=$1
  else
    binname="$(dirname "$0")/$1"
  fi
  exec "$binname" "${@:2}"

}

_aclii_debug "Launch aclii..."
_aclii_debug "ARGV $*"
_aclii_debug "$ 0 $0"
_help_nodea57b9426b2e192dba7ba8c15edd1cc79 () {
  cat << 'EOH'
  Name: aclii
  
    A toolkit for aclii (Abstract Command Line Interface Interface)
  aclii, The toolkit for abstract command line interface interface
  Commands:
    put 
        Put aclii artifacts into specified place.
    render 
        Render bash scripts generated from yaml config file. See sub commands for details.
    playground 
        Sub commands of this playgrond do nothing but just echo the command line inputs as parsed JSON, as main program would receive.
    aclii-completion 
        render completion script for aclii
  Options:
    --file <file> (default: "./aclii.yml")
        filename of aclii config file (aclii.yml)
    --verbose 
EOH
}
_help_nodef2498ff8dad2392bdba29afc440844ca () {
  cat << 'EOH'
  Name: aclii.put.launcher
  
    Put an auto generated launcher
  If specified file already exists, aclii will replace the content with new version.
  
  Usage:
    aclii put launcher <any>
  
  Arguments:
    target-file
        File path to be put/replaced newly rendered aclii launcher
  Options:
    --file <file> (default: "./aclii.yml")
        filename of aclii config file (aclii.yml)
    --verbose 
EOH
}
_help_node33410cdea442484d126d63060d0a13d0 () {
  cat << 'EOH'
  Name: aclii.put.completion
  
    Put an auto generated completion script.
  If specified file already exists, aclii will replace the content with new version.
  
  Usage:
    aclii put completion <any>
  
  Arguments:
    target-file
        File path to be put/replaced newly rendered aclii auto-completion script
  Options:
    --target <completionTarget(bash|zsh)> (default: "bash")
    --file <file> (default: "./aclii.yml")
        filename of aclii config file (aclii.yml)
    --verbose 
EOH
}
_help_noded455db2d5523778e56432d8047da3f51 () {
  cat << 'EOH'
  Name: aclii.put.parser
  
    Put an auto generated arg parser for bash scripts,
  If specified file already exists, aclii will replace the content with new version.
  
  Usage:
    aclii put parser <any>
  
  Arguments:
    target-file
        File path to be put/replaced newly rendered arg parser
  Options:
    --file <file> (default: "./aclii.yml")
        filename of aclii config file (aclii.yml)
    --verbose 
EOH
}
_help_node2e76e740f0ac071ad964481e5d054491 () {
  cat << 'EOH'
  Name: aclii.render.completion
  
    Render and print bash auto-completion script to STDOUT.
  Options:
    --target <completionTarget(bash|zsh)> (default: "bash")
    --file <file> (default: "./aclii.yml")
        filename of aclii config file (aclii.yml)
    --verbose 
EOH
}
_help_nodeba4f9c7cf5e0bfa623ddda7827d13c2c () {
  cat << 'EOH'
  Name: aclii.render.launcher
  
    Render and print bash script to launch other program to STDOUT.
  Options:
    --file <file> (default: "./aclii.yml")
        filename of aclii config file (aclii.yml)
    --verbose 
EOH
}
_help_nodeae1e4650e2b5e9fafb8ecbd20b398009 () {
  cat << 'EOH'
  Name: aclii.render.parser
  
    Render and print rendered bare commandline parser, for testing.
  Options:
    --file <file> (default: "./aclii.yml")
        filename of aclii config file (aclii.yml)
    --verbose 
EOH
}

_help_nodefed06a3565294df3bed8922eb3d9505d () {
  cat << 'EOH'
  Name: aclii.render.manual
  
    Render command tree manual in markdown format.
  Options:
    --file <file> (default: "./aclii.yml")
        filename of aclii config file (aclii.yml)
    --verbose 
EOH
}

_help_nodec9e9547ec88bba1cbfa64a3699a294ed () {
  cat << 'EOH'
  Name: aclii.playground.hungry
  
    Eat all args into `.argv`. This is default behavior for commands which have no sub commands.
  
  Usage:
    aclii playground hungry <foodgenre> <string>...
  
  Arguments:
    genre (chinese|french|japanese|ethnic)
        Select genre you want to...
    food
  Options:
    --file <file> (default: "./aclii.yml")
        filename of aclii config file (aclii.yml)
    --verbose 
EOH
}
_help_node1f25010818a63d2f7bcb15a33d6fd818 () {
  cat << 'EOH'
  Name: aclii.playground.stuffed
  
    Raise error if non optional values ( started by dash(es) ) are related.
  Options:
    --file <file> (default: "./aclii.yml")
        filename of aclii config file (aclii.yml)
    --verbose 
EOH
}
_help_nodee80eb6db780cc1bef550699e63d9e4e7 () {
  cat << 'EOH'
  Name: aclii.playground.run-ls-script
  
    Inline script demo. You can implement any script in aclii file and execute it instead of main program.
  Options:
    --file <file> (default: "./aclii.yml")
        filename of aclii config file (aclii.yml)
    --verbose 
EOH
}
_help_node9a63b322e3c6be1672ca59b12e537a8d () {
  cat << 'EOH'
  Name: aclii.put
  
    Put aclii artifacts into specified place.
  Commands:
    launcher <any>
        Put an auto generated launcher
  If specified file already exists, aclii will replace the content with new version.
    completion <any>
        Put an auto generated completion script.
  If specified file already exists, aclii will replace the content with new version.
    parser <any>
        Put an auto generated arg parser for bash scripts,
  If specified file already exists, aclii will replace the content with new version.
  Options:
    --file <file> (default: "./aclii.yml")
        filename of aclii config file (aclii.yml)
    --verbose 
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
        Render and print bash auto-completion script to STDOUT.
    launcher 
        Render and print bash script to launch other program to STDOUT.
    parser 
        Render and print rendered bare commandline parser, for testing.
    manual 
        Render command tree manual in markdown format.
  Options:
    --file <file> (default: "./aclii.yml")
        filename of aclii config file (aclii.yml)
    --verbose 
EOH
}
_help_node620dd4ac0e81767466a282a8b830d9a7 () {
  cat << 'EOH'
  Name: aclii.playground
  
    Sub commands of this playgrond do nothing but just echo the command line inputs as parsed JSON, as main program would receive.
  Commands:
    hungry <foodgenre> <string>...
        Eat all args into `.argv`. This is default behavior for commands which have no sub commands.
    stuffed 
        Raise error if non optional values ( started by dash(es) ) are related.
    run-ls-script 
        Inline script demo. You can implement any script in aclii file and execute it instead of main program.
  Options:
    --file <file> (default: "./aclii.yml")
        filename of aclii config file (aclii.yml)
    --verbose 
EOH
}
_help_node1335413e45f7b6441d6db69628a7df80 () {
  cat << 'EOH'
  Name: aclii.aclii-completion
  
    render completion script for aclii
  Options:
    --target <completionTarget(bash|zsh)> (default: "bash")
    --file <file> (default: "./aclii.yml")
        filename of aclii config file (aclii.yml)
    --verbose 
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
    "aclii.put.launcher") _help_nodef2498ff8dad2392bdba29afc440844ca ;;
    "aclii.put.completion") _help_node33410cdea442484d126d63060d0a13d0 ;;
    "aclii.put.parser") _help_noded455db2d5523778e56432d8047da3f51 ;;
    "aclii.render.completion") _help_node2e76e740f0ac071ad964481e5d054491 ;;
    "aclii.render.launcher") _help_nodeba4f9c7cf5e0bfa623ddda7827d13c2c ;;
    "aclii.render.parser") _help_nodeae1e4650e2b5e9fafb8ecbd20b398009 ;;
    "aclii.playground.hungry") _help_nodec9e9547ec88bba1cbfa64a3699a294ed ;;
    "aclii.playground.stuffed") _help_node1f25010818a63d2f7bcb15a33d6fd818 ;;
    "aclii.playground.run-ls-script") _help_nodee80eb6db780cc1bef550699e63d9e4e7 ;;
    "aclii.put") _help_node9a63b322e3c6be1672ca59b12e537a8d ;;
    "aclii.render") _help_node8648f3fded9fa128e5eb8e0814dfbf76 ;;
    "aclii.playground") _help_node620dd4ac0e81767466a282a8b830d9a7 ;;
    "aclii.aclii-completion") _help_node1335413e45f7b6441d6db69628a7df80 ;;
  esac
  exit 0
}

# parser needs @argv
argv=("$@")

__parse_args () {

_aclii_debug "enter parseargs |$*|"
_aclii_debug "num args $#"
local -a argvTypes # for debug. maybe removed soon.

local -a commandPath=("aclii")

local inputChain=("" "" "" "" "" "" "" "8" "" "")
local inputTypes=("file" "switch" "" "completionTarget" "" "" "completionTarget" "foodgenre" "string" "completionTarget")
local inputKeys=("file" "verbose" "target-file" "target" "target-file" "target-file" "target" "genre" "food" "target")
local inputDefaults=("./aclii.yml" "" "" "bash" "" "" "bash" "" "" "bash")

# For tech reason, these are separated
# Map which args for subcommands allows multiple inputs
local inputIsMany=("" "" "" "" "" "" "" "" "1" "")
# Map which options allow repeated use
local inputIsMulti=("" "" "" "" "" "" "" "" "" "")

local -a foundValues
local -a foundValuesFor
local currentOptionSet="0"
local error=""
local wantType=""
local wantingInputId=""
local wantOptType=""
local wantingOptInputId=""
local cmd="aclii"
local nth=0
local arg
local optionStop=""
local help=""
if [ -n "${iszsh+ZSH}" ]; then
  nth=1
fi

if [ -n "${argv+ARG}" ]; then
  for arg in "${argv[@]}"
  do
    _aclii_debug "Processing $nth arg |$arg|"
    _aclii_debug "   cmd: $cmd  wantType |$wantType| wantOpt |$wantOptType|"


    if [ -n "$wantOptType" ]; then
      argvTypes[nth]="input:$wantOptType"
      #TODO: Do we need to varldate here?

      _aclii_debug "Save value $arg for id $wantingOptInputId"
      foundValues+=("$arg")
      foundValuesFor+=("$wantingOptInputId")
      wantingOptInputId=""
      wantOptType=""

    # Traditional options terminator
    elif [ "$arg" = "--" ] && [ -z "$optionStop" ]; then
      optionStop="true"
      argvTypes[nth]="argterminator"

    elif [ "${arg:0:2}" = '--' ] && [ -z "$optionStop" ]; then
      # It starts with double dash. So this might be an option
      if [ "${arg:2}" = "help" ]; then
        help="help"
        break
      fi

      argvTypes[nth]="option"
      case "$currentOptionSet" in
        '0' )
          case "${arg:2}" in
            'file')
              wantOptType="file"
              wantingOptInputId="0"
              _aclii_debug "option want $wantOptType for id $wantingOptInputId"
              ;;
            'verbose')
              foundValues+=("1")
              foundValuesFor+=("1")
              _aclii_debug "option want $wantOptType for id $wantingOptInputId"
              ;;
            * )
              error="Unknown Option $arg"
              break
          esac
        ;;
        '1' )
          case "${arg:2}" in
            'file')
              wantOptType="file"
              wantingOptInputId="0"
              _aclii_debug "option want $wantOptType for id $wantingOptInputId"
              ;;
            'verbose')
              foundValues+=("1")
              foundValuesFor+=("1")
              _aclii_debug "option want $wantOptType for id $wantingOptInputId"
              ;;
            * )
              error="Unknown Option $arg"
              break
          esac
        ;;
        '2' )
          case "${arg:2}" in
            'target')
              wantOptType="completionTarget"
              wantingOptInputId="3"
              _aclii_debug "option want $wantOptType for id $wantingOptInputId"
              ;;
            'file')
              wantOptType="file"
              wantingOptInputId="0"
              _aclii_debug "option want $wantOptType for id $wantingOptInputId"
              ;;
            'verbose')
              foundValues+=("1")
              foundValuesFor+=("1")
              _aclii_debug "option want $wantOptType for id $wantingOptInputId"
              ;;
            * )
              error="Unknown Option $arg"
              break
          esac
        ;;
        '3' )
          case "${arg:2}" in
            'target')
              wantOptType="completionTarget"
              wantingOptInputId="6"
              _aclii_debug "option want $wantOptType for id $wantingOptInputId"
              ;;
            'file')
              wantOptType="file"
              wantingOptInputId="0"
              _aclii_debug "option want $wantOptType for id $wantingOptInputId"
              ;;
            'verbose')
              foundValues+=("1")
              foundValuesFor+=("1")
              _aclii_debug "option want $wantOptType for id $wantingOptInputId"
              ;;
            * )
              error="Unknown Option $arg"
              break
          esac
        ;;
        '4' )
          case "${arg:2}" in
            'target')
              wantOptType="completionTarget"
              wantingOptInputId="9"
              _aclii_debug "option want $wantOptType for id $wantingOptInputId"
              ;;
            'file')
              wantOptType="file"
              wantingOptInputId="0"
              _aclii_debug "option want $wantOptType for id $wantingOptInputId"
              ;;
            'verbose')
              foundValues+=("1")
              foundValuesFor+=("1")
              _aclii_debug "option want $wantOptType for id $wantingOptInputId"
              ;;
            * )
              error="Unknown Option $arg"
              break
          esac
        ;;
      esac

    ## If reading (in)finite args
    elif [ -n "$wantType" ]; then
      argvTypes[nth]="input:$wantType"
      #TODO: Do we need to varldate here?

      _aclii_debug "Save value $arg for id $wantingInputId"
      foundValues+=("$arg")
      foundValuesFor+=("$wantingInputId")
      if [ -n "${inputIsMany[wantingInputId]}" ]; then
        :
      elif [ -n "${inputChain[wantingInputId]}" ]; then
        local nextId="${inputChain[wantingInputId]}"
        wantingInputId="$nextId"
        wantType="${inputTypes[nextId]}"
      else
        wantingInputId=""
        wantType=""
      fi

    else
      argvTypes[nth]="subcommand"
      case "$cmd.$arg" in
        "aclii" )
          cmd="aclii"
          commandPath+=("aclii")
          currentOptionSet="0"
          ;;
        "aclii.put.launcher" )
          cmd="aclii.put.launcher"
          commandPath+=("launcher")
          currentOptionSet="1"
          wantType="undefined"
          wantingInputId="2"
          ;;
        "aclii.put.completion" )
          cmd="aclii.put.completion"
          commandPath+=("completion")
          currentOptionSet="2"
          wantType="undefined"
          wantingInputId="4"
          ;;
        "aclii.put.parser" )
          cmd="aclii.put.parser"
          commandPath+=("parser")
          currentOptionSet="1"
          wantType="undefined"
          wantingInputId="5"
          ;;
        "aclii.render.completion" )
          cmd="aclii.render.completion"
          commandPath+=("completion")
          currentOptionSet="3"
          ;;
        "aclii.render.launcher" )
          cmd="aclii.render.launcher"
          commandPath+=("launcher")
          currentOptionSet="1"
          ;;
        "aclii.render.parser" )
          cmd="aclii.render.parser"
          commandPath+=("parser")
          currentOptionSet="1"
          ;;
        "aclii.render.manual" )
          cmd="aclii.render.manual"
          commandPath+=("manual")
          currentOptionSet="1"
          ;;
        "aclii.playground" )
          cmd="aclii.playground"
          commandPath+=("playground")
        "aclii.playground.hungry" )
          cmd="aclii.playground.hungry"
          commandPath+=("hungry")
          currentOptionSet="1"
          wantType="foodgenre"
          wantingInputId="7"
          ;;
        "aclii.playground.stuffed" )
          cmd="aclii.playground.stuffed"
          commandPath+=("stuffed")
          currentOptionSet="1"
          ;;
        "aclii.playground.run-ls-script" )
          cmd="aclii.playground.run-ls-script"
          commandPath+=("run-ls-script")
          currentOptionSet="1"
          ;;
        "aclii.put" )
          cmd="aclii.put"
          commandPath+=("put")
          currentOptionSet="1"
          ;;
        "aclii.render" )
          cmd="aclii.render"
          commandPath+=("render")
          currentOptionSet="1"
          ;;
        "aclii.playground" )
          cmd="aclii.playground"
          commandPath+=("playground")
          currentOptionSet="1"
          ;;
        "aclii.aclii-completion" )
          cmd="aclii.aclii-completion"
          commandPath+=("aclii-completion")
          currentOptionSet="4"
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
  _aclii_debug "   want: $wantType"
  _aclii_debug "optwant: $wantOptType"

  _aclii_debug "argvTypes"
  _aclii_debug "${argvTypes[@]}"
  #echo ${values[@]}
else
  _aclii_debug "No args. Parse has skipped."
fi


  _aclii_debug "got cmd: $cmd"
  _aclii_debug "error: $error"

  if [ -n "$help" ]; then
    _help "$cmd"
  fi
  if [ -n "$error" ]; then
    echo "Got command line parse error: $error"
    _help
  fi

  # Now we got the command which to be executed.
  # Handle it as it wants


# At first, check if this command wants JSON compiled args.
# Also, handle helpstops here.
  local wantJSON=""
  local bin=""
  local binPath=""
  case "$cmd" in
    "aclii" )
      _help "$cmd"
      ;;
    "aclii.put.launcher" )
      wantJSON="1"
      bin="_aclii_main"
      binPath="aclii"
      ;;
    "aclii.put.completion" )
      wantJSON="1"
      bin="_aclii_main"
      binPath="aclii"
      ;;
    "aclii.put.parser" )
      wantJSON="1"
      bin="_aclii_main"
      binPath="aclii"
      ;;
    "aclii.render.completion" )
      wantJSON="1"
      bin="_aclii_main"
      binPath="aclii"
      ;;
    "aclii.render.launcher" )
      wantJSON="1"
      bin="_aclii_main"
      binPath="aclii"
      ;;
    "aclii.render.parser" )
      wantJSON="1"
      bin="_aclii_main"
      binPath="aclii"
      ;;

    "aclii.playground.hungry" )
      wantJSON="1"
      bin="_aclii_main"
      binPath="aclii.playground"
      ;;
    "aclii.playground.stuffed" )
      wantJSON="1"
      bin="_aclii_main"
      binPath="aclii.playground"
      ;;
    "aclii.playground.run-ls-script" )
      bin="_aclii_main"
      binPath="aclii.playground.run-ls-script"
      ;;
    "aclii.put" )
      _help "$cmd"
      ;;
    "aclii.render" )
      _help "$cmd"
      ;;
    "aclii.playground" )
      _help "$cmd"
      ;;
    "aclii.aclii-completion" )
      wantJSON="1"
      bin="_aclii_main"
      binPath="aclii"
      ;;
  esac

  local json
  local jsonb64
# Let's cook JSON
  if [ -n "$wantJSON" ]; then
    json=$(printf '{"command":"%s","bin":"%s","binpath":"%s","options":{}}' $cmd $bin $binPath);

  # Insert Default Values
  case "$cmd" in
    "aclii")
      key="file"
      def="./aclii.yml"
      json=$(echo "$json" | jq -c --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
      ;;
    "aclii.put.launcher")
      key="file"
      def="./aclii.yml"
      json=$(echo "$json" | jq -c --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
      ;;
    "aclii.put.completion")
      key="target"
      def="bash"
      json=$(echo "$json" | jq -c --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
      key="file"
      def="./aclii.yml"
      json=$(echo "$json" | jq -c --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
      ;;
    "aclii.put.parser")
      key="file"
      def="./aclii.yml"
      json=$(echo "$json" | jq -c --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
      ;;
    "aclii.render.completion")
      key="target"
      def="bash"
      json=$(echo "$json" | jq -c --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
      key="file"
      def="./aclii.yml"
      json=$(echo "$json" | jq -c --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
      ;;
    "aclii.render.launcher")
      key="file"
      def="./aclii.yml"
      json=$(echo "$json" | jq -c --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
      ;;
    "aclii.render.parser")
      key="file"
      def="./aclii.yml"
      json=$(echo "$json" | jq -c --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
      ;;

    "aclii.playground.hungry")
      key="file"
      def="./aclii.yml"
      json=$(echo "$json" | jq -c --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
      ;;

    "aclii.playground.stuffed")
      key="file"
      def="./aclii.yml"
      json=$(echo "$json" | jq -c --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
      ;;
    "aclii.playground.run-ls-script")
      key="file"
      def="./aclii.yml"
      json=$(echo "$json" | jq -c --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
      ;;
    "aclii.put")
      key="file"
      def="./aclii.yml"
      json=$(echo "$json" | jq -c --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
      ;;
    "aclii.render")
      key="file"
      def="./aclii.yml"
      json=$(echo "$json" | jq -c --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
      ;;
    "aclii.playground")
      key="file"
      def="./aclii.yml"
      json=$(echo "$json" | jq -c --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
      ;;
    "aclii.aclii-completion")
      key="target"
      def="bash"
      json=$(echo "$json" | jq -c --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
      key="file"
      def="./aclii.yml"
      json=$(echo "$json" | jq -c --arg key "${key}" --arg val "${def}" '.options[$key] = $val')
      ;;
  esac

  # Then, Insert values fetched from argv
    local i=0
    if [ -n "${foundValues+HAS}" ]; then
      for value in "${foundValues[@]}"
      do
        local inputId="${foundValuesFor[i]}"
        local key="${inputKeys[inputId]}"

        if [ -n "${inputIsMulti[inputId]}" ] || [ -n "${inputIsMany[inputId]}" ]; then
          json=$(echo "$json" | jq -c --arg key "${key}" --arg val "${value}" 'if .options[$key] then .options[$key] += [$val] else .options[$key] =[$val] end')
        else
          json=$(echo "$json" | jq -c --arg key "${key}" --arg val "${value}" '.options[$key] = $val')
        fi
        : $((i++))
      done
    fi

    if  [ "$(base64 -w >/dev/null 2>&1)" ]; then
      jsonb64=$(echo "$json" | base64 -w0)
    else
      jsonb64=$(echo "$json" | base64)
    fi
    _aclii_debug "got json $( echo "$json" | jq .)"
  fi

  case "$binPath" in
    "aclii" )
      _aclii_exec_json "$bin" "$jsonb64"
      ;;
    "aclii.put.launcher" )
      _aclii_exec_json "$bin" "$jsonb64"
      ;;
    "aclii.put.completion" )
      _aclii_exec_json "$bin" "$jsonb64"
      ;;
    "aclii.put.parser" )
      _aclii_exec_json "$bin" "$jsonb64"
      ;;
    "aclii.render.completion" )
      _aclii_exec_json "$bin" "$jsonb64"
      ;;
    "aclii.render.launcher" )
      _aclii_exec_json "$bin" "$jsonb64"
      ;;
    "aclii.render.parser" )
      _aclii_exec_json "$bin" "$jsonb64"
      ;;
    "aclii.playground.hungry" )
      _aclii_exec_json "$bin" "$jsonb64"
      ;;
    "aclii.playground.stuffed" )
      _aclii_exec_json "$bin" "$jsonb64"
      ;;
    "aclii.playground.run-ls-script" )
      tmp=$(mktemp)
      echo '#!/usr/bin/env bash' > "$tmp"
      cat << '__END_OF_ACLII_SCRIPT__' >> "$tmp"
echo "Hello from aclii inline script!"
echo "I'll show you the list of files!"
ls
echo "That's all. Thanks!"

__END_OF_ACLII_SCRIPT__
      chmod +x "$tmp"
      result=0
      "$tmp" "${argv[@]}" || result=$?
      rm "$tmp"
      if [ ! "$result" = "0" ]; then
        echo "(aclii:: script exited with $result)"
      else
        echo "(aclii:: script done.)"
      fi
      exit $result
      ;;
    "aclii.put" )
      _aclii_exec_json "$bin" "$jsonb64"
      ;;
    "aclii.render" )
      _aclii_exec_json "$bin" "$jsonb64"
      ;;
    "aclii.render.manual" )
      _aclii_exec_json "$bin" "$jsonb64"
      ;;
    "aclii.playground" )
      _aclii_exec_json "$bin" "$jsonb64"
      ;;
    "aclii.aclii-completion" )
      _aclii_exec_json "$bin" "$jsonb64"
      ;;
    * )
      echo "Unknown command";
      _help;
  esac

  _aclii_debug "got json $json"
}
__parse_args



