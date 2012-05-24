
createIdiomaticServiceString = (serviceObject)->
  signature = createSignature serviceObject
  inputTypeReminder = createTypeReminder serviceObject.in
  body = '\n  #TODO this is an auto-scaffolded method\n\n'
  callback = createCallback serviceObject
  outputTypeReminder = createTypeReminder serviceObject.out
  exports = "\nmodule.exports = #{serviceObject.name}"
  return '\n' + signature + inputTypeReminder + body + callback + outputTypeReminder + exports

createTypeReminder = (serviceCategory)->
  return '' unless serviceCategory? and Object.keys(serviceCategory).length > 0
  reminderArray = ("  #type of #{arg} is #{type}\n" for arg, type of serviceCategory)
  return reminderArray.join ''

createSignature = (serviceObject)->
  signature = "#{serviceObject.name} = "
  if serviceObject.in?
    keys = Object.keys serviceObject.in
    if keys.length > 1
      signature += "("
      signature += keys.join ", "
      signature += ")"
    else if keys.length == 1
      signature += "(#{keys[0]})"
  signature += "->\n"
  return signature

createCallback = (serviceObject)->
  callback = "  callback"
  if serviceObject.out?
    keys = Object.keys serviceObject.out
    if keys.length > 1
      callback += " "
      callback += keys.join ", "
    else if keys.length == 1
      callback += " #{keys[0]}"
    callback += '\n'
  return callback

module.exports = createIdiomaticServiceString
