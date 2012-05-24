applyHooksToServices = require '../applyHooksToServices/applyHooksToServices'
setupServicesDirectoryStructure = require '../setupServicesDirectoryStructure/setupServicesDirectoryStructure'
createIdiomaticServiceString = require '../createIdiomaticServiceString/createIdiomaticServiceString'
createIdiomaticServiceSpecString = require '../createIdiomaticServiceSpecString/createIdiomaticServiceSpecString'
writeToFile = require '../writeToFile/writeToFile'

handleServices = (fs, pathToDomain, services, callback)->
  hook = (serviceObject)->
    setupServicesDirectoryStructure fs, pathToDomain, serviceObject.name, ->
      writeService fs, pathToDomain, serviceObject, ->
        writeSpec fs, pathToDomain, serviceObject, ->

  applyHooksToServices services, hook, ->
    callback()

writeService = (fs, pathToDomain, serviceObject, callback)->
  serviceScaffold = createIdiomaticServiceString serviceObject
  path = "#{pathToDomain}/services/#{serviceObject.name}/#{serviceObject.name}.coffee"
  writeToFile fs, path, serviceScaffold, ->
    callback()

writeSpec = (fs, pathToDomain, serviceObject, callback)->
  specScaffold = createIdiomaticServiceSpecString serviceObject
  path = "#{pathToDomain}/services/#{serviceObject.name}/#{serviceObject.name}.spec.coffee"
  writeToFile fs, path, specScaffold, ->
    callback()

module.exports = handleServices
