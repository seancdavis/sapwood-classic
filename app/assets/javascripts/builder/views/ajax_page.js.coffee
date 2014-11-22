class App.Views.AjaxPage extends Backbone.View

  el: '#ajax-page'

  loadContent: (title, content) ->
    $(@el).find('header > .title').html(title)
    $(@el).find('.ajax-page-content').html(content)
    $(@el).addClass('active')
    $(@el).find('header a.close').click (e) =>
      e.preventDefault()
      @closePage()

  clearContent: ->
    $(@el).html('')

  openPage: ->
    $(@el).addClass('active')

  closePage: ->
    $(@el).removeClass('active')
