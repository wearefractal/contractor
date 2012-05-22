require 'should'
contract = require '../../shared_mocks/tinyContract.contract'
parseCategories = require '../parseCategories'

describe 'parseCategories', ->
  it 'should call a hook on each major category', ->
    agent = ""
    services = {}
    hooks =
      agent: (object)-> agent = object
      services: (object)-> services = object

    parseCategories contract, hooks

    expectedServices =
      increment:
        in: '@Number'
        out: '@Number'

    agent.should.eql 'TinyAgent'
    services.should.eql expectedServices
