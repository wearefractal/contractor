
writeToFile = (fs, path, buffer, callback)->
  fs.open path, 'w', null, (err, fd)->
    if err
      callback err
    else
      fs.write fd, buffer, 0, buffer.length, null, (err, written, buffer)->
        if err
          callback err
        else
          fs.close fd, (err)->
            callback err

module.exports = writeToFile
