class App.Routers.Router extends Backbone.Router

  initialize: ->
    @autoLoadClass()

  autoLoadClass: =>
    new App.Views.DefaultHelpers
    new App.Views.Header
    new App.Views.Tabs if $('ul.tabs').length > 0
    new App.Views.PickADate if $('.time-js').length > 0 || $('.date-js').length > 0
    new App.Views.FieldForm if $('.field-data-type').length > 0
    new App.Views.ImageCropper if $('.image-crop-trigger').length > 0

  routes:
    'sites/:site_slug/page_types/:page_type_slug/edit': 'editPageType'
    'sites/:site_slug/pages/new': 'newPage'
    'sites/:site_slug/pages/:page_slug/edit': 'editPage'
    'sites/:site_slug/images': 'images'

  editPageType: (site_slug, page_type_slug) ->
    new App.Views.DeleteGroup

  newPage: (site_slug) ->
    new App.Views.Publishable
    if $('.image-upload-trigger').length > 0
      new App.Views.PageImageUploader
        site: site_slug

  editPage: (site_slug, page_slug) ->
    new App.Views.Publishable
    if $('.image-upload-trigger').length > 0
      new App.Views.PageImageUploader
        site: site_slug

  images: (site_slug) ->
    new App.Views.ImageUploader
