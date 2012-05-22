fsMockFactory = ->
  readdirError: ''
  openError: ''
  writeError: ''
  closeError: ''
  mkdirError: ''
  readdirFiles: {}
  fsHistory: []
  readdir: (path, callback)->
    @fsHistory.push {command: 'readdir', path: path}
    callback @readdirError, @readdirFiles[path]
  mkdir: (path, callback)->
    @fsHistory.push {command: 'mkdir', path: path}
    callback @mkdirError
  open: (path, flags, mode, callback)->
    @fsHistory.push {command: 'open', path: path, mode: mode}
    callback @openError, {path: path, mode: mode}
  write: (fd, buffer, offset, length, position, callback)->
    @fsHistory.push {command: 'write', fd: fd, buffer: buffer}
    position.should.eql NULL
    offest.should.eql 0
    length.should.eql buffer.length
    fd.written = buffer
    callback @writeError, fd
  close: (callback)->
    @fsHistory.push {command: 'close'}
    callback @closeError

module.exports = fsMockFactory
