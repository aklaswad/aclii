# This is auto generated script by aclii 0.0.1

_aclii_debug () {
  if [ -n "$ACLII_DEBUG" ]; then
    echo "$@" >> /tmp/aclii-debug.log
  fi
}

_aclii () {

  # parser needs @argv
  argv=(${COMP_WORDS[@]:0:$((${#COMP_WORDS[@]}-1))})



_aclii_debug "enter parse_args |$@|"
_aclii_debug "num args $#"
local -a values=("")
  values[1]='./aclii.yml'

local wantType=""
local wantingObjectId=""
local argvMode=""
local cmd="aclii"
local -a trailingArgs=("DUMMY FOR SUPPRESS -u")
local processed=0 # Just for debug
local arg

if [ -z "${argv[@]+NOARGS}" ];
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
        * )
          if [ -n "${ACLII_EXEC+EXEC}" ]; then
            echo "aclii: Unknown Command $cmd"
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


  local oldifs="$IFS"
  cur="${COMP_WORDS[COMP_CWORD]}"
  _aclii_debug "enter compwords |${COMP_WORDS[@]}| cur |$cur|"

  COMPREPLY=()


  if [ -n "$wantType" ]; then
      # OK, we already know what we want;
      _aclii_debug "want $want |"
    case "$wantType" in
      "file" ) _filedir ;;
      "dir" ) _filedir -d ;;
      * ) COMPREPLY=() ;;
    esac
  elif [ "${cur:0:1}" == '-' ]; then
    # It starts with dash. Maybe we should show option list
    case "$cmd" in
      "aclii" )
        _aclii_debug "path: aclii cur: $cur |"
        COMPREPLY=( $(compgen -W "--file --verbose" -- "${cur}" )) ;;
      "aclii.playground" )
        _aclii_debug "path: aclii.playground cur: $cur |"
        COMPREPLY=( $(compgen -W "--file --verbose" -- "${cur}" )) ;;
      "aclii.playground.hungry" )
        _aclii_debug "path: aclii.playground.hungry cur: $cur |"
        COMPREPLY=( $(compgen -W "--file --verbose" -- "${cur}" )) ;;
      "aclii.playground.stuffed" )
        _aclii_debug "path: aclii.playground.stuffed cur: $cur |"
        COMPREPLY=( $(compgen -W "--file --verbose" -- "${cur}" )) ;;
      "aclii.render" )
        _aclii_debug "path: aclii.render cur: $cur |"
        COMPREPLY=( $(compgen -W "--file --verbose" -- "${cur}" )) ;;
      "aclii.render.completion" )
        _aclii_debug "path: aclii.render.completion cur: $cur |"
        COMPREPLY=( $(compgen -W "--file --verbose" -- "${cur}" )) ;;
      "aclii.render.launcher" )
        _aclii_debug "path: aclii.render.launcher cur: $cur |"
        COMPREPLY=( $(compgen -W "--file --verbose" -- "${cur}" )) ;;
    esac
  else
    # Or, searching next command
    case "$cmd" in
      "aclii" )
      COMPREPLY=( $(compgen -W "playground render" -- "${cur}" )) ;;
      "aclii.playground" )
      COMPREPLY=( $(compgen -W "hungry stuffed" -- "${cur}" )) ;;
      "aclii.playground.hungry" )
      COMPREPLY=( $(compgen -W "" -- "${cur}" )) ;;
      "aclii.playground.stuffed" )
      COMPREPLY=( $(compgen -W "" -- "${cur}" )) ;;
      "aclii.render" )
      COMPREPLY=( $(compgen -W "completion launcher" -- "${cur}" )) ;;
      "aclii.render.completion" )
      COMPREPLY=( $(compgen -W "" -- "${cur}" )) ;;
      "aclii.render.launcher" )
      COMPREPLY=( $(compgen -W "" -- "${cur}" )) ;;
    esac
  fi
  _aclii_debug "---------"

  IFS="$oldifs"
}
complete -o default -F _aclii aclii

