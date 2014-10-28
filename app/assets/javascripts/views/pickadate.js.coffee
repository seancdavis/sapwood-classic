class App.Views.PickADate extends Backbone.View

  el: 'body'

  initialize: ->
    $('.date-js').pickadate()
    $('.time-js').pickatime()
