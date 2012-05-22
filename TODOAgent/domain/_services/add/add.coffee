
add = (archivist, todo)->
  data = {todo: todo, timestamp:Date.now()}
  archivist.create data

module.exports = add
