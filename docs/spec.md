
aclii spec

# Aclii object

- aclii config must be a YAML (or JSON?) file which includes one dictionary
- root object is called aclii object
- Aclii object is also a command object.

Aclii object can contain these items

### manual

You can write detailed document here. The key must be an ID syntax (path from root to the command, joind by dot `.` ) of each commands e.g. `root.sub1.sub2`.


# Command object


## Items

### name (required)

The name of command. This item can not be omitted. This will be the actual user will enter to the command line.

### description

Short description for the command, to be shown at help page or auto-completion

### helpstop

Optional. If this key has been set to truthy value, the actual call for this command will show help and launcher will be exited.

### bin

Path to the executable file


### script

Inline script

### env

Environment of inline script. aclii just add `#!/usr/bin/env <env>` at the top of inline script and run it.

### argstyle

Specify how aclii launcher will pass the arguments to other programs.
Currently only value `json` is supported. If `json` was specified, aclii will make a JSON document for parsed commandline arguments and options, then encode it to BASE64, and pass it to the target program or inline script.
If argstyle has other value, or ommitted, aclii will pass original args as is to other programs or inline script.


### options[]

Array of Option objects which this command can take.

### wants[]

Array of Argument objects this command will get.

### commands[]

Array of the Command objects which the sub commands of this command


# Option

The words start with two dashes `--`, following a command is interpreted as an option.

You can tell aclii what/how kind options the parent command can take.

Any options must be specified before next sub command or the command's arguments in the command line.

## Reserved options

There are some options reserved by aclii. You can not use these names for your options.

### --help

You don't need to set `help` option. aclii will handle this option on your behalf and show help pages.

### --

Traditional option terminator. When this option was appeared in the line, aclii will stop reading words as option, and think next word must be arguments (or sub command)


## Member of Option object

### name (required)

Name of the option, as user inputs.

### type
 What type of word this option will take. ( Not yet implemented though but `switch`. )

 `switch`: if the option type was set to `switch`, this option do not take next word as it's argument, but just switch this option truthy.
 .
### short ( not implemented )

short name for this option



# Argument

### name

the name of the arguments. User don't need to input this, but this will be diplayed in the help menu, and will be used as dictionary key for JSON style argument transfer.

### description

Description for this argument, which will be appeared in the help text.

### type (not implemented)

Currently aclii do nothing about type, but you can sepcify the type of argument.

### many

If argument has truthy value in `many`, this argument will be array and eat all traling words from command line.

#### So how to go next sub command or arguments?

If `many` type argument is in the middle of the command path, it might be illegal tree. I think, in this case, those child commands will always be ignored.

However, some traditional commands, such as `mv`, take a series of arguments and a special last argument.
This type of argument may be supported in the future, but not at this time at least. For now, please just pick the last item by yourself.
