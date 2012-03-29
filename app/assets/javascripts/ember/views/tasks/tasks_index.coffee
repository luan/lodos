Lodos.TasksIndex = Ember.View.extend
  templateName: 'ember/templates/tasks/index'
  tasksBinding: 'Lodos.tasksController'
  
  init: ->
    @_super()
    @_resetTask()
  
  taskSubmit: (event) ->
    event.preventDefault()
    $input = @$('input[name="description"]')
    
    @_resetTask() if @tasks.createTask @task
    $input.focus()

  barPercent: (->
    "width: #{@tasks.get('percent')}%;"
  ).property('tasks.percent')

  _resetTask: ->
    @set 'task', Ember.Object.create()

  didInsertElement: ->
    @_super()
    @$('.date-input').mask('99/99/9999')
    @$('.time-input').mask('99:99')
