mongoArchivist = require './shared_agents/MongoArchivist'
connectionInfo = require './_models/connectionInfo.coffee'
add = require './_services/add'
request = require './_services/request'

hire = ->
  archivist: mongoArchivist.hire connectionInfo.uri, connectionInfo.port
  add: (todo)->
    add archivist, todo
  request: ->
    request archivist

module.exports.hire = hire
