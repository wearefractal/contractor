agent: 'MongoArchivist'
isAn: @CRUDist
external:
  mongoDB: 'Data store for persistence operations'
services:
  mapReduce:
    in:
      query: @Object
      callback: @Function
    sideEffects:
      mongoDB
    out:
      results: @Array
factory:
  in:
    uri: @String
    port: @Number
  sideEffects:
    mongoDB
