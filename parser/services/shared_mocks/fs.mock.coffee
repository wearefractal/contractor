fsMockFactory = ->
  readdirError: ''
  openError: ''
  writeError: ''
  closeError: ''
  readdirFiles: []
  readdir: (path, callback)->
    callback @readdirError, readdirFiles
  open: (path, flags, mode, callback)->
    callback @openError, {path: path, mode: mode}
  write: (fd, buffer, offset, length, position, callback)->
    position.should.eql NULL
    offest.should.eql 0
    length.should.eql buffer.length
    fd.written = buffer
    callback @writeError, fd
  close: (callback)->
    callback @closeError

module.exports = fsMockFactory
