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

    name.should.contain 'service1'
    name.should.contain 'service2'
    inElement.should.contain 'foo'
    inElement.should.contain 'baz'
    out.should.contain 'bar'
    out.should.contain 'xyzzy'
