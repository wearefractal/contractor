handleServices = (mainObject, hooks)->
  for service of mainObject
    object = mainObject[service]
    object.name = service
    hooks object

module.exports = handleServices
