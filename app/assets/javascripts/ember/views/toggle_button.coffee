Lodos.ToggleButton = Ember.Button.extend
  classNameBindings: ['buttonStyle', 'className', 'toggle:active']
  className: 'done-button'
  toggleBinding: 'task.done'

  setToggle: ->
    iconClass = 'icon-edit'
    buttonStyle = 'btn-warning'

    if @toggle
      iconClass = 'icon-check'
      buttonStyle= 'btn-success'

    iconClass = "icon-white #{iconClass}"
    @set 'iconClass', iconClass
    @set 'buttonStyle', buttonStyle
  
  click: ->
    @set 'toggle', not @toggle
    @setToggle()
    @tasks.setDone @task, @toggle

  didInsertElement: ->
    @setToggle()
