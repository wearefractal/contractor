handleServices = require './handleServices'
createIdiomaticServiceString = require '../createIdiomaticServiceString/createIdiomaticServiceString'

fsFactory = require '../shared_mocks/fs.mock'
require 'should'

describe 'handleServices', ->
  describe 'when dealing with very simple contracts', (done)->
    it 'should scaffold default service based on the contract', (done)->
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
        mkdirServices = { command: 'mkdir', path: 'pathToDomain/services' }
        mkdirFirstServices = { command: 'mkdir', path: 'pathToDomain/services/firstService' }
        openFirstServicesCoffee =
          command: 'open',
          path: 'pathToDomain/services/firstService/firstService.coffee',
          flags: 'w'
        firstServiceString = createIdiomaticServiceString { name: 'firstService', in: { stringArg: '@String' } }
        firstFd = { path: 'pathToDomain/services/firstService/firstService.coffee', flags: 'w', written: firstServiceString }
        writeFirstFd =
          command: 'write',
          fd: firstFd,
          buffer: firstServiceString,
          offset: 0,
          length: firstServiceString.length,
          position: null
        closeFirstFd = { command: 'close', fd: firstFd }

        mkdirSecondServices = { command: 'mkdir', path: 'pathToDomain/services/secondService' }
        openSecondServicesCoffee =
          command: 'open',
          path: 'pathToDomain/services/secondService/secondService.coffee',
          flags: 'w'
        secondServiceString = createIdiomaticServiceString { name: 'secondService', in: { arg1: '@Number', arg2: '@Number' } }
        secondFd= { path: 'pathToDomain/services/secondService/secondService.coffee', flags: 'w', written: secondServiceString }
        writeSecondFd =
          command: 'write',
          fd: secondFd,
          buffer: secondServiceString,
          offset: 0,
          length: secondServiceString.length,
          position: null
        closeSecondFd = { command: 'close', fd: secondFd }
       
        firstExpectedArray = [mkdirServices, mkdirFirstServices, openFirstServicesCoffee, writeFirstFd, closeFirstFd]
        secondExpectedArray = [mkdirServices, mkdirSecondServices, openSecondServicesCoffee, writeSecondFd, closeSecondFd]

        fs.fsHistory.should.includeEql mkdirServices
        for i in [1..4]
          fs.fsHistory.should.includeEql firstExpectedArray[i]
          fs.fsHistory.indexOf(firstExpectedArray[i - 1]).should.be.below i
          fs.fsHistory.should.includeEql secondExpectedArray[i]
          fs.fsHistory.indexOf(secondExpectedArray[i - 1]).should.be.below i
        done()

