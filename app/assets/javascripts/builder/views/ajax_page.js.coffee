class App.Views.AjaxPage extends Backbone.View

  el: 'body'

  template: JST['builder/templates/ajax_page']

  initialize: (options) ->
    guid = @guid()
    $('body').append(@template(klass: guid, id: options.klass))
    @page = $(".ajax-page.#{guid}").first()

  loadContent: (title, content) ->
    $(@page).find('header > .title').html(title)
    $(@page).find('.ajax-page-content').html(content)
    $(@page).addClass('active')
    $(@page).find('header a.close').click (e) =>
      e.preventDefault()
      @closePage()

  clearContent: ->
    $(@page).html('')

  openPage: ->
    $(@page).addClass('active')

  closePage: ->
    $(@page).removeClass('active')

  guid: ->
     "#{parseInt(Date.now())}-#{parseInt(Math.random() * 1000000)}"
