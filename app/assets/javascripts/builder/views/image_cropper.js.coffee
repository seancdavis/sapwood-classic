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
    coords = @initFormCoords(img, parent)
    img.Jcrop
      aspectRatio: parent.data('ratio')
      setSelect: [coords.x, coords.y, coords.w, coords.h]
      onSelect: (coords) =>
        @setFormCoords(coords, img, parent)
      onChange: (coords) =>
        @setFormCoords(coords, img, parent)

  initFormCoords: (img, container) ->
    cropImgWidth = img.width()
    cropImgHeight = img.height()
    imgWidth = container.data('img-width')
    imgHeight = container.data('img-height')
    fCoords = @getFormCoords(container.data('slug'))
    coords = 
      x: if fCoords.x then fCoords.x / imgWidth * cropImgWidth else 0
      w: if fCoords.w then fCoords.w / imgWidth * cropImgWidth else container.data('width')
      y: if fCoords.y then fCoords.y / imgHeight * cropImgHeight else 0      
      h: if fCoords.h then fCoords.h / imgHeight * cropImgHeight else container.data('height')
    
  setFormCoords: (coords, img, parent) ->
    prefix = "#image_crop_data_#{parent.data('slug')}"
    $("#{prefix}_x").val        coords.x / img.width() * parent.data('img-width') 
    $("#{prefix}_width").val    coords.w / img.width() * parent.data('img-width')
    $("#{prefix}_y").val        coords.y / img.height() * parent.data('img-height')
    $("#{prefix}_height").val   coords.h / img.height() * parent.data('img-height')

  getFormCoords: (version) ->
    x: $("#image_crop_data_#{version}_x").val()
    w: $("#image_crop_data_#{version}_width").val()
    y: $("#image_crop_data_#{version}_y").val()
    h: $("#image_crop_data_#{version}_height").val()
