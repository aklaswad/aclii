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
  constructor (obj, ownerPath, aclii) {
    this.id = aclii.items++
    this.name = obj.name
    this.description = obj.description
    this.want = obj.want
    this.required = obj.required
    this.defaultValue = obj["default"]
    this.inherit = obj.inherit
    this.path = ownerPath + "@" + this.name
  }

  // force path (like 'foo.bar') into env safe string
  get hashedPath () {
    return 'opt' + crypto.createHash('md5').update(this.path).digest('hex')
  }
}

class AcliiNode {
  constructor (obj, owner, aclii) {
    this.id = aclii.items++
    if (!obj.name) throw "Name is required"
    this.name = obj.name
    this.path = owner ? owner.path + '.' + this.name : this.name
    this.ownOptions
      = (obj.options || []).map( option => new AcliiOption(option, this.path, aclii ) )
    this.inheritedOptions = owner ? owner.options.filter(o => o.inherit ) : []
    this.commands
      = (obj.commands || []).map( command => new AcliiNode(command, this, aclii ) )
    this.description = obj.description
    this.helpstop = obj.helpstop
    this.argv = obj.argv
  }

  get options () {
    return [
      ...this.ownOptions,
      ...this.inheritedOptions
    ]
  }

  // force path (like 'foo.bar') into env safe string
  get hashedPath () {
    return 'node' + crypto.createHash('md5').update(this.path).digest('hex')
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
    this.items = 0
    this.definition = obj
    this.root = new AcliiNode(obj, null, this)
    this.manual = obj.manual || {}
    this.commands = {}
    this.allCommands.forEach(
      c => this.commands[c.path] = c )
  }

  static fromFile (filename) {
    if ( process.env.ACLII_DEBUG ) {
      console.error("Loading aclii config file from '" + filename + "'...")
    }
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

