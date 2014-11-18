class App.Views.AjaxPage extends Backbone.View

  el: '#ajax-page'

  loadContent: (content) ->
    $(@el).html(content)
    $(@el).addClass('active')

  clearContent: ->
    $(@el).html('')
