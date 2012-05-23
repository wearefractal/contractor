agent: 'TODOAgent'
worksWith: '@MongoArchivist'
services:
  add:
    in: '@String'
    sideEffects: '@MongoArchivist'
  request:
    sideEffects: '@MongoArchivist'
    out: '@String'
