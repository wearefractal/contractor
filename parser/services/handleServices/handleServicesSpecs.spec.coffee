handleServices = require './handleServices'
createIdiomaticServiceSpecString = require '../createIdiomaticServiceSpecString/createIdiomaticServiceSpecString'

fsFactory = require '../shared_mocks/fs.mock'
require 'should'

describe 'handleServices', ->
  describe 'when dealing with simple contracts', (done)->
    it 'should scaffold default specs based on the contract', (done)->
      fs = fsFactory()
      fs.readdirFiles.pathToDomain = services: {firstService: {}, secondService: {}}
      pathToDomain = 'pathToDomain'

      service =
        aService:
          in:
            stringArg: '@String'
          out:
            output1: '@Number'
            output2: '@Object'

      handleServices fs, pathToDomain, service, ->
        openSpec =
          command: 'open',
          path: 'pathToDomain/services/aService/aService.spec.coffee',
          flags: 'w'
        serviceObject =
          name: 'aService'
          in:
            stringArg: '@String'
          out:
            output1: '@Number'
            output2: '@Object'
        specString = createIdiomaticServiceSpecString serviceObject
        fd = { path: 'pathToDomain/services/aService/aService.spec.coffee', flags: 'w', written: specString }
        writeFd =
          command: 'write',
          fd: fd,
          buffer: specString,
          offset: 0,
          length: specString.length,
          position: null
        closeFd = { command: 'close', fd: fd }

        expectedArray = [openSpec, writeFd, closeFd]

        fs.fsHistory.should.includeEql openSpec
        for i in [1..2]
          fs.fsHistory.should.includeEql expectedArray[i]
          fs.fsHistory.indexOf(expectedArray[i - 1]).should.be.below i
        done()
