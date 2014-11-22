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
        @initCropper($(img))

  initCropper: (img) ->
    parent = img.parents('section.cropper')
    coords = @initFormCoords(parent)
    minWidth = parent.data('min-width')
    minHeight = parent.data('min-height')
    img.Jcrop
      aspectRatio: parent.data('ratio')
      setSelect: [coords.x, coords.y, coords.w, coords.h]
      minSize: [minWidth, minHeight]
      onSelect: (coords) =>
        @setFormCoords(coords, img, parent.data('slug'))
      onChange: (coords) =>
        @setFormCoords(coords, img, parent.data('slug'))

  initFormCoords: (container) ->
    fCoords = @getFormCoords(container.data('slug'))
    coords = 
      x: if fCoords.x then fCoords.x else 0
      y: if fCoords.y then fCoords.y else 0
      w: if fCoords.w then fCoords.w else container.data('min-width')
      h: if fCoords.h then fCoords.h else container.data('min-height')
    
  setFormCoords: (coords, img, version) ->
    $("#image_crop_data_#{version}_x").val(coords.x)
    $("#image_crop_data_#{version}_y").val(coords.y)
    $("#image_crop_data_#{version}_width").val(coords.w)
    $("#image_crop_data_#{version}_height").val(coords.h)
    $("#image_crop_data_#{version}_x_p").val(coords.x / img.width())
    $("#image_crop_data_#{version}_y_p").val(coords.y / img.height())
    $("#image_crop_data_#{version}_width_p").val(coords.w / img.width())
    $("#image_crop_data_#{version}_height_p").val(coords.h / img.height())

  getFormCoords: (version) ->
    x: $("#image_crop_data_#{version}_x").val()
    y: $("#image_crop_data_#{version}_y").val()
    w: $("#image_crop_data_#{version}_width").val()
    h: $("#image_crop_data_#{version}_height").val()
