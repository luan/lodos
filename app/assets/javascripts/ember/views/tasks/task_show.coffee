Lodos.TaskShow = Ember.View.extend
  tagName: "li"
  classNameBindings: ['task.done']
    
  delete: ->
    @$().slideUp =>
      @task.delete()
  
  didInsertElement: ->
    @$().hide()
    if Lodos.tasksController.get 'animate'
      @$().slideDown()
      Lodos.tasksController.set 'animate', false
    else
      @$().show()