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

const json = Buffer.from(process.argv[2], 'base64').toString();
const opts = JSON.parse(json)
console.error(opts)
Commands[opts.command](opts)
