Lodos.tasksController = Ember.ArrayController.create
  content: Lodos.store.findAll(Lodos.Task)
  percent: 0
  
  createTask: (task) ->
    attrs = 
      description: task.description
      done: false
      order: -1
    if task.deadlineDate
      deadlineDateTime = new Date "#{task.deadlineDate} #{task.deadlineTime}"
      attrs.deadline = deadlineDateTime.toString()

    unless attrs.description
      Lodos.flash 'error', 'failed to create, fill in the description!', 'Task', 'icon-remove-sign'
      return false
    else if attrs.deadline and deadlineDateTime <= new Date()
      Lodos.flash 'error', 'failed to create, deadline must be in the future!', 'Task', 'icon-remove-sign'
      return false
    else
      Lodos.flash 'success', 'created successfully!', 'Task', 'icon-ok-sign'

    t = Lodos.store.createRecord Lodos.Task, attrs

    Lodos.store.commit()
    @set 'animate', true
    true

  updateTask: (task) ->
    if task.get 'deadlineDate'
      deadlineDateTime = new Date "#{task.deadlineDate} #{task.deadlineTime}"
      task.set 'deadline', deadlineDateTime
    else
      task.set 'deadlineDate', ''
      task.set 'deadlineTime', ''
      task.set 'deadline', null

    unless task.get 'description'
      Lodos.flash 'error', 'failed to save, fill in the description!', 'Task', 'icon-remove-sign'
      return false
    else if task.get('deadline') and deadlineDateTime <= new Date()
      Lodos.flash 'error', 'failed to save, deadline must be in the future!', 'Task', 'icon-remove-sign'
      return false
    else
      Lodos.flash 'success', 'saved successfully!', 'Task', 'icon-ok-sign'

    Lodos.store.commit()
    @set 'animate', true
    true

  contentChanged: (->
    done = @filter (task) -> task.get('done')
    percent = Math.round 100 * done.length / @get('length')
    @set 'percent', percent
  ).observes('@each')

  setDone: (task, value) ->
    task.set 'done', value
    Lodos.store.commit()
    @contentChanged()
    
  sorted: (->
    @content.toArray().sort (a, b) ->
      a.get('order') - b.get('order')
  ).property('content.@each').cacheable()
