
setupServicesDirectoryStructure = (fs, pathToDomain, targetService, callback)->
  console.log "fs: #{fs}"
  console.log "pathToDomain: #{pathToDomain}"
  console.log "targetService: #{targetService}"
  console.log "callback: #{callback}"
  setupServicesDir fs, pathToDomain, ->
    setupTargetDir fs, pathToDomain, targetService, ->
      callback()
        
setupServicesDir = (fs, pathToDomain, callback)->
  fs.readdir pathToDomain, (err, dirsInDomain)->
    if dirsInDomain? and 'services' in dirsInDomain
      callback()
    else
      fs.mkdir "#{pathToDomain}/services", ->
        callback()

setupTargetDir = (fs, pathToDomain, targetService, callback)->
  fs.readdir "#{pathToDomain}/services", (err, dirsInServices)->
    if dirsInServices? and targetService in dirsInServices
      callback()
    else
      fs.mkdir "#{pathToDomain}/services/#{targetService}", ->
        callback()

module.exports = setupServicesDirectoryStructure
