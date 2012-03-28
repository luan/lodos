Lodos.TaskShow = Ember.View.extend
  tagName: "tr"
  classNameBindings: ['task.done']
    
  delete: ->
    @$().hide 'fade', =>
      @task.delete()
  
  didInsertElement: ->
    @$().hide()
    if Lodos.tasksController.get('reverse').indexOf(@task) is 0
      @$().show 'fade'
    else
      @$().show()