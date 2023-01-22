#!/usr/bin/env node
import Aclii from '../lib/aclii.js'
import fs from 'fs'
import path from 'path'
import url from 'url'
import child_process from 'child_process'
import tmp from 'tmp'

// Fail safe print.
// Throw exception if content is empty

function print (content) {
  if ( content.trim().length === 0 ) {
    throw "Aclii error: rendered content is empty."
  }
  console.log(content)
}

function put (opt, tmpl, to, options={}) {
  const aclii =  Aclii.fromFile(opts.options.file)
  opt._verbose( "Putting '" + tmpl + "' to " + to )
  const content = aclii.render(tmpl)
  opt._verbose( "Checking renderd content size" )
  if ( content.trim().length === '0' ) {
    throw "(aclii) Error: Failed to render content"
  }
  if ( options.notest ) {
    fs.writeFileSync(to, content)
    opt._verbose("Done")
    return
  }
  opt._verbose( "Checking bash compile errors" )
  const tmpObj = tmp.fileSync()
  const tmpname = tmpObj.name
  opt._verbose( "Created tmpfile at " + tmpname )
  fs.writeFileSync(tmpObj.name, content)
  child_process.exec(
    'bash -n ' + tmpObj.name,
    {
      shell: 'bash',
      encoding: 'utf-8'
    },
    ( error, stdout, stderr ) => {
      if ( error ) {
        opt._verbose("result:" + error)
      }
      if ( stdout ) {
        opt._verbose("got:" + stdout)
      }
      if ( stderr ) {
        opt._verbose(stderr
          .replace(/^/m, '# ')
          .replaceAll(tmpname, '(tmp)'))
      }
      fs.rm(tmpname, (err) => {
        if (err) {
          console.error("(aclii error) Sorry failed to remove tmpfile " + tmpname)
        }
        else {
          opt._verbose("Successfully removed tmpfile")
        }
      })
      if ( error ) {
        throw "(aclii) Error: Failed to render content"
      }
      opt._verbose("Looks good. Writing content into file " + to)
      fs.writeFileSync(to, content)
      opt._verbose("Done")
    }
  )
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

  "aclii.render.manual": (opt) => {
    const aclii = Aclii.fromFile(opts.options.file)
    print( aclii.render('manual.md.tmpl'))
  },

  "aclii.put.parser": (opt) => {
    return put( opt, 'bash_runner.tmpl', opt.options['target-file'] )
  },

  "aclii.put.completion": (opt) => {
    const tmpl =
      opt.options.target === 'zsh' ? 'zsh_completion.tmpl'
                                   : 'bash_completion.tmpl'
    return put( opt, tmpl, opt.options['target-file'] )
  },

  "aclii.put.launcher": (opt) => {
    return put( opt, 'launcher.tmpl', opt.options['target-file'] )
  },

  "aclii.put.manual": (opt) => {
    return put( opt, 'manual.md.tmpl', opt.options['target-file'], { notest: true } )
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

// Inject verbose into opts itself
if ( opts.options.verbose ) {
  opts._verbose = (msg) => console.error('aclii verbose: ' + msg)
}
else {
  opts._verbose = () => {}
}

if ( process.env.ACLII_DEBUG ) {
  console.error("DEBUG REPORT FROM ACLII CLI")
  console.error(JSON.stringify({ "ARG-JSON": opts }, null, 2))
}
const command = Commands[opts.command] || Commands[opts.binpath]
if (command) {
  const retObj = command(opts)
  const ret = retObj instanceof Promise ? await retObj : retObj
}
else {
  console.error("Unknown command: " + command)
  process.exit(1)
}
