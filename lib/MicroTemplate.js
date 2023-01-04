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
    for (const sp of this.searchPath) {
      const filepath = path.resolve( sp, filename )
      console.error({filepath})
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
            += "addline('"
            + cur
              .split(/\r?\n/)
              .map( line => line.replace( /'/g, "\\'") )
              .join("'+" + '"\\n"' + " + '")
            + "')\n",
          isText: false
        } : {
          str: acc.str += (
              /^=/.test(cur)
                   ? 'addline(' + cur.substr(1) + ")\n"
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

  render (tmpl, data, options = {} ) {
    options.debug
      && console.error('DEBUG: template: ', tmpl)

    const codeLineHeader = /^##\/\/.*?\n(?!##\/\/)/gms
    const preprocessed =
      tmpl.replace(
        codeLineHeader,
        function (match) {
          const text = match
          const replaced = text.replace(/^##\/\//gm, '');
          return "\n##//<%" + replaced + "%>\n"
        }
      )
    options.debug
      && console.error('DEBUG: processed: ', preprocessed)
    const code = this.jsFromTemplate(preprocessed, options)
    options.debug && console.error('DEBUG: generated: ', code.str)
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
