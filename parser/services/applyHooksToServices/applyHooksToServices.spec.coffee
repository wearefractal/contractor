require 'should'
applyHooksToServices = require './applyHooksToServices'

describe 'applyHooksToServices', (done)->
  it 'should call hooks for each service', (done)->
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

    applyHooksToServices services, serviceHook, ->
      name.should.include 'service1'
      name.should.include 'service2'
      inElement.should.include 'foo'
      inElement.should.include 'baz'
      out.should.include 'bar'
      out.should.include 'xyzzy'
      done()
