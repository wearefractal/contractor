module.exports =
  agent: 'Contractor'
  external:
    filesystem: 'Writes to filesystem according to contract parsed'
  factory:
    in:
      contractLocation: '@String'
    sideEffects:
      'filesystem'
