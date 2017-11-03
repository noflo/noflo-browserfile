noflo = require 'noflo'

# @runtime noflo-browser

exports.getComponent = ->
  c = new noflo.Component
  c.icon = 'file'
  c.description = 'Read a file object and output its content as data URL string.'
  c.inPorts.add 'file',
    datatype: 'object'
    description: 'file object'
  c.outPorts.add 'out',
    datatype: 'string'
  c.outPorts.add 'error',
    datatype: 'object'
  c.forwardBrackets =
    file: ['out', 'error']
  c.process (input, output) ->
    return unless input.hasData 'file'
    file = input.getData 'file'
    reader = new FileReader()
    reader.onload = (e) ->
      output.sendDone
        out: e.target.result
    reader.onerror = (err) ->
      output.done err
    reader.readAsDataURL file
