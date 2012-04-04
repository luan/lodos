Lodos.TaskShow = Ember.View.extend
  tagName: "li"
  classNameBindings: ['task.done']

  description: (->
    descr = @get('task').get('description')
    descr = descr.replace '[feature]', '<span class="label label-success">feature</span>'
    descr = descr.replace '[bug]', '<span class="label label-danger">feature</span>'
    descr = descr.replace '[layout]', '<span class="label label-info">feature</span>'
    descr
  ).property('task.description')

  delete: ->
    @$().slideUp =>
      @task.delete()

  edit: ->
    parent = @get 'parentView'
    parent.set 'task', @task
  
  didInsertElement: ->
    @$().hide()
    if Lodos.tasksController.get 'animate'
      @$().slideDown()
      Lodos.tasksController.set 'animate', false
    else
      @$().show()