
createIdiomaticServiceString = (serviceObject)->
  signature = createSignature serviceObject
  typeReminder = createTypeReminder serviceObject
  body = '\n  #TODO this is an auto-scaffolded method'
  exports = "\n\nmodule.exports = #{serviceObject.name}"
  return '\n' + signature + typeReminder + body + exports

createTypeReminder = (serviceObject)->
  return '' unless serviceObject.in? and Object.keys(serviceObject.in).length > 0
  reminderArray = ("  #type of #{arg} is #{type}\n" for arg, type of serviceObject.in)
  return reminderArray.join ''

createSignature = (serviceObject)->
  signature = "#{serviceObject.name} = "
  if serviceObject.in?
    keys = Object.keys serviceObject.in
    if keys.length > 1
      signature += "("
      signature += keys.join ", "
      signature += ")"
  signature += "->\n"
  return signature

module.exports = createIdiomaticServiceString
