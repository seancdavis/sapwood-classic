class App.Routers.Router extends Backbone.Router

  initialize: =>
    @autoLoadClass()

  autoLoadClass: =>
    new App.Views.DefaultHelpers
    new App.Views.Header
    new App.Views.Tabs if $('ul.tabs').length > 0
    new App.Views.PickADate if $('.time-js').length > 0 || $('.date-js').length > 0

  routes:
    'sites/:site_slug/t/:page_type_slug/edit': 'editPageType'

  editPageType: (site_slug, page_type_slug) ->
    new App.Views.DeleteGroup
    new App.Views.PageTypeFieldForm
