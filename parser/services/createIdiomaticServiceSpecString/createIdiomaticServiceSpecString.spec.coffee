require 'should'
createIdiomaticServiceSpecString = require './createIdiomaticServiceSpecString'

describe 'createIdiomaticServiceSpecString', ->
  #REALTODO need 3 tests: one for when there's an 'out', one for when there are side effects, and one when there are both
  #
  #also test for when there are multiple side effects (should produce an assertion for each)
  describe 'when a service has a callback and no side effects ', ->
    it 'should create an idiomatic spec based on a service object', ->
      serviceObject =
        name: "aService"
        in:
          anArg: "@Number"
        out:
          cbArg1: "@Number"
          cbArg2: "@String"

      result = createIdiomaticServiceSpecString serviceObject

      #REALTODO change callback test to have assert for each expected callback argument
      expected = """
                 require 'should'
                 aService = require './aService'

                 describe 'aService', (done)->
                   #TODO it 'should call back with correct values', (done)->
                     true.should.eql false

                     done()

                 describe 'aService', (done)->
                   #TODO it 'should produce no side effects', (done)->
                     true.should.eql false

                     done()
                 """

      result.should.eql expected
