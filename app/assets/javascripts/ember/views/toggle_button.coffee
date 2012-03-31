Lodos.ToggleButton = Ember.Button.extend
  classNameBindings: ['buttonStyle', 'className', 'toggle:active']
  className: 'done-button'
  toggleBinding: 'task.done'

  setToggle: ->
    iconClass = 'icon-remove-circle'
    buttonStyle = 'btn-warning'

    if @toggle
      iconClass = 'icon-ok-sign'
      buttonStyle = 'btn-success'

    iconClass = "icon-white #{iconClass}"
    @set 'iconClass', iconClass
    @set 'buttonStyle', buttonStyle
  
  click: ->
    @set 'toggle', not @toggle
    @setToggle()
    @tasks.setDone @task, @toggle

  didInsertElement: ->
    @setToggle()
