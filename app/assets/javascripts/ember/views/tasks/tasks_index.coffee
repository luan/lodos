Lodos.TasksIndex = Ember.View.extend
  templateName: 'ember/templates/tasks/index'
  tasksBinding: 'Lodos.tasksController'
  
  init: ->
    @_super()
    @_resetTask()

  taskCancel: (event) ->
    event.preventDefault()
    @_resetTask()
    $input = @$('input[name="description"]')
    $input.focus()
  
  taskSubmit: (event) ->
    event.preventDefault()
    $input = @$('input[name="description"]')
    
    if @task.isNew
      @_resetTask() if @tasks.createTask @task
    else
      @_resetTask() if @tasks.updateTask @task
    $input.focus()

  barPercent: (->
    "width: #{@tasks.get('percent')}%;"
  ).property('tasks.percent')

  _resetTask: ->
    @set 'task', Ember.Object.create(isNew: true)

  didInsertElement: ->
    @_super()
    @$('.date-input').mask('99/99/9999')
    @$('.time-input').mask('99:99')
    @$('[rel="tooltip"]').tooltip()
