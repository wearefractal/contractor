applyHooksToServices = require '../applyHooksToServices/applyHooksToServices'
setupServicesDirectoryStructure = require '../setupServicesDirectoryStructure/setupServicesDirectoryStructure'
createIdiomaticServiceString = require '../createIdiomaticServiceString/createIdiomaticServiceString'

handleServices = (fs, pathToDomain, services, callback)->
  hook = (serviceObject)->
    setupServicesDirectoryStructure fs, pathToDomain, serviceObject.name, ->
      writeFile fs, pathToDomain, serviceObject, ->
        #TODO create spec scaffolds here

  applyHooksToServices services, hook, ->
    callback()

writeFile = (fs, pathToDomain, serviceObject, callback)->
  serviceScaffold = createIdiomaticServiceString serviceObject
  fs.open "#{pathToDomain}/services/#{serviceObject.name}/#{serviceObject.name}.coffee", 'w', null, (err, fd)->
    fs.write fd, serviceScaffold, 0, serviceScaffold.length, null, (err, fd)->
      fs.close fd, (err)->
        callback()

module.exports = handleServices
