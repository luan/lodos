Lodos.Task = DS.Model.extend
  primaryKey: '_id'
  description: DS.attr('string')
  done: DS.attr('boolean')
  
  doneChanged: (->
    Lodos.store.commit()
  ).observes('done')
  
  delete: ->
    @deleteRecord()
    Lodos.store.commit()
