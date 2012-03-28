Lodos.Task = DS.Model.extend
  primaryKey: '_id'
  description: DS.attr('string')

  didCreateRecord: ->
    @_super()
    console.log 'did'