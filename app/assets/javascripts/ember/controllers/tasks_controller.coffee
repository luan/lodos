Lodos.tasksController = Ember.ArrayController.create
  content: Lodos.store.findAll(Lodos.Task)
  percent: 0
  
  createTask: (task) ->
    attrs = 
      description: task.description
      done: false
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

  contentChanged: (->
    done = @filter (task) -> task.get('done')
    percent = Math.round 100 * done.length / @get('length')
    @set 'percent', percent
  ).observes('@each')

  setDone: (task, value) ->
    task.set 'done', value
    Lodos.store.commit()
    @contentChanged()
    
  reverse: (->
    @content.toArray().reverse();
  ).property('content.@each').cacheable()
