class App.Views.ImageCropper extends Backbone.View

  el: 'body'

  events:
    'click .image-crop-trigger': 'showModal'

  initialize: ->
    @ajaxPage = new App.Views.AjaxPage

  showModal: (e) ->
    e.preventDefault()
    $.get $(e.target).attr('href'), (data) =>
      @ajaxPage.loadContent('Crop Image', data)
      new App.Views.Tabs
      container = $('.ajax-page-content').find('section.cropper.active').first()
      @initCropper(container)
      $('ul.tabs a').click (e) =>
        container = $("section.cropper.#{$(e.target).data('section')}")
        @initCropper(container)

  initCropper: (container) ->
    img = container.find('img').first()
    c = @getFormCoords(container)
    @cropper = img.Jcrop
      aspectRatio: container.data('ratio')
      setSelect: [c.x, c.y, c.x + c.w, c.y + c.h]
      onSelect: (coords) =>
        @setFormCoords(coords, img, container)
      onChange: (coords) =>
        @setFormCoords(coords, img, container)
    
  setFormCoords: (coords, img, parent) ->
    prefix = "#document_crop_data_#{parent.data('slug')}"
    if coords.w == 0
      $("#{prefix}_x").val($("#{prefix}_x").data('value'))
      $("#{prefix}_y").val($("#{prefix}_y").data('value'))
      $("#{prefix}_crop_width").val($("#{prefix}_crop_width").data('value'))
      $("#{prefix}_crop_height").val($("#{prefix}_crop_height").data('value'))
    else
      $("#{prefix}_x").val        coords.x / img.width() * parent.data('img-width') 
      $("#{prefix}_y").val        coords.y / img.height() * parent.data('img-height')
      $("#{prefix}_crop_width").val    coords.w / img.width() * parent.data('img-width')
      $("#{prefix}_crop_height").val   coords.h / img.height() * parent.data('img-height')

  getFormCoords: (parent) ->
    prefix = "#document_crop_data_#{parent.data('slug')}"
    coords =
      x: parseFloat($("#{prefix}_x").val())
      y: parseFloat($("#{prefix}_y").val())
      w: parseFloat($("#{prefix}_crop_width").val())
      h: parseFloat($("#{prefix}_crop_height").val())
