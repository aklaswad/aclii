#!/usr/bin/env node
import Aclii from '../lib/aclii.js'
import fs from 'fs'
import path from 'path'
import url from 'url'

const Commands = {
  "aclii.render.parser-tester": (opt) => {
    const aclii = Aclii.fromFile(opts.options.file)
    console.log( aclii.render('test/parser-test.tmpl'))
  },

  "aclii.render.parser": (opt) => {
    const aclii = Aclii.fromFile(opts.options.file)
    console.log( aclii.render('parser.tmpl'))
  },

  "aclii.render.completion": (opts) => {
    const aclii =  Aclii.fromFile(opts.options.file)
    console.log( aclii.render('bash_completion.tmpl'))
  },

  "aclii.render.launcher": (opts) => {
    const aclii =  Aclii.fromFile(opts.options.file)
    console.log( aclii.render('launcher.tmpl'))
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

if (/^aclii\.playground\./.test(opts.command)) {
  console.log("Thank you for playing!")
  console.log("----------------------")
  console.log(JSON.stringify(opts,null,2))
}
else {
  const command = Commands[opts.command]
  if (command) {
    command(opts)
  }
  else {
    console.error("Unknown command: " + command)
    process.exit(1)
  }
}
