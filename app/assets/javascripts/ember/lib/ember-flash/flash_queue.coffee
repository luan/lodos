Ember.flashQueue = Ember.ArrayProxy.create
  content: []
  contentChanged: ->
    current = Ember.flashController.get("content")
    Ember.flashController.set "content", @objectAt(0)  unless current is @objectAt(0)

  pushFlash: (type, message, heading, icon) ->
    flash = Ember.FlashMessage.create
      message: message
      type: type
      heading: heading
      icon: icon

    @pushObject flash
    @contentChanged()
    flash
