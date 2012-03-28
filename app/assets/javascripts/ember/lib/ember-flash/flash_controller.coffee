Ember.flashController = Ember.Object.create
  content: null

  contentChanged: (->
    if @content
      @view.show()
      setTimeout @clearContent, 3000, @content, @view
      , 3000
    else
      Ember.flashQueue.contentChanged()
  ).observes("content")

  clearContent: (content, view) ->
    view.hide ->
      Ember.flashQueue.removeObject content
    Ember.flashQueue.contentChanged()
