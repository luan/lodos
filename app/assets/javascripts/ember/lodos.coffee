#= require_tree ./lib
#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./templates
#= require ./routes

window.Lodos = Ember.Application.create  
  layout: Ember.View.create
    templateName: 'ember/templates/layouts/application'

  flash: (type, message, heading, icon) ->
    Ember.flashQueue.pushFlash type, message, heading, icon

Lodos.store = DS.Store.create
  adapter: DS.RESTAdapter.create
    bulkCommit: false      


jQuery -> Lodos.layout.appendTo 'body'
