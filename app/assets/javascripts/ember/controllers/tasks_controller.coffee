Lodos.tasksController = Ember.ArrayController.create
  content: Lodos.store.findAll(Lodos.Task)
  
  createTask: (task) ->
    Lodos.store.createRecord Lodos.Task,
      description: task.description
    Lodos.store.commit()
    
  reverse: (->
    @content.toArray().reverse();
  ).property('content.@each').cacheable()
