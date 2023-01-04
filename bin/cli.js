#!/usr/bin/env node
import Aclii from '../lib/aclii.js'
import fs from 'fs'
import path from 'path'
import url from 'url'

const Commands = {
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
  Commands['aclii.render.completion']({ options:{file: './aclii.yml'}})
  process.exit(0)
}
const json = Buffer.from(process.argv[2], 'base64').toString();
const opts = JSON.parse(json)

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
