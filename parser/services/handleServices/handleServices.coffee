applyHooksToServices = require '../applyHooksToServices/applyHooksToServices'
setupServicesDirectoryStructure = require '../setupServicesDirectoryStructure/setupServicesDirectoryStructure'
createIdiomaticServiceString = require '../createIdiomaticServiceString/createIdiomaticServiceString'

handleServices = (fs, pathToDomain, services, callback)->
  hook = (serviceObject)->
    setupServicesDirectoryStructure fs, pathToDomain, ->
      serviceScaffold = createIdiomaticServiceString serviceObject
      fs.open "#{pathToDomain}/services/#{serviceObject.name}/#{serviceObject.name}.coffee", 'w', (err, fd)->
        fs.write fd, serviceData, serviceScaffold, 0, serviceScaffold.length, (err, fd)->
          fs.close fd, (err)->
            throw err if err

  applyHooksToServices fs, services, hook, ->
    console.log 'bar'
    callback()

module.exports = handleServices
