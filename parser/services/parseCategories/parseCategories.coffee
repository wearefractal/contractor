parseCategories = (mainObject, hooks, callback)->
  for category of mainObject
    hooks[category] mainObject[category] if hooks[category]?
  callback()

module.exports = parseCategories
