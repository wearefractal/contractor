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
    @fsHistory.push {command: 'open', path: path, flags: flags}
    callback @openError, {path: path, flags: flags}
  write: (fd, buffer, offset, length, position, callback)->
    @fsHistory.push {command: 'write', fd: fd, buffer: buffer, offset: offset, length: length, position: position}
    fd.written = buffer
    callback @writeError, fd
  close: (fd, callback)->
    @fsHistory.push {command: 'close', fd: fd}
    callback @closeError

module.exports = fsMockFactory
