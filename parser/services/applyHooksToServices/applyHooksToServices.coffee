applyHooksToServices = (mainObject, hooks, callback)->
  for service of mainObject
    object = mainObject[service]
    object.name = service
    hooks object
  callback()

module.exports = applyHooksToServices
