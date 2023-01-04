import YAML from 'yaml'
import fs from 'fs'
import url from 'url'
import path from 'path'
import crypto from 'crypto'

import MT from './MicroTemplate.js'

const AcliiRoot = path.resolve(
  path.dirname(
    url.fileURLToPath(import.meta.url)), '../')

const AcliiPackage = JSON.parse(
  fs.readFileSync(
    path.resolve( AcliiRoot, 'package.json' ), 'utf-8' ))

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
    this.argv = obj.argv
  }

  get options () {
    return this.parentNode
      ? [
          ...this.ownOptions,
          ...this.parentNode.options
        ]
      : this.ownOptions
  }

  // force path (like 'foo.bar') into env safe string
  get hashedPath () {
    return 'node' + crypto.createHash('md5').update(this.path).digest('hex')
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

  get version () {
    return AcliiPackage.version
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
    const tmplPath = path.resolve(here, '../tmpl/')
    const mt = new MT({ searchPath: [tmplPath] })
    return mt.renderFromFile(templateFileName, this, { dataname: 'aclii' })
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

