require 'should'
contract = require '../shared_mocks/tinyContract.contract'
parseCategories = require './parseCategories'

describe 'parseCategories', (done)->
  it 'should call a hook on each major category', (done)->
    agent = ""
    services = {}
    hooks =
      agent: (object)-> agent = object
      services: (object)-> services = object

    expectedServices =
      increment:
        in: '@Number'
        out: '@Number'

    parseCategories contract, hooks, ->
      agent.should.eql 'TinyAgent'
      services.should.eql expectedServices
      done()
