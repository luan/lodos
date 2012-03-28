Lodos.TasksIndex = Ember.View.extend
  templateName: 'ember/templates/tasks/index'
  tasksBinding: 'Lodos.tasksController'
  
  init: ->
    @_super()
    @_resetTask()
  
  taskSubmit: (event) ->
    event.preventDefault()
    id = @$('input[name="description"]').attr('id').replace('input', '')
    view = Ember.View.views[id]
    
    if @task.description
      @tasks.createTask @task
      @_resetTask()
      Lodos.flash 'success', 'created successfully!', 'Task', 'icon-ok-sign'
      @$(id).removeClass "error"
      view.set 'error', null
    else
      Lodos.flash 'error', 'failed to create!', 'Task', 'icon-remove-sign'
      view.set 'error', "can't be blank"
      @$(id).addClass "error"

    @$('input[name="description"]').focus()

  _resetTask: ->
    @set 'task', Ember.Object.create()