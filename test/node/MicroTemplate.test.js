import render from '../../lib/MicroTemplate.js'
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

function compressSpaces (text) {
  return text
    .replace(/ +/gm, ' ')
    .replace(/\n+/gm, "\n")
    .replace(/^\s+/gm, '')
    .replace(/\s+$/gm, '')
}

data.forEach( (testItem) => {
  test(testItem.name, (t) => {
    const result = render(
      testItem.tmpl,
      testItem.data,
      //{ debug: true }
    )
    assert.strictEqual(
      compressSpaces(result),
      compressSpaces(testItem.expect)
    )
  })
})
