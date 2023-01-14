#!/usr/bin/env node
import Aclii from '../lib/aclii.js'
import fs from 'fs'
import path from 'path'
import url from 'url'

// Fail safe print.
// Throw exception if content is empty

function print (content) {
  if ( content.trim().length === 0 ) {
    throw "Aclii error: rendered content is empty."
  }
  console.log(content)
}

function put (opt, tmpl, to) {
  const aclii =  Aclii.fromFile(opts.options.file)
  const content = aclii.render('launcher.tmpl')
  if ( content.trim().length === '0' ) {
    throw "(aclii)Error: Failed to render content"
  }
  fs.writeFileSync(to, content)
}

const Commands = {
  "aclii.aclii-completion": (opt) => {
    const aclii = Aclii.fromFile(Aclii.ConfigPath())
    print( aclii.render(
      opt.options.target === 'zsh' ? 'zsh_completion.tmpl'
                                   : 'bash_completion.tmpl' ) )
  },
  "aclii.render.parser-debugger": (opt) => {
    const aclii = Aclii.fromFile(opts.options.file)
    print( aclii.render('test/parser-debugger.tmpl'))
  },

  "aclii.render.parser-tester": (opt) => {
    const aclii = Aclii.fromFile(opts.options.file)
    print( aclii.render('test/parser-test.tmpl'))
  },

  "aclii.put.parser": (opt) => {
    put( opt, 'bash_runner.tmpl', opt.options['target-file'] )
  },

  "aclii.put.completion": (opt) => {
    const tmpl =
      opt.options.target === 'zsh' ? 'zsh_completion.tmpl'
                                   : 'bash_completion.tmpl'
    put( opt, tmpl, opt.options['target-file'] )
  },

  "aclii.put.launcher": (opt) => {
    put( opt, 'launcher.tmpl', opt.options['target-file'] )
  },

  "aclii.render.parser": (opt) => {
    const aclii = Aclii.fromFile(opts.options.file)
    print( aclii.render('bash_runner.tmpl'))
  },

  "aclii.render.completion": (opt) => {
    const aclii =  Aclii.fromFile(opts.options.file)
    print( aclii.render(
      opt.options.target === 'zsh' ? 'zsh_completion.tmpl'
                                   : 'bash_completion.tmpl' ) )
  },

  "aclii.render.launcher": (opts) => {
    const aclii =  Aclii.fromFile(opts.options.file)
    print( aclii.render('launcher.tmpl'))
  },

  "aclii.playground": (opts) => {
    console.log("Thank you for playing!")
    console.log("----------------------")
    console.log(JSON.stringify(opts,null,2))
  }
}

if ( process.env.ACLII_FORCE_BUILD ) {
  Commands['aclii.render.launcher']({ options:{file: './aclii.yml'}})
  process.exit(0)
}

if ( ! process.argv[2] ) {
  console.error("Argument is required")
  process.exit(1)
}

let json
try {
  json = Buffer.from(process.argv[2], 'base64').toString();
}
catch (e) {
  // given args are not base64.
  console.error("1st argument must be BASE64 digest of JSON")
  process.exit(1)
}

let opts
try {
  opts = JSON.parse(json.trim())
}
catch (e) {
  console.error("Given digested JSON was invalid.")
  process.exit(1)
}

if ( process.env.ACLII_DEBUG ) {
  console.error("DEBUG REPORT FROM ACLII CLI")
  console.error(JSON.stringify({ "ARG-JSON": opts }, null, 2))
}
const command = Commands[opts.command] || Commands[opts.binpath]
if (command) {
  command(opts)
}
else {
  console.error("Unknown command: " + command)
  process.exit(1)
}
