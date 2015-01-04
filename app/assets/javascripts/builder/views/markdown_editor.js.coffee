class App.Views.MarkdownEditor extends Backbone.View

  # ------------------------------------------ Setup

  # Templates
  imageTemplate: JST['admin/templates/image']

  # Elements
  el: 'body'
  # other elements are referenced from the initElements() 
  # method to ensure they wait until the page is loaded

  # Text / Parse Controls
  storedMarkdown: ''
  parseInterval: 2500

  # Caret Controls
  caretStart: 0
  caretEnd: 0

  # Key Controls
  meta: false
  shift: false

  # History Control
  textHistory: [$('textarea')[0].value]
  caretStartHistory: [0]
  caretEndHistory: [0]
  historyControl: 0
  busy: false

  initialize: (options) ->
    @initElements(options)
    @bindEvents()
    @interval = setInterval(@parseMarkdown, @parseInterval)

  initElements: (options) ->
    @page = $('.ajax-page.markdown-editor')
    @wysiwygField = $(options.wysiwygField)
    @markdownField = $(options.markdownField)
    @textareaJQ = @page.find('textarea')
    @textarea = @textareaJQ[0]
    # @initImageUploader()
    @toolbars = 
      main: @page.find('div.toolbar')
      link: @page.find('div.toolbar.link')
      image: @page.find('div.toolbar.image')

  # ------------------------------------------ Update Markdown

  parseMarkdown: () =>
    unless @textarea.value == @storedMarkdown
      url = $('#markdown_editor').data('autosave')
      data = $('#markdown_editor').serialize()
      @storedMarkdown = @textarea.value
      $.post url, data, (result) =>
        $('.right.half .content').html(result.html)
        $('#last-saved > span').text(new Date().toLocaleTimeString())
        @markdownField.val(@textarea.value)
        @wysiwygField.val(result.html)


  # ------------------------------------------ Event Controls

  bindEvents: ->
    @textareaJQ.on 'keydown', @keydownControl
    @textareaJQ.on 'keyup', @keyupControl
    @textareaJQ.on 'mousedown', @mousedownControl
    @textareaJQ.on 'mouseup', @mouseupControl

  keydownControl: (e) =>
    @meta = e.metaKey; @shift = e.shiftKey
    if @meta && @shift
      e.preventDefault() if @initMetaShiftShortcut(e.keyCode)
    else if @meta && !@shift
      e.preventDefault() if @initMetaShortcut(e.keyCode)
    else if !@meta && !@shift
      if (
        @initWrapperShortcut(e.keyCode) || 
        @initReplaceShortcut(e.keyCode)
      )
        e.preventDefault()

  keyupControl: (e) =>
    @updateCaretRange()
    @newSnaphot()

  mousedownControl: (e) =>
    @updateCaretRange()

  mouseupControl: (e) =>
    @updateCaretRange()

  # ------------------------------------------ History Control

  newSnaphot: =>
    return @busy = false if @busy
    snapshot = @textarea.value
    if snapshot == @textHistory[@historyControl]
      @caretStartHistory[@historyControl] = @caretStart
      @caretEndHistory[@historyControl] = @caretEnd
    else
      @historyControl++
      @caretStartHistory.splice(@historyControl)
      @caretStartHistory.push(@caretStart)
      @caretEndHistory.splice(@historyControl)
      @caretEndHistory.push(@caretEnd)
      @textHistory.splice(@historyControl)
      @textHistory.push(snapshot)

  undo: =>
    unless @historyControl == 0
      @historyControl--; @setHistory(@historyControl)

  redo: =>
    unless @historyControl == (@textHistory.length - 1)
      @historyControl++; @setHistory(@historyControl)

  setHistory: (idx) =>
    @textarea.value = @textHistory[idx]
    @placeCaret(@caretStartHistory[idx], @caretEndHistory[idx])
    @busy = true

  # ------------------------------------------ Caret / Cursor Control

  getCaretOffset: (charsAdded) =>
    @caretStart + @selectedText().length + charsAdded

  updateCaretRange: =>
    @caretStart = @textarea.selectionStart
    @caretEnd = @textarea.selectionEnd

  caretLineRange: =>
    charCount = 0; recording = false; range = []
    for line, idx in @textLines()
      startLine = charCount; endLine = charCount + line.length
      charCount = endLine + 1
      recording = true if @caretStart >= startLine && @caretStart <= endLine
      range.push(idx) if recording
      recording = false if @caretEnd >= startLine && @caretEnd <= endLine
      recording = false if @caretEnd == charCount && @textIsSelected()
    range

  placeCaret: (start, end = start) =>
    @textarea.setSelectionRange(start, end)

  # ------------------------------------------ Text Control

  selectedText: =>
    @textarea.value.substring(@caretStart, @caretEnd)

  textIsSelected: =>
    @selectedText().length > 0

  beforeSelectedText: =>
    @textarea.value.substring(0, @caretStart)

  afterSelectedText: =>
    @textarea.value.substring(@caretEnd, @textarea.value.length)

  replaceSelection: (newText) =>
    @textarea.value = @beforeSelectedText() + newText + @afterSelectedText()

  textLines: =>
    @textarea.value.split("\n")

  textBeforeLine: (line) =>
    text = ''
    for lineText, idx in @textLines()
      text = "#{text}#{lineText}\n" if idx < line
    text

  textAfterLine: (line) =>
    text = ''
    for lineText, idx in @textLines()
      text = "#{text}#{lineText}\n" if idx > line
    text

  replaceLine: (line, newText) =>
    @textarea.value = @textBeforeLine(line) + "#{newText}\n" + @textAfterLine(line)

  # ------------------------------------------ Meta-Shift Shortcut Controls

  initMetaShiftShortcut: (k) =>
    if k.toString() of @metaShiftShortcutsRef()
      @metaShiftShortcut(@metaShiftShortcutsRef()[k.toString()])
      return true
    false

  metaShiftShortcutsRef: ->
    '90': 'redo' # z

  metaShiftShortcut: (action) =>
    switch action
      when 'redo' then @redo()

  # ------------------------------------------ Meta Shortcut Controls

  initMetaShortcut: (k) =>
    if k.toString() of @metaShortcutsRef()
      @metaShortcut(@metaShortcutsRef()[k.toString()])
      return true
    false

  metaShortcutsRef: ->
    '73': 'image'     # i
    '75': 'link'      # k
    '90': 'undo'      # z
    '221': 'indent'   # ]
    '219': 'deIndent' # [

  metaShortcut: (action) =>
    switch action
      when 'image' then @insertImage()
      when 'link' then @insertLink()
      when 'undo' then @undo()
      when 'indent' then @indent()
      when 'deIndent' then @deIndent()

  # ------------------------------------------ Wrapping Text

  initWrapperShortcut: (k) =>
    if k.toString() of @wrapperShortcutRef()
      @wrapperShortcut(@wrapperShortcutRef()[k.toString()])
      return true
    false

  wrapperShortcutRef: ->
    '192': '`'

  wrapperShortcut: (char) =>
    if @textIsSelected()
      @wrapText(char)
    else
      @insertCharacter(char)

  # ------------------------------------------ Replacing Text

  initReplaceShortcut: (k) =>
    if k.toString() of @replaceShortcutRef()
      @replaceShortcut(@replaceShortcutRef()[k.toString()])
      return true
    false

  replaceShortcutRef: ->
    '9': '  '

  replaceShortcut: (char) =>
    @replaceSelection(char)
    @placeCaret(@caretStart + 2)

  # ------------------------------------------ Indentation

  indent: =>
    @updateCaretRange()
    caretEnd = @caretStart + 2
    caretEnd = @caretEnd + (@caretLineRange().length * 2) if @textIsSelected()
    for line in @caretLineRange()
      @replaceLine(line, "  #{@textLines()[line]}")
      @placeCaret(@caretStart + 2, caretEnd)

  deIndent: =>
    @updateCaretRange()
    indentedSpaces = 0; caretStart = @caretStart
    if @textLines()[@caretLineRange()[0]].substr(0,2) == '  '
      caretStart = @caretStart - 2
    for line, idx in @caretLineRange()
      lineText = @textLines()[line]
      if lineText.substr(0, 2) == '  '
        indentedSpaces = indentedSpaces + 2
        @replaceLine(line, lineText.substring(2))
    @placeCaret(caretStart, @caretEnd - indentedSpaces)

  # ------------------------------------------ Actions

  wrapText: (char) =>
    @replaceSelection "#{char}#{@selectedText()}#{char}"
    @placeCaret(@getCaretOffset(1))

  insertCharacter: (char) =>
    @replaceSelection(char)
    @placeCaret(@getCaretOffset(1))

  insertLink: =>
    @showToolbar('link')
    @toolbars.link.find('input').val('')
    @toolbars.link.find('#link-url').focus()
    @toolbars.link.find('#link-text').val(@selectedText()) if @textIsSelected()
    @toolbars.link.find('input').keydown (e) =>
      switch e.keyCode
        when 13
          link = @toolbars.link.find('#link-text').val()
          url = @toolbars.link.find('#link-url').val()
          @replaceSelection "[#{link}](#{url})"
          @hideToolbars()
          @placeCaret(@caretStart + link.length + url.length + 4)
        when 27
          @hideToolbars()
          @placeCaret(@caretStart)
      if e.keyCode in [13,27]
        e.preventDefault()
        @toolbars.link.find('input').unbind('keydown')

  # Called from initialize
  initImageUploader: =>
    $("#new_image").fileupload
      add: (e, data) ->
        data.submit()
      success: (image) =>
        @toolbars.image.find('div.image-library').prepend(@imageTemplate(image: image))
        @toolbars.image.find('#image-url').val(image.url)
        @toolbars.image.find('#image-alt').focus()
        @toolbars.image.scrollTop(0)

  insertImage: =>
    @showToolbar('image')
    @toolbars.image.find('input').val('')
    @toolbars.image.find('#image-url').focus()
    @toolbars.image.find('#image-alt').val(@selectedText()) if @textIsSelected()
    $(document).keydown (e) =>
      switch e.keyCode
        when 13
          alt = @toolbars.image.find('#image-alt').val()
          url = @toolbars.image.find('#image-url').val()
          @replaceSelection "![#{alt}](#{url})"
          @hideToolbars()
          @placeCaret(@caretStart + alt.length + url.length + 5)
        when 27
          @hideToolbars()
          @placeCaret(@caretStart)
      if e.keyCode in [13,27]
        e.preventDefault()
        $(document).unbind('keydown')
    @toolbars.image.find('.upload-image').click (e) =>
      e.preventDefault()
      $('#image_image').trigger('click')
    @toolbars.image.find('.load-library').click (e) =>
      e.preventDefault()
      @toolbars.image.find('.load-library').hide()
      @toolbars.image.find('div.image-library').html "<p>Loading...</p>"
      $.get '/admin/json/images.json', (data) =>
        @toolbars.image.find('div.image-library').html('')
        for image in data
          @toolbars.image.find('div.image-library').append(@imageTemplate(image: image))
        $('.image-library > img').click (e) =>
          @toolbars.image.find('#image-url').val($(e.target).data('url'))
          @toolbars.image.find('#image-alt').focus()
          @toolbars.image.scrollTop(0)

  # ------------------------------------------ Toolbars

  hideToolbars: ->
    $('.toolbar').removeClass('active')

  showToolbar: (klass) ->
    @hideToolbars()
    $(".toolbar.#{klass}").addClass('active')

