# aclii

**Another Command Line Interface Interface**

1. Write YAML file to design your command
1. aclii will generate launcher shell script and completion script from it
1. You can get your own powerful command, for your product, and/or every tools you use.

# Use cases

## For quick tool writing

If you're about to start writing some cli tool (in JavaScript? ruby? whatever) but if you're not familiar with that language and/or command option parser, aclii can help you. aclii launcher can parse options instead and launch your tool with options translated into JSON. You just have to `JSON.parse()` and then write the essential tasks.
Also, aclii launcher can show help pages which automatically generated from YAML file.

## For team collaboration

If you're working for monorepo which maintained by multiple teams. For example backend and frontend team. There are many cool tools in both area but they don't know each others' stuff. Since frontend team don't know how to do `perldoc` and backend team don't know how npx is powerful. aclii can solve this situation. Let's put a master launcher and navigate them with powerful auto-completion. If a command `repo test frontend<TAB>` show doable actions, `repo build backend --help` shows documents for them, and of course they are executable from single command. It's wonderful, isn't it? 

## For personal use

I know you have aliases which you wrote into `~/.*shrc` but never invoked, and completely forgot how to use them. How many dead aliases do you have?
aclii launcher can manage those items in single yaml file, with documentation and auto-completion, by just putting personal launcher, since you can write oneliners and scripts in aclii.yml and aclii can run them, like GH actions.
