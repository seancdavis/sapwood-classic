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
      for img in $('section.cropper > img')
        $(img).on 'load', =>
          @initCropper($(img))

  initCropper: (img) ->
    parent = img.parents('section.cropper')
    img.Jcrop
      aspectRatio: parent.data('ratio')
      # setSelect: [coords.x, coords.y, coords.w, coords.h]
      onSelect: (coords) =>
        @setFormCoords(coords, img, parent)
      onChange: (coords) =>
        @setFormCoords(coords, img, parent)
    
  setFormCoords: (coords, img, parent) ->
    prefix = "#image_crop_data_#{parent.data('slug')}"
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
