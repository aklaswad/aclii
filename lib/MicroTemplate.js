function jsFromTemplate (tmpl, options) {
  const sep = /(?:<%|%>)/
  const parts = tmpl.split(sep)
  options.debug
    && console.error('DEBUG: split: ', parts);
  const code = parts
    .reduce( (acc,cur) => {
      return acc.isText ? {
        str: acc.str
          += "p.push('"
          + cur
            .split(/\r?\n/)
            .map( line => line.replace( /'/g, "\\'") )
            .join("'+" + '"\\n"' + " + '")
          + "')\n",
        isText: false
      } : {
        str: acc.str += (
            /^=/.test(cur)
                 ? 'p.push(' + cur.substr(1) + ")\n"
                 : cur
          ) + "\n",
        isText: true
      }
    }, { isText: true, str: 'const p = [];' })
  return code
}

function render (tmpl, data, options = {} ) {
  options.debug
    && console.error('DEBUG: template: ', tmpl)

  const codeLineHeader = /^##\/\/.*?\n(?!##\/\/)/gms
  const preprocessed =
    tmpl.replace(
      codeLineHeader,
      function (match) {
        const text = match
        const replaced = text.replace(/^##\/\//gm, '');
        return "<%\n" + replaced + "\n%>"
      }
    )
  options.debug
    && console.error('DEBUG: processed: ', preprocessed)
  const code = jsFromTemplate(preprocessed, options)
  options.debug && console.error('DEBUG: generated: ', code.str)
  const dataname = options.dataname || 'data'
  const rendered = (new Function(dataname, code.str + ';return p.join("")'))(data)
  options.debug
    && console.error('DEBUG: rendered: ', rendered)
  return rendered
}

export default render
