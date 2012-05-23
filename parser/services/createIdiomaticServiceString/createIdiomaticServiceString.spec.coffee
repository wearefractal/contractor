createIdiomaticServiceString = require './createIdiomaticServiceString'
require 'should'

fs = require 'fs'

describe 'createIdiomaticServiceString', ->
  describe 'when given a service with inputs', ->
    it 'should scaffold out the service', ->
      serviceObject =
        name: "aService"
        in:
          firstArg: "@Number"
          secondArg: "@String"
          thirdArg: "@Object"

      result = createIdiomaticServiceString serviceObject

      expected = """
                 
                 aService = (firstArg, secondArg, thirdArg)->
                   #type of firstArg is @Number
                   #type of secondArg is @String
                   #type of thirdArg is @Object
                 
                   #TODO this is an auto-scaffolded method
                 
                 module.exports = aService
                 """

      result.should.eql expected
