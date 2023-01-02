import YAML from 'yaml'
import fs from 'fs'
import render from './MicroTemplate.js'
//import Completion from './Generator/Completion.js'

const PathSeparator = '.'

class AcliiOption {
  constructor (obj) {
    this.name = obj.name
    this.description = obj.description
    this.want = obj.want
    this.required = obj.required
  }
}

class AcliiNode {
  constructor (obj, parentNode) {
    this.parentNode = parentNode
    this.name = obj.name
    if (!this.name) throw "Name is required"
    this.commands
      = (obj.commands || []).map( command => new AcliiNode(command, this ) )
    this.options
      = (obj.options || []).map( option => new AcliiOption(option) )
    this.description = obj.description
  }

  get path () {
    return this.parentNode ? this.parentNode.path + PathSeparator + this.name : this.name
  }

  get subCommands () {
    const commands = []
    this.commands.forEach(
      c => walkCommands( (n) => commands.push(n), c))
    return commands
  }
}

class Aclii {
  constructor (obj) {
    this.definition = obj
    this.root = new AcliiNode(obj)
    this.commands = {}
    this.allCommands.forEach(
      c => this.commands[c.path] = c )
  }

  static fromFile (filename) {
    const content = fs.readFileSync(filename, 'utf-8')
    const definition = YAML.parse(content)
    return new Aclii(definition)
  }

  get commandName () {
    return this.root.name
  }

  get allCommands () {
    return [ this.root, ...this.root.subCommands ]
  }

  getCommandByPath (path) {
    return this.commands[path]
  }

  toCompletion () {
    const completion = new Completion()
    walkCommands( (node, ancestors) => {
      completion.add( node, ancestors )
    }, this.definition)
    return completion.print(this.definition.name)
  }

  render (templateText) {
    return render(templateText, this, { dataname: 'aclii' })
  }

  toWrapper () {
    
  }
}

function walkCommands (func, node) {
  func(node)
  node.commands.forEach( next => walkCommands(func, next))
}

export default Aclii

