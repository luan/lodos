Lodos.TasksIndex = Ember.View.extend
  templateName: 'ember/templates/tasks/index'
  tasksBinding: 'Lodos.tasksController'
  
  init: ->
    @_super()
    @_resetTask()
  
  taskSubmit: (event) ->
    event.preventDefault()
    $input = @$('input[name="description"]')
    
    if @task.description
      @tasks.createTask @task
      @_resetTask()
      Lodos.flash 'success', 'created successfully!', 'Task', 'icon-ok-sign'
    else
      Lodos.flash 'error', 'failed to create, fill in the description!', 'Task', 'icon-remove-sign'

    $input.focus()

  _resetTask: ->
    @set 'task', Ember.Object.create()

  didInsertElement: ->
    @_super()
    @$('.datetime-input').mask('9999-99-99 99:99')