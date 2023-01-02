export default function (tmpl, data, options = {} ) {
  const dataname = options.dataname || 'data'
  const sep = /(?:<%|%>)/
  const code = tmpl.split(sep)
    .reduce( (acc,cur) => {
      return acc.isText ? {
        str: acc.str
          += "p.push('"
          + cur
            .split(/\r?\n/)
            .map( line => line.replace( /'/g, "\\'") )
            .join("'+" + '"\\n"' + " + '")
          + "');",
        isText: false
      } : {
        str: acc.str += (
            /^=/.test(cur)
                 ? 'p.push(' + cur.substr(1) + ");"
                 : cur
          ) + "\n",
        isText: true
      }
    }, { isText: true, str: 'const p = [];' })
//  console.log(code.str)
  const rendered = (new Function(dataname, code.str + ';return p.join("")'))(data)
//  console.log(rendered)
  return rendered
}
