# This is auto generated script by aclii 0.0.3

_aclii_debug () {
  if [ -n "$ACLII_DEBUG" ]; then
    echo "$@" >> /tmp/aclii-debug.log
  fi
}

_aclii () {

  # parser needs @argv.
  # Parse from [1] to [len-1] for detect current subcommand
  # ( [0] always aclii so skip it )
  argv=(${COMP_WORDS[@]:1:$((${#COMP_WORDS[@]}-1))})

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
      "aclii.playground.hungry" )
        _aclii_debug "path: aclii.playground.hungry cur: $cur |"
        COMPREPLY=( $(compgen -W "--file --verbose" -- "${cur}" )) ;;
      "aclii.playground.stuffed" )
        _aclii_debug "path: aclii.playground.stuffed cur: $cur |"
        COMPREPLY=( $(compgen -W "--file --verbose" -- "${cur}" )) ;;
      "aclii.playground.run-ls-script" )
        _aclii_debug "path: aclii.playground.run-ls-script cur: $cur |"
        COMPREPLY=( $(compgen -W "--file --verbose" -- "${cur}" )) ;;
      "aclii.render.completion" )
        _aclii_debug "path: aclii.render.completion cur: $cur |"
        COMPREPLY=( $(compgen -W "--file --verbose" -- "${cur}" )) ;;
      "aclii.render.launcher" )
        _aclii_debug "path: aclii.render.launcher cur: $cur |"
        COMPREPLY=( $(compgen -W "--file --verbose" -- "${cur}" )) ;;
      "aclii.render.parser" )
        _aclii_debug "path: aclii.render.parser cur: $cur |"
        COMPREPLY=( $(compgen -W "--file --verbose" -- "${cur}" )) ;;
      "aclii.playground" )
        _aclii_debug "path: aclii.playground cur: $cur |"
        COMPREPLY=( $(compgen -W "--file --verbose" -- "${cur}" )) ;;
      "aclii.render" )
        _aclii_debug "path: aclii.render cur: $cur |"
        COMPREPLY=( $(compgen -W "--file --verbose" -- "${cur}" )) ;;
    esac
  else
    # Or, searching next command
    case "$cmd" in
      "aclii" )
      COMPREPLY=( $(compgen -W "playground render" -- "${cur}" )) ;;
      "aclii.playground.hungry" )
      COMPREPLY=( $(compgen -W "" -- "${cur}" )) ;;
      "aclii.playground.stuffed" )
      COMPREPLY=( $(compgen -W "" -- "${cur}" )) ;;
      "aclii.playground.run-ls-script" )
      COMPREPLY=( $(compgen -W "" -- "${cur}" )) ;;
      "aclii.render.completion" )
      COMPREPLY=( $(compgen -W "" -- "${cur}" )) ;;
      "aclii.render.launcher" )
      COMPREPLY=( $(compgen -W "" -- "${cur}" )) ;;
      "aclii.render.parser" )
      COMPREPLY=( $(compgen -W "" -- "${cur}" )) ;;
      "aclii.playground" )
      COMPREPLY=( $(compgen -W "hungry stuffed run-ls-script" -- "${cur}" )) ;;
      "aclii.render" )
      COMPREPLY=( $(compgen -W "completion launcher parser" -- "${cur}" )) ;;
    esac
  fi
  _aclii_debug "---------"

  IFS="$oldifs"
}
complete -o default -F _aclii aclii

