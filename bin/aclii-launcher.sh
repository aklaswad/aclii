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
    "aclii.render") _help_node8648f3fded9fa128e5eb8e0814dfbf76 ;;
    "aclii.render.completion") _help_node2e76e740f0ac071ad964481e5d054491 ;;
    "aclii.render.launcher") _help_nodeba4f9c7cf5e0bfa623ddda7827d13c2c ;;
  esac
  exit 0
}

__parse_args () {
  processed=0
  _aclii_debug "enter parse_args |$@|"
  local want
  local wanting
  local argv
  local cmd="aclii"
  for word in "$@"
  do
    : $((processed++))
    _aclii_debug "Processing $processed th arg |$word|"
    _aclii_debug "   cmd: $cmd  want |$want|"

    # Run the path to know where I am
    if [ -n "$argv" ]; then
      #TODO: Do we need to varidate here?

      args=$(echo $args | jq '.argv += ["'"$word"'"]')
      wanting=""
      want=""
    elif [ -n "$want" ]; then
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
        "aclii--file" )
          args=$(echo $args | jq '.options["file"] = true')
          want="file"
          wanting="file"
          ;;
        "aclii--verbose" )
          args=$(echo $args | jq '.options["verbose"] = true')
          want=""
          wanting="verbose"
          ;;
        "aclii.playground--file" )
          args=$(echo $args | jq '.options["file"] = true')
          want="file"
          wanting="file"
          ;;
        "aclii.playground--verbose" )
          args=$(echo $args | jq '.options["verbose"] = true')
          want=""
          wanting="verbose"
          ;;
        "aclii.playground.hungry--file" )
          args=$(echo $args | jq '.options["file"] = true')
          want="file"
          wanting="file"
          ;;
        "aclii.playground.hungry--verbose" )
          args=$(echo $args | jq '.options["verbose"] = true')
          want=""
          wanting="verbose"
          ;;
        "aclii.playground.stuffed--file" )
          args=$(echo $args | jq '.options["file"] = true')
          want="file"
          wanting="file"
          ;;
        "aclii.playground.stuffed--verbose" )
          args=$(echo $args | jq '.options["verbose"] = true')
          want=""
          wanting="verbose"
          ;;
        "aclii.render--file" )
          args=$(echo $args | jq '.options["file"] = true')
          want="file"
          wanting="file"
          ;;
        "aclii.render--verbose" )
          args=$(echo $args | jq '.options["verbose"] = true')
          want=""
          wanting="verbose"
          ;;
        "aclii.render.completion--file" )
          args=$(echo $args | jq '.options["file"] = true')
          want="file"
          wanting="file"
          ;;
        "aclii.render.completion--verbose" )
          args=$(echo $args | jq '.options["verbose"] = true')
          want=""
          wanting="verbose"
          ;;
        "aclii.render.launcher--file" )
          args=$(echo $args | jq '.options["file"] = true')
          want="file"
          wanting="file"
          ;;
        "aclii.render.launcher--verbose" )
          args=$(echo $args | jq '.options["verbose"] = true')
          want=""
          wanting="verbose"
          ;;
        * ) echo "Unknown Option $word"
          exit
          ;;
      esac
    else
      case "$cmd.$word" in
        "aclii.playground" )
          cmd="aclii.playground"
          ;;
        "aclii.playground.hungry" )
          cmd="aclii.playground.hungry"
          argv="string"
          ;;
        "aclii.playground.stuffed" )
          cmd="aclii.playground.stuffed"
          ;;
        "aclii.render" )
          cmd="aclii.render"
          ;;
        "aclii.render.completion" )
          cmd="aclii.render.completion"
          ;;
        "aclii.render.launcher" )
          cmd="aclii.render.launcher"
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
    "aclii.playground" )
      _help "$cmd"
      ;;
    "aclii.playground.hungry" )
      _aclii_exec "$args"
      ;;
    "aclii.playground.stuffed" )
      _aclii_exec "$args"
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
    * )
      echo "Unknown command";
      _help;
  esac
}

__parse_args "$@"



