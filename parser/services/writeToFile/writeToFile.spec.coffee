require 'should'
writeToFile = require './writeToFile'
fsFactory = require '../shared_mocks/fs.mock'

util = require 'util'

describe 'writeToFile', (done)->
  describe 'when given file location and a buffer', (done)->
    it 'should open, write to the file, and close it', (done)->
      fs = fsFactory()
      path = 'foo/bar/baz.txt'
      buffer = "the quick brown fox"

      writeToFile fs, path, buffer, (err)->
        true.should.not.eql err
        fd = { path: path, flags: 'w', written: buffer }
        fs.fsHistory[0].command.should.eql 'open'
        fs.fsHistory[0].path.should.eql path
        fs.fsHistory[0].flags.should.eql 'w'
        fs.fsHistory[1].command.should.eql 'write'
        fs.fsHistory[1].fd.should.eql fd
        fs.fsHistory[1].buffer.should.eql buffer
        fs.fsHistory[1].offset.should.eql 0
        fs.fsHistory[1].length.should.eql buffer.length
        false.should.eql fs.fsHistory[1].position?
        fs.fsHistory[2].command.should.eql 'close'
        fs.fsHistory[2].fd.should.eql fd
        done()

  describe 'when an error occurs during writing', (done)->
    it 'should stop writing and return the error', (done)->
      fs1 = fsFactory()
      fs1.openError = "open error"
      path = 'foo/bar/baz.txt'
      buffer = "the quick brown fox"

      writeToFile fs1, path, buffer, (err)->
        err.should.eql "open error"
        fs2 = fsFactory()
        fs2.writeError = "write error"
        writeToFile fs2, path, buffer, (err)->
          err.should.eql "write error"
          fs3 = fsFactory()
          fs3.closeError = "close error"
          writeToFile fs3, path, buffer, (err)->
            err.should.eql "close error"
            done()
