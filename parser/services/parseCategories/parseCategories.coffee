parseCategories = (mainObject, hooks)->
  for category of mainObject
    hooks[category] mainObject[category] if hooks[category]?

module.exports = parseCategories
