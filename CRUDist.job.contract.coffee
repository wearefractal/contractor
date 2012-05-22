job: 'CRUDist'
goal: 'CRUD data with given data store'
models:
  dataStore: 'the archive to perform CRUD on'
services:
  create:
    goal: 'persist given object to data store, return id'
    in:
      model: @Object
    sideEffects:
      dataStore: 'create record in record store'
    out:
      id: @Id
  read:
  update:
  destroy:
