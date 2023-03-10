import MT from '../../lib/MicroTemplate.js'


import test from 'node:test'
import assert from 'node:assert'
import fs from 'fs'
import YAML from 'yaml'
import path from 'path'
import url from 'url'


const here = path.dirname(
  url.fileURLToPath(import.meta.url)
)
const dataPath = path.resolve(here, 'MicroTemplate.test.data.yml')
const dataText = fs.readFileSync(dataPath, 'utf-8')
const data = YAML.parse(dataText)

const mt = new MT({
  searchPath: [ path.resolve( here, 'tmpl' )]
})

function compressSpaces (text) {
  return text
    .replace(/ +/gm, ' ')
    .replace(/\n+/gm, "\n")
    .replace(/^\s+/gm, '')
    .replace(/\s+$/gm, '')
}

data.forEach( (testItem) => {
  if ( testItem.error ) {
    test(testItem.name, (t) => {
      assert.throws( () => {
        mt.render(
          testItem.tmpl,
          testItem.data,
        )
      }, new RegExp(testItem.error))
    })
  }
  else {
    test(testItem.name, (t) => {
      const result = mt.render(
        testItem.tmpl,
        testItem.data,
        { debug: testItem.debug }
      )
      if ( testItem.fail ) {
        assert.notEqual(
          compressSpaces(result),
          compressSpaces(testItem.expect)
        )
      }
      else {
        assert.strictEqual(
          compressSpaces(result),
          compressSpaces(testItem.expect)
        )
      }
    })
  }
})

test("Indent Control", (t) => {
  const tmpl = `
<%= data.name %>
##// setIndent(2)
<%= data.name %>
##// setIndent(0)
<%= data.name %>
`
  const expect = `
tora
  tora
tora
`
  assert.strictEqual(
    mt.render(tmpl, { name: 'tora' }, {debug: false}).replace(/\s+$/mg,''),
    expect.replace(/\s+$/mg,'')
  )
})
