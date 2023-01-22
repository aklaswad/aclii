# aclii

**Another Command Line Interface Interface**

# Synopsis

Write your CLI design in aclii.yml

```yaml
name: my-command
commands:
  - name: list
    script: |
      ls -la
```

Build and use it

```shell
$ aclii put launcher /usr/local/bin/my-command
$ aclii put completion ~/.bashrc.d/my-command-completion
$ my-command list
```

# Description

## aclii is a command line parser generator

The core function of aclii is a _command line parser generator_ for bash scripts.
It can build a pure bash based command line options parser from descriptive YAML file, supports modern sub-command tree based command line definition.

Also aclii can build stand alone completion script for bash (and zsh). You can use aclii just for completion generator ( This is what originally I want to build ;-) )

## aclii is not only a parser, but also argument handling launcher

aclii also can render a command line launcher script for any command line tools. This launcher can parse and validate args and show helps behalf of your proglam. You can get rid of those chores from your program, and just get a correct args as is, or as JSON compiled version of args.

## aclii is not only a launcher, but powerful cli tool kit

You can use aclii launcher not only for programs you written, but also for any cli tools you use. You can write personal chores, or team-wide chores into YAML file and find them from command tree with auto completion support.

# Please note that aclii is still very alpha version

# Install

## Install aclii


```shell
$ npm i -g aclii
```

## Install completion file

```shell
aclii aclii-completion > {{ your completion dir }}/aclii_completion
```

Or for ephemeral testing
```shell
source <(aclii aclii-completion)
```
Or (above line works on ubuntu but not doen't on macos...)
```shell
$ tmp=$(mktemp) && aclii aclii-completion > $tmp && source $tmp && rm $tmp 
```

Ok , now aclii has been set up!

# How to use

Go some new directory and put this config as `aclii.yml`

```yaml
name: mytool
description: my tool for cli
helpstop: true
commands:
  - name: list-home
    description: show my home directory
    script: cd ~ && ls -la
    env: bash
```

now aclii can compile this to launcher by `aclii render completion`, and `aclii render completion` for bash_completion.
Install them and try it!

```
$ aclii render launcher > /usr/local/bin/mytool && chmod +x /usr/local/bin/mytool
$ tmp=$(mktemp) && aclii render completion > $tmp && source $tmp && rm $tmp
$ mytool<TAB>
```


# Use cases

## For option parser of bash script

Write a command line definition into yaml file
```yaml
# myscript.aclii.yml
name: myscript
options:
  - name: name
    type: string
```

Then compile the parser
```
aclii --file myscript.aclii.yml render parser > parser.sh
```

So in your script
```
#!/bin/bash
# $0 = myscript.sh
source $(dirname $0)/parser.sh "$@" # parse imports a function called `_q`
echo "name: $(_q 'name')"
```
This script prints "name: aclii" for the input `./myscript.sh --name aclii`

## For quick tool writing

If you're about to start writing some cli tool (in JavaScript? ruby? whatever) but if you're not familiar with that language and/or command option parser, aclii can help you. aclii launcher can parse options instead and launch your tool with options translated into JSON. You just have to `JSON.parse()` and then write the essential tasks.
aclii can invoke your executable, or execute inline script.

This is an example of how aclii handle command line arguments.
For command `hello --language English hey paul thank you very much`...


```yaml
name: hello
description: Say hello
env: node
argstyle: json
commands:
  - name: hey
    wants:
      - name: name
        type: string
      - name: words
        type: string
        many: true
options:
  - name: language
    description: Select language
    type: string
script: |
  const args = JSON.parse(
    Buffer.from(process.argv[2], 'base64').toString() )
  console.dir(args)
  // this prints below...
  // {
  //   command: 'hello.hey',
  //   bin: 'hello',
  //   binpath: '',
  //   options: {
  //     language: 'English',
  //     name: 'paul',
  //     words: [ 'thank', 'you', 'very', 'much' ]
  //   }
  // }
```

Also, aclii launcher can show help pages which automatically generated from YAML file.

## For team collaboration

If you're working for monorepo which maintained by multiple teams. For example backend and frontend team. There are many cool tools in both area but they don't know each others' stuff. Since frontend team don't know how to do `perldoc` and backend team don't know how npx is powerful. aclii can solve this situation by just writing a YAML config. Let's put a master launcher generated by aclii and navigate them with powerful auto-completion. If a command `repo test frontend<TAB>` show doable actions, `repo build backend --help` shows documents for them, and of course they are executable from single command. It could be helpful, isn't it? 

## For personal use

I know you have aliases which you wrote into `~/.*shrc` but never invoked, and completely forgot how to use them. How many dead aliases do you have?
aclii launcher can manage those items in single yaml file, with documentation and auto-completion, by just putting personal launcher, since you can write oneliners and scripts in aclii.yml and aclii can run them, like GH actions.

### Example for personal use, with self update

```yaml
name: ii
description: Personal tools launcher. To update, edit ~/.aclii/aclii.yml.
helpstop: true
commands:
  - name: maintain
    description: maintain this tool itself
    helpstop: true
    commands:
      - name: update
        description: Re-compile ii
        env: bash
        script: |
          cd ~/.aclii
          aclii render launcher > ~/.bin/ii
          aclii render completion > ~/.bashrc.d/ii
  - name: hey
    description: |
      notify me with desktop notification and voice
    script: |
      osascript -e 'display notification "へい"'
      say "へい"
```

# Documentations

 - [yaml spec](docs/spec.md)
 - [command line client](docs/cli.md)

# Limitations / Missing features / ToDos

- **Documentation**
  - :white_check_mark: How to use aclii cli
  - :white_check_mark: how to write yaml file
- :white_check_mark: Runtime Dependency to `jq`, it should be removed if possible
- Completion file auto installer
- :white_check_mark: Only bash is suppported / Need to support other environment
- Bootstrap / Scatfold to create new aclii project
- Help format
- :white_check_mark: Auto completion format
- short option support

## Future Features

- Dash off script bootstrap / implant aclii config into script file
- Branch grafting for multiple aclii configs
- Plaggable language support for inline scripting / scatfolding
