
createIdiomaticServiceSpecString = (serviceObject)->
  requires = createRequires serviceObject
  callbackTest = createCallbackTest serviceObject
  sideEffectsTests = createSideEffectsTests serviceObject
  return requires + callbackTest + sideEffectsTests

createRequires = (serviceObject)->
  return "require 'should'\n#{serviceObject.name} = require './#{serviceObject.name}'\n\n"

createCallbackTest = (serviceObject)->
  test = "describe '#{serviceObject.name}', (done)->"
  test += "  #TODO it 'should call back with correct values', (done)->"
  test += "    true.should.eql false\n\n"
  test += "\n    done()\n\n"
  return test

createSideEffectsTests = (serviceObject)->
  return createNoSideEffectsTest serviceObject unless serviceObject.sideEffects?
#TODO

createNoSideEffectsTest = (serviceObject)->
  test = "describe '#{serviceObject.name}', (done)->"
  test += "  #TODO it 'should produce no side effects', (done)->"
  test += "    true.should.eql false\n\n\n"
  test += "    done()"
  return test

module.exports = createIdiomaticServiceSpecString
