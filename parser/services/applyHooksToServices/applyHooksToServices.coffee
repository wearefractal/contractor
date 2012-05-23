
applyHooksToServices = (mainObject, hooks, callback)->
  for service of mainObject
    object = mainObject[service]
    object.name = service
    console.log object
    hooks object
  console.log 'foo'
  callback()

module.exports = applyHooksToServices
