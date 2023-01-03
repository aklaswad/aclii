import YAML from 'yaml'
import fs from 'fs'
import url from 'url'
import path from 'path'
import render from './MicroTemplate.js'

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
    this.ownOptions
      = (obj.options || []).map( option => new AcliiOption(option) )
    this.description = obj.description
    this.helpstop = obj.helpstop
  }

  get options () {
    return this.parentNode
      ? [
          ...this.ownOptions,
          ...this.parentNode.options
        ]
      : this.ownOptions
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
    this.manual = obj.manual || {}
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

  render (templateFileName) {
    const here = path.dirname(url.fileURLToPath(import.meta.url))
    const tmplPath = path.resolve(here, '../tmpl/', templateFileName)
    const content = fs.readFileSync(tmplPath, 'utf-8')
    return this._render(content)
  }

  _render (templateText) {
    return render(templateText, this, { dataname: 'aclii' })
  }

  manualForCommand (path) {
    return this.manual[path] || ''
  }
}

function walkCommands (func, node) {
  func(node)
  node.commands.forEach( next => walkCommands(func, next))
}

export default Aclii

