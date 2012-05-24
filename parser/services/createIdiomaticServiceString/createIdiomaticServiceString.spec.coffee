createIdiomaticServiceString = require './createIdiomaticServiceString'
require 'should'

fs = require 'fs'
writeToFile = require '../writeToFile/writeToFile'
util = require 'util'

describe 'createIdiomaticServiceString', ->
  describe 'when given a service with inputs', ->
    it 'should scaffold out the service', ->
      serviceObject =
        name: "aService"
        in:
          firstArg: "@Number"
          secondArg: "@String"
          thirdArg: "@Object"
          callback: "@Function"

      result = createIdiomaticServiceString serviceObject

      expected = """
                 
                 aService = (firstArg, secondArg, thirdArg, callback)->
                   #type of firstArg is @Number
                   #type of secondArg is @String
                   #type of thirdArg is @Object
                   #type of callback is @Function
                 
                   #TODO this is an auto-scaffolded method

                   callback
                 
                 module.exports = aService
                 """

      result.should.eql expected

  describe 'when given a service with outputs', ->
    it 'should scaffold out the service', ->
      serviceObject =
        name: "outputTestService"
        in:
          arg: "@Number"
          callback: "@Function"
        out:
          aNumber: "@Number"
          aString: "@String"

      result = createIdiomaticServiceString serviceObject

      expected = """
             
               outputTestService = (arg, callback)->
                 #type of arg is @Number
                 #type of callback is @Function
               
                 #TODO this is an auto-scaffolded method
            
                 callback aNumber, aString
                 #type of aNumber is @Number
                 #type of aString is @String
             
               module.exports = outputTestService
                 """

      writeToFile fs, 'result.txt', result, ->

      writeToFile fs, 'expected.txt', expected, ->

      result.should.eql expected
