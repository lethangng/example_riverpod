class RichTextWebEditorRegisterEvents {
  static const String registeredEvents = """
  window.flutter_inappwebview.callHandler('setVisibleEditor', true);
  
  editor.on('SelectionChange', function(e) {
    var boldState = tinymce.activeEditor.queryCommandState('Bold');
    var italicState = tinymce.activeEditor.queryCommandState('Italic');
    var underlineState = tinymce.activeEditor.queryCommandState('Underline');
    var unorderListState = tinymce.activeEditor.queryCommandState('InsertUnorderedList');
    var strikeThroughState = tinymce.activeEditor.queryCommandState('StrikeThrough');
    var subscriptState = tinymce.activeEditor.queryCommandState('Subscript');
    var superscriptState = tinymce.activeEditor.queryCommandState('Superscript');
    var blockquoteState = tinymce.activeEditor.queryCommandState('Blockquote');
    var indentState = tinymce.activeEditor.queryCommandState('Indent');
    var outdentState = tinymce.activeEditor.queryCommandState('Outdent');
    var orderListState = tinymce.activeEditor.queryCommandState('InsertOrderedList');
    var alignLeftState = tinymce.activeEditor.queryCommandState('JustifyLeft');
    var alignCenterState = tinymce.activeEditor.queryCommandState('JustifyCenter');
    var alignRightState = tinymce.activeEditor.queryCommandState('JustifyRight');
    var alignJustifyState = tinymce.activeEditor.queryCommandState('JustifyFull');
    
    var fontName = tinymce.activeEditor.queryCommandValue('FontName');
    var fontSize = tinymce.activeEditor.queryCommandValue('FontSize');
    
    var undoState = tinymce.activeEditor.undoManager.hasUndo();
    var redoState = tinymce.activeEditor.undoManager.hasRedo();
    
    window.flutter_inappwebview.callHandler('sendToggleState', JSON.stringify({
      "data": [
          {
            "type": "bold",
             "isActive": boldState
           }, 
            {
              "type": "italic",
              "isActive": italicState
            },
            {
              "type": "underline",
              "isActive": underlineState
            }, 
            {
              "type": "unorderList",
              "isActive": unorderListState
            }, 
            {
              "type": "undo",
              "isDisable": !undoState
            }, 
            {
              "type": "redo",
              "isDisable": !redoState
            }, 
            {
              "type": "strikeThrough",
              "isActive": strikeThroughState
            }, 
            {
              "type": "subscript",
              "isActive": subscriptState
            }, 
            {
              "type": "superscript",
              "isActive": superscriptState
            }, 
            {
              "type": "blockQuote",
              "isActive": blockquoteState
            }, 
            {
              "type": "indent",
              "isActive": indentState
            }, 
            {
              "type": "outdent",
              "isActive": outdentState
            }, 
            {
              "type": "orderList",
              "isActive": orderListState
            }, 
            {
              "type": "fontFamily", 
              "data": fontName
            }, 
            {
              "type": "fontSize", 
              "data": fontSize
            }, 
            {
              "type": "alignLeft",
              "isActive": alignLeftState
            }, 
            {
              "type": "alignCenter",
              "isActive": alignCenterState
            }, 
            {
              "type": "alignRight",
              "isActive": alignRightState
            }, 
            {
              "type": "alignJustify",
              "isActive": alignJustifyState
            }
      ]
    }));
});
""";
}
