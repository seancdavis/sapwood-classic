class App.Routers.Router extends Backbone.Router

  initialize: =>
    @autoLoadClass()

  autoLoadClass: =>
    new App.Views.DefaultHelpers
    new App.Views.Header
    new App.Views.Tabs if $('ul.tabs').length > 0

  routes:
    '': 'initHomePage'

  initHomePage: ->
    console.log "Welcome to this awesome site, built using Cambium!"
