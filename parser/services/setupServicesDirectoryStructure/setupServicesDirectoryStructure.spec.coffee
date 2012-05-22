require 'should'
setupServicesDirectoryStructure = require './setupServicesDirectoryStructure'
fsFactory = require '../shared_mocks/fs.mock'

describe 'setupServicesDirectoryStructure', (done)->
  describe 'when called on a domain with a correct directory structure', (done)->
    it 'should call callback without making modifications', (done)->
      pathToDomain = 'domain'
      targetService = 'foo'
      aFs = fsFactory()
      aFs.readdirFiles[pathToDomain] = ['services']
      aFs.readdirFiles["#{pathToDomain}/services"] = [targetService]
  
      setupDirectoryStructure pathToDomain, targetService, ->
        for element in aFs.fsHistory
          element.command.should.not.eql 'mkdir'
          element.command.should.not.eql 'open'
          element.command.should.not.eql 'write'
        done()
  
  describe 'when called on a domain with no services directory', (done)->
    it 'should create a services directory', (done)->
      pathToDomain = 'domain'
      targetService = 'foo'
      aFs = fsFactory()
  
      setupDirectoryStructure pathToDomain, targetService, ->
        aFs.fsHistory.should.includeEql {command: 'mkdir', path: "#{pathToDomain}/services"}
        done()
  
  describe 'when called on a domain with no directory for specified service', (done)->
    it 'should create a directory for the service', (done)->
      pathToDomain = 'domain'
      targetService = 'foo'
      aFs = fsFactory()
      aFs.readdirFiles[pathToDomain] = ['services']
  
      setupDirectoryStructure pathToDomain, targetService, ->
        aFs.fsHistory.should.includeEql {command: 'mkdir', path: "#{pathToDomain}/services/#{targetService}"}
        done()


