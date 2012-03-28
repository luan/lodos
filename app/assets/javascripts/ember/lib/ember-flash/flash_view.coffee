Ember.FlashView = Ember.View.extend
  contentBinding: "Ember.flashController.content"
  classNameBindings: ["alert", "alertType"]
  alert: 'alert'

  alertType: (->
    "alert-#{@content.type}" if @content
  ).property('content.type')

  didInsertElement: ->
    top = parseInt @$().css('top')
    itop = top - 50
    @top = "#{top}px"
    @itop = "#{itop}px"
    @$().hide()
    Ember.flashController.set "view", this

  show: (callback) ->
    @$().css(top: @itop).animate
      top: @top
      opacity: "toggle"
    , 700, callback

  hide: (callback) ->
    @$().css(top: @top).animate
      top: @itop
      opacity: "toggle"
    , 700, callback

