handleServices = require './handleServices'
fsFactory = require '../shared_mocks/fs.mock'
require 'should'

describe 'handleServices', ->
  describe 'when dealing with very simple contracts', ->
    it 'should apply default processing to the contract', ->
      fs = fsFactory()
      pathToDomain = 'pathToDomain'

      services =
        firstService:
          in:
            stringArg: '@String'
        secondService:
          in:
            arg1: '@Number'
            arg2: '@Number'

      handleServices fs, pathToDomain, services, ->
        console.log fs.fsHistory
        assert false
#TODO
