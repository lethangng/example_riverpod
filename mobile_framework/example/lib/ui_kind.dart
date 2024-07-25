enum UIKind {
  commonWidgets,
  alertMessage,
  tableView,
  textFieldView,
  itemsPicker,
  images,
  multipleTriggerTextFieldView,
  interactiveSheet,
  showOverlay,
  audio,
  doubleExts,
  richTextEditor,
  appFlowy,
  reaction;

  String get name {
    switch (this) {
      case UIKind.textFieldView:
        return 'TextFieldView';
      case UIKind.itemsPicker:
        return 'ItemsPickerView';
      case UIKind.images:
        return 'ImagesAssetsPickerViewer';
      case UIKind.commonWidgets:
        return 'CommonWidgets';
      case UIKind.multipleTriggerTextFieldView:
        return 'MultipleTriggerTextFieldView';
      case UIKind.interactiveSheet:
        return 'InteractiveSheet';
      case UIKind.showOverlay:
        return 'ShowOverlay';
      case UIKind.audio:
        return 'Audio';
      case UIKind.doubleExts:
        return 'DoubleExts';
      case UIKind.richTextEditor:
        return 'RichTextEditor';
      case UIKind.tableView:
        return 'TableView';
      case UIKind.appFlowy:
        return 'AppFlowy';
      case UIKind.reaction:
        return 'Reaction';
      case UIKind.alertMessage:
        return 'AlertMessage';
    }
  }
}
