#!/usr/bin/env node
import Aclii from '../lib/aclii.js'
import fs from 'fs'
import path from 'path'
import url from 'url'

const Commands = {
  "aclii.render.completion": (opts) => {
    const aclii =  Aclii.fromFile(opts.file)
    console.log( aclii.render('bash_completion.tmpl'))
  },

  "aclii.render.launcher": (opts) => {
    const aclii =  Aclii.fromFile(opts.file)
    console.log( aclii.render('launcher.tmpl'))
  }
}

Commands['aclii.render.launcher']({file: './aclii.yml'})
process.exit()
const json = Buffer.from(process.argv[2], 'base64').toString();
const opts = JSON.parse(json)
//Commands[opts.command](opts)
