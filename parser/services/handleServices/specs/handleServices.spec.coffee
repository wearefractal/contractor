require 'should'
handleServices = require '../handleServices'

describe 'handleServices', ->
  it 'should call hooks for each service', ->
    name = []
    inElement = []
    out = []

    serviceHook = (serviceObject)->
      name.push serviceObject.name
      inElement.push serviceObject.in
      out.push serviceObject.out

    services =
      service1:
        in: 'foo'
        out: 'bar'
      service2:
        in: 'baz'
        out: 'xyzzy'

    handleServices services, serviceHook

    name.should.include 'service1'
    name.should.include 'service2'
    inElement.should.include 'foo'
    inElement.should.include 'baz'
    out.should.include 'bar'
    out.should.include 'xyzzy'
