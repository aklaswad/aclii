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

class AcliiInput {
  constructor (obj, owner, aclii) {
    this.id = aclii.items++
    this.name = obj.name
    this.path = owner.path + ":" + this.name
    this.description = obj.description
    this.type = obj.type
    this.many = obj.many || false
    this.defaultValue = obj['default']
    aclii.installInput(this)
  }
}

class AcliiOption {
  constructor (obj, owner, aclii) {
    this.id = aclii.items++
    this.name = obj.name
    this.path = owner.path + "@" + this.name
    this.description = obj.description
    this.defaultValue = obj["default"]
    this.input = new AcliiInput({
      name: this.name,
      type: obj.type || "switch",
      description: this.description,
      "default": this.defaultValue,
      required:  obj.required
    }, this, aclii)

    this.inherit = obj.inherit
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
    this.bin = obj.bin || (owner ? owner.bin : '')
    this.binPath = (obj.script || obj.bin) ? this.path : owner.binPath
    this.ownOptions
      = (obj.options || []).map( option => new AcliiOption(option, this, aclii ) )
    this.inheritedOptions = owner ? owner.options.filter(o => o.inherit ) : []
    this.commands
      = (obj.commands || []).map( command => new AcliiNode(command, this, aclii ) )
    this.description = obj.description
    this.helpstop = obj.helpstop
    const reverseWants = ( obj.wants || [] ).map( input => new AcliiInput( input, this, aclii )).reverse()
    let lastId;
    reverseWants.forEach( input => {
      if ( lastId ) { input.next = lastId }
      lastId = input.inputId
    })
    this.wants = reverseWants.reverse()
    this.want = this.wants[0]
    this.env = obj.env
    this.script = obj.script
    this.argv = obj.argv
  }

  get options () {
    return [
      ...this.ownOptions,
      ...this.inheritedOptions
    ]
  }

  get inputsWithDefaults () {
    return [
      ...this.options.filter( o => o.input.defaultValue ).map( o => o.input ),
      ...this.wants.filter( w => w.defaultValue )
    ]
  }

  // force path (like 'foo.bar') into env safe string
  get hashedPath () {
    return 'node' + crypto.createHash('md5').update(this.path).digest('hex')
  }

  get subCommands () {
    const flatten = this.commands.flatMap( c => c.subCommands )
    return [ ...flatten, ...this.commands ]
  }
}

class Aclii {
  constructor (obj) {
    this.items = 1 // reserve 0 for special meaning in parser
    this.definition = obj
    this.inputs = []
    this.commands = {}
    this.optionSets = []

    // Load nodes recursively
    this.root = new AcliiNode(obj, null, this)
    // Then revisit them to reduce some info
    this.__dupedSets = {}
    this.allCommands.forEach( c => this.installNode(c) )
    delete this.__dupedSets

    this.manual = obj.manual || {}
  }

  installNode (node) {
    const digestOfOptions = [
      ...node.ownOptions.map( o => o.id ),
      ...node.inheritedOptions.map( o => -1 * o.id )
    ].sort().join(':')
    if ( this.__dupedSets[digestOfOptions] ) {
      node.optionSetId = this.__dupedSets[digestOfOptions]
    }
    else {
      this.optionSets.push([
        node.ownOptions,
        node.inheritedOptions
      ])
      const setId = this.optionSets.length - 1
      node.optionSetId = setId
      this.__dupedSets[digestOfOptions] = setId
    }
  }

  installInput (input) {
    this.inputs.push(input)
    input.inputId = this.inputs.length - 1
  }

  static fromFile (filename) {
    if ( process.env.ACLII_DEBUG ) {
      console.error("Loading aclii config file from '" + filename + "'...")
    }
    let content
    let definition
    try {
      content = fs.readFileSync(filename, 'utf-8')
    }
    catch (e) {
      throw "aclii error: Failed to load aclii config file. For some aclii commands, you need to move to the directory with your aclii.yml file, or set '--file' option.\n" + e
    }
    try {
      definition = YAML.parse(content)
    }
    catch (e) {
      throw "aclii error: Failed to load YAML file. Please check the syntax of your config file.\n" + e
    }
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

  static ConfigPath () {
    return path.resolve( AcliiRoot, 'aclii.yml' )
  }
}

function walkCommands (func, node) {
  func(node)
  node.commands.forEach( next => walkCommands(func, next))
}

export default Aclii

