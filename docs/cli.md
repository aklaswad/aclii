aclii command line manual

<h1 id="aclii">
  aclii
</h1>

A toolkit for aclii (Anti Command Line Interface Interface)

--------

aclii, The toolkit for abstract command line interface interface
This command line tool takes a simple descriptive configuration file and generates a command line option parser for bash, a completion script, and other useful tools.

(_This command itself will show help and quit. Use subcommands for actions._)

## Usage

  aclii [--file (path to config file)] [--verbose]  <command>
## Options
<h3 id=aclii__file>file</h3>

  --file <file> (default: "./aclii.yml")
      Specify the file path to your aclii config file (aclii.yml)
<h3 id=aclii__verbose>verbose</h3>

  --verbose 

## Sub Commands
 - [put](#aclii-put)
 - [render](#aclii-render)
 - [playground](#aclii-playground)
 - [aclii-completion](#aclii-aclii-completion)

<h1 id="aclii-put">
  aclii put
</h1>

Put aclii artifacts into specified place.

--------

Writes artifacts based on the config file to the specified file. Writing to the file is automatically aborted if an error occurs or if a problem is found in the deliverable. For general use, this put command should be used.

(_This command itself will show help and quit. Use subcommands for actions._)

## Usage

  aclii put  <command>
## Inherited Options
 - [file](#aclii__file)
 - [verbose](#aclii__verbose)

## Sub Commands
 - [launcher](#aclii-put-launcher)
 - [completion](#aclii-put-completion)
 - [parser](#aclii-put-parser)
 - [manual](#aclii-put-manual)

<h1 id="aclii-put-launcher">
  aclii put launcher
</h1>

Put an auto generated launcher
If specified file already exists, aclii will replace the content with new version.

## Usage

  aclii put launcher target-file(file)

## Arguments
### target-file
File path to be put/replaced newly rendered aclii launcher
## Inherited Options
 - [file](#aclii__file)
 - [verbose](#aclii__verbose)

<h1 id="aclii-put-completion">
  aclii put completion
</h1>

Put an auto generated completion script.
If specified file already exists, aclii will replace the content with new version.

## Usage

  aclii put completion [--target (target)] target-file(file)

## Arguments
### target-file
File path to be put/replaced newly rendered aclii auto-completion script
## Options
<h3 id=aclii_put_completion__target>target</h3>

  --target <completionTarget(bash|zsh)> (default: "bash")
## Inherited Options
 - [file](#aclii__file)
 - [verbose](#aclii__verbose)

<h1 id="aclii-put-parser">
  aclii put parser
</h1>

Put an auto generated arg parser for bash scripts,
If specified file already exists, aclii will replace the content with new version.

## Usage

  aclii put parser target-file(file)

## Arguments
### target-file
File path to be put/replaced newly rendered arg parser
## Inherited Options
 - [file](#aclii__file)
 - [verbose](#aclii__verbose)

<h1 id="aclii-put-manual">
  aclii put manual
</h1>

Put a manual file in markdown format

## Usage

  aclii put manual target-file(file)

## Arguments
### target-file
File path to be put/replaced newly rendered manual markdown file
## Inherited Options
 - [file](#aclii__file)
 - [verbose](#aclii__verbose)

<h1 id="aclii-render">
  aclii render
</h1>

Render bash scripts generated from yaml config file. See sub commands for details.

--------

Render generated contents to STDOUT, for testing.
You can choose one of sub command from the list.

(_This command itself will show help and quit. Use subcommands for actions._)

## Usage

  aclii render  <command>
## Inherited Options
 - [file](#aclii__file)
 - [verbose](#aclii__verbose)

## Sub Commands
 - [completion](#aclii-render-completion)
 - [launcher](#aclii-render-launcher)
 - [parser](#aclii-render-parser)
 - [manual](#aclii-render-manual)

<h1 id="aclii-render-completion">
  aclii render completion
</h1>

Render and print bash auto-completion script to STDOUT.

## Usage

  aclii render completion [--target (target)] 
## Options
<h3 id=aclii_render_completion__target>target</h3>

  --target <completionTarget(bash|zsh)> (default: "bash")
## Inherited Options
 - [file](#aclii__file)
 - [verbose](#aclii__verbose)

<h1 id="aclii-render-launcher">
  aclii render launcher
</h1>

Render and print bash script to launch other program to STDOUT.

## Usage

  aclii render launcher 
## Inherited Options
 - [file](#aclii__file)
 - [verbose](#aclii__verbose)

<h1 id="aclii-render-parser">
  aclii render parser
</h1>

Render and print rendered bare commandline parser, for testing.

## Usage

  aclii render parser 
## Inherited Options
 - [file](#aclii__file)
 - [verbose](#aclii__verbose)

<h1 id="aclii-render-manual">
  aclii render manual
</h1>

Render and print manual of entire commands, in markdown format.

## Usage

  aclii render manual 
## Inherited Options
 - [file](#aclii__file)
 - [verbose](#aclii__verbose)

<h1 id="aclii-playground">
  aclii playground
</h1>

Sub commands of this playgrond do nothing but just echo the command line inputs as parsed JSON, as main program would receive.

--------

The subcommands under playground contain command line parsing and inline scripting demos for the launcher.

(_This command itself will show help and quit. Use subcommands for actions._)

## Usage

  aclii playground  <command>
## Inherited Options
 - [file](#aclii__file)
 - [verbose](#aclii__verbose)

## Sub Commands
 - [hungry](#aclii-playground-hungry)
 - [stuffed](#aclii-playground-stuffed)
 - [run-ls-script](#aclii-playground-run-ls-script)

<h1 id="aclii-playground-hungry">
  aclii playground hungry
</h1>

Eat all args into `.argv`. This is default behavior for commands which have no sub commands.

## Usage

  aclii playground hungry genre(foodgenre) food(string)...

## Arguments
### genre (chinese|french|japanese|ethnic)
Select genre you want to...
### food
## Inherited Options
 - [file](#aclii__file)
 - [verbose](#aclii__verbose)

<h1 id="aclii-playground-stuffed">
  aclii playground stuffed
</h1>

Raise error if non optional values ( started by dash(es) ) are related.

## Usage

  aclii playground stuffed 
## Inherited Options
 - [file](#aclii__file)
 - [verbose](#aclii__verbose)

<h1 id="aclii-playground-run-ls-script">
  aclii playground run-ls-script
</h1>

Inline script demo. You can implement any script in aclii file and execute it instead of main program.

## Usage

  aclii playground run-ls-script 
## Inherited Options
 - [file](#aclii__file)
 - [verbose](#aclii__verbose)

<h1 id="aclii-aclii-completion">
  aclii aclii-completion
</h1>

render completion script for aclii

--------

Prints completion scripts of aclii itself.

## Usage

  aclii aclii-completion [--target (target)] 
## Options
<h3 id=aclii_aclii-completion__target>target</h3>

  --target <completionTarget(bash|zsh)> (default: "bash")
## Inherited Options
 - [file](#aclii__file)
 - [verbose](#aclii__verbose)

