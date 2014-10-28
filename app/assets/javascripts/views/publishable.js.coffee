class App.Views.Publishable extends Backbone.View

  el: 'form'

  events:
    'click a.save.publish': 'saveAndPublish'
    'click a.save.draft': 'saveAsDraft'

  saveAndPublish: (e) ->
    e.preventDefault()
    $('#page_published').attr('checked', true)
    $(e.target).parents('form').submit()

  saveAsDraft: (e) ->
    e.preventDefault()
    $('#page_published').attr('checked', false)
    $(e.target).parents('form').submit()
