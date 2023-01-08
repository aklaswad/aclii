import fs from 'fs'
import url from 'url'
import path from 'path'

class MicroTemplate {
  constructor (opts = {}) {
    this.searchPath = []
    if (opts.searchPath) {
      this.searchPath = opts.searchPath
    }
  }

  renderFromFile (tmplFile, data, options) {
    const template = this.loadTemplate(tmplFile)
    return this.render(template, data, options)
  }

  loadTemplate (filename) {
    if ( ! /\.tmpl$/.test(filename) ) {
      throw "Invalid template"
    }
    for (const sp of this.searchPath) {
      const filepath = path.resolve( sp, filename )
      if ( fs.existsSync(filepath) ) {
        return fs.readFileSync(filepath, 'utf-8')
      }
    }
    throw "MicroTemplate: Template not found: " + filename
  }

  jsFromTemplate (tmpl, options) {
    const sep = /(?:<%|%>)/
    const parts = tmpl.split(sep)
    options.debug
      && console.error('DEBUG: split: ', parts);
    const code = parts
      .reduce( (acc,cur) => {
        return acc.isText ? {
          str: acc.str
            += "addline("
            + cur.split('')
              .map( c => c === "\n" ? '"\\n"'
                       : c === "'"  ? '"' + "'" + '"'
                       : c === '\\' ? '"' + '\\' + '\\' + '"'
                       : "'" + c + "'" )
              .join(" + ")
            + ")\n",
          isText: false
        } : {
          str: acc.str += (
              /^=/.test(cur)
                   ? 'addline(' + '"" + (' + cur.substr(1) + "))\n"
                   : cur
            ) + "\n",
          isText: true
        }
      }, {
        isText: true,
        str: `const p = [];
        function setIndent(n){idt=' '.repeat(n)}
        function addline(str){
          if(str){
            p.push((""+str).replace(/\\n/g,"\\n" + idt))
          }}
        let idt='';
      `})
    return code
  }

  preprocess (tmpl) {
    /*
      1. Extend INCLUDE Macros
          Replace with the template contents for lines like this
          `##//INCLUDE templatename.tmpl`
      2. Extend LINE syntax
          replace lines like '^##// code flagments'
          to '<% code flagments %>'

    */
    let included = tmpl
    const includeLineMatcher
      = /^(?:##\/\/|\/\/##)\s*?INCLUDE\s*?(\w[\w.\/]+)\s*?$/m
    while ( includeLineMatcher.test( included ) ) {
      included = included.replace(
        includeLineMatcher, (match,p1) => {
          if ( /\.\./.test(p1) ) {
            throw "Invalid include"
          }
          if ( ! /\.tmpl$/.test(p1) ) {
            throw "Invalid include"
          }
          return this.loadTemplate(p1)
      })
    }

    const codeLinesMatcher = /^(?:##\/\/|\/\/##).*?\n(?!##\/\/|\/\/##)/gms
    const preprocessed =
      included.replace(
        codeLinesMatcher,
        function (match) {
          const text = match
          const replaced = text.replace(/^(?:##\/\/|\/\/##)/gm, '');
          // Left the marker '##//\n' here, and remove them
          // at post process. This could help indent control.
          return "\n##//<%" + replaced + "%>\n"
        }
      )
    return preprocessed
  }

  render (tmpl, data, options = {} ) {
    options.debug
      && console.error('DEBUG: template: ', tmpl)
    const preprocessed = this.preprocess(tmpl)
    options.debug
      && console.error('DEBUG: processed: ', preprocessed)
    const code = this.jsFromTemplate(preprocessed, options)
    options.debug && console.error('DEBUG: generated')
    options.debug && console.error( code.str )
    options.debug && console.error('DEBUG: generated: DUMPED')
    const dataname = options.dataname || 'data'
    const func  = (() => { try {
        return new Function(
          dataname,
          code.str + ';return p.join("")')
      }
      catch (e) {
        throw "Failed to compile template: " + e
      }})()
    const rendered  = (() => { try {
        return func(data)
      }
      catch (e) {
        throw "Failed to render template: " + e
      }})()
    options.debug
      && console.error('DEBUG: rendered: ', rendered)
    return rendered.replace(/^\s*?##\/\/\s*?\n/mg, '')
  }
}

export default MicroTemplate
