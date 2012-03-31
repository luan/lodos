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
    @$('#tasks').sortable
      update: =>
        array = $("#tasks").children().toArray().filter (e) -> e.tagName is 'LI'
        order = 0
        for e in array
          view = Ember.View.views[$(e).attr 'id']
          view.task.set 'order', order
          order += 1

        Lodos.store.commit()
