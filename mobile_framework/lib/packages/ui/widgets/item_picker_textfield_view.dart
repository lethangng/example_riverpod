import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/ui/widgets/seletable_text_editing_controller.dart';

// ignore: must_be_immutable
class ItemsPickerTextFieldView<T extends ItemPickerCompatible,
    ItemPickerMetadata extends Metadata> extends StatefulWidget {
  String? title;
  String? placeholder;
  String? initialText;
  String Function()? errorText;
  String emptyText;

  bool isDisabled;
  bool isRequired;
  bool isMultiSelection;
  bool Function()? canOpenPicker;
  bool enableLoadMore;
  bool enableRefresh;
  bool Function(String? text)? validator;
  bool canSelectAll;
  bool Function()? enableBy;

  double? height;

  Function(List<T>? items)? onConfirmSelectedMultiItems;
  Function(T? item)? onConfirmSelectedItem;
  Function(List<T> allItems)? onTapAllOption;

  VoidCallback? onTapTextField;
  MetadataUpdater<ItemPickerMetadata>? metadataUpdater;

  List<Widget> suffixIcons;
  List<Widget> prefixIcons;
  List<Widget> topPluginViews;
  List<Widget> bottomPluginViews;
  List<T> Function()? selectedItems;
  T? Function()? selectedItem;

  Widget? titleWidget;
  Widget Function(int index, T item, Key? key)? itemBuilder;

  Future<List<T>> Function(int page)? onLoadItems;

  ItemsPickerTextEditingController? textEditingController;
  final bool enableOutSideBorder;
  final EdgeInsets? padding;
  final double? borderRadius;
  final bool shouldShowSearchField;
  final ScrollController? scrollController;

  ItemsPickerTextFieldView(
      {super.key,
      this.height,
      this.title,
      this.placeholder,
      this.initialText,
      this.isDisabled = false,
      this.isRequired = true,
      this.textEditingController,
      this.titleWidget,
      this.suffixIcons = const [],
      this.prefixIcons = const [],
      this.validator,
      this.errorText,
      this.onTapTextField,
      this.onConfirmSelectedMultiItems,
      this.onConfirmSelectedItem,
      this.isMultiSelection = false,
      this.canOpenPicker,
      this.enableBy,
      this.selectedItem,
      this.selectedItems,
      this.enableRefresh = true,
      this.enableLoadMore = true,
      this.canSelectAll = false,
      this.onTapAllOption,
      this.metadataUpdater,
      this.itemBuilder,
      this.emptyText = "Chưa có dữ liệu",
      this.topPluginViews = const [],
      this.bottomPluginViews = const [],
      this.onLoadItems,
      this.enableOutSideBorder = false,
      this.padding,
      this.borderRadius,
      this.shouldShowSearchField = true,
      this.scrollController});

  @override
  State<ItemsPickerTextFieldView<T, Metadata>> createState() =>
      _ItemsPickerTextFieldViewState<T, ItemPickerMetadata>();
}

class _ItemsPickerTextFieldViewState<T extends ItemPickerCompatible,
        ItemPickerMetadata extends Metadata>
    extends State<ItemsPickerTextFieldView<T, ItemPickerMetadata>>
    with GlobalThemePlugin {
  late AnimationController focusedBorderAnimationController;
  late AnimationController errorBorderAnimationController;
  late Widget emptyView = Center(
    child: Material(
      color: Colors.transparent,
      child: Text(
        widget.emptyText,
        style: conf.defaultTextStyle.textColor(Colors.grey.shade600),
      ),
    ),
  );

  late ItemsPickerTextEditingController textEditingController;

  List<T>? selectedItems;
  T? selectedItem;
  bool hasTapOnTextField = false;

  @override
  void initState() {
    super.initState();

    textEditingController = widget.textEditingController ??
        ItemsPickerTextEditingController(text: widget.initialText);

    textEditingController.onClear = () {
      setState(() {
        textEditingController.clear();
        selectedItem = null;
        selectedItems = null;
      });
    };

    _onUpdate();
  }

  @override
  void didUpdateWidget(
      covariant ItemsPickerTextFieldView<T, ItemPickerMetadata> oldWidget) {
    super.didUpdateWidget(oldWidget);

    _onUpdate();
  }

  void _onUpdate() {
    selectedItem = widget.selectedItem?.call();
    selectedItems = widget.selectedItems?.call();

    if (selectedItem != null) {
      textEditingController.text = selectedItem!.title;
    } else if (selectedItems?.isNotEmpty ?? false) {
      textEditingController.text =
          selectedItems!.map((e) => e.title).whereType<String>().join(", ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldView(
      title: widget.title,
      placeholder: widget.placeholder,
      isDisabled: widget.isDisabled,
      isRequired: widget.isRequired,
      initialText: widget.initialText,
      textEditingController: textEditingController,
      enableBy: widget.enableBy,
      shouldShowInsideBorder: !widget.enableOutSideBorder,
      shouldShowOutsideBorder: widget.enableOutSideBorder,
      padding: widget.padding,
      borderRadius: widget.borderRadius,
      errorText: widget.errorText,
      prefixIcons: widget.prefixIcons,
      suffixIcons: const [
        Icon(
          CupertinoIcons.chevron_down,
          size: 18.0,
          color: Colors.black87,
        )
      ],
      isSelectable: true,
      hasTapOnTextFieldWhenSelectable: () => hasTapOnTextField,
      onInitializeFocusedBorderAnimationController:
          (focusedBorderAnimationController) {
        this.focusedBorderAnimationController =
            focusedBorderAnimationController;
      },
      onInitializeErrorBorderAnimationController:
          (errorBorderAnimationController) {
        this.errorBorderAnimationController = errorBorderAnimationController;
      },
      validator: widget.validator ??
          (text) {
            return text.isNotNullOrBlank;
          },
      onTapTextField: () async {
        if (!(widget.canOpenPicker?.call() ?? true)) {
          return;
        }

        hasTapOnTextField = true;
        focusedBorderAnimationController.forward();

        if (widget.isMultiSelection) {
          var items = await context.showOverlay(ItemsPicker<T>(
            scrollController: widget.scrollController,
            itemPickerTitleBuilder: widget.titleWidget == null
                ? null
                : () {
                    return widget.titleWidget!;
                  },
            enableLoadMore: widget.enableLoadMore,
            enableRefresh: widget.enableRefresh,
            isMultiSelection: true,
            includeOptionAll: widget.canSelectAll,
            onSelectOptionAll: widget.onTapAllOption,
            title: widget.title ?? "",
            topPluginViews: widget.topPluginViews,
            bottomPluginViews: widget.bottomPluginViews,
            selectedItems: selectedItems ?? widget.selectedItems?.call(),
            itemBuilder: widget.itemBuilder,
            emptyDataView: emptyView,
            metadataUpdater: widget.metadataUpdater,
            shouldShowSearchTextField: widget.shouldShowSearchField,
            onConfirmSelectMultipleItems: (items) =>
                Navigator.of(context).pop(items),
            onLoadItems: widget.onLoadItems,
          ));
          hasTapOnTextField = false;
          focusedBorderAnimationController.reverse();

          if (items == null) {
            if (selectedItems == null || selectedItems!.isEmpty) {
              errorBorderAnimationController.forward();
            }
            return;
          } else {
            errorBorderAnimationController.reverse();
          }
          textEditingController.text =
              items.map((e) => e.title).toList().join(", ");
          selectedItems = items;
          widget.onConfirmSelectedMultiItems?.call(items);
        } else {
          var item = await context.showOverlay(ItemsPicker<T>(
            scrollController: widget.scrollController,
            itemPickerTitleBuilder: widget.titleWidget == null
                ? null
                : () {
                    return widget.titleWidget!;
                  },
            enableLoadMore: widget.enableLoadMore,
            enableRefresh: widget.enableRefresh,
            includeOptionAll: widget.canSelectAll,
            shouldShowSearchTextField: widget.shouldShowSearchField,
            onSelectOptionAll: (items) {
              if (widget.onTapAllOption != null) {
                widget.onTapAllOption!(items);
                selectedItem = null;
              }
            },
            title: widget.title ?? "",
            topPluginViews: widget.topPluginViews,
            bottomPluginViews: widget.bottomPluginViews,
            selectedItem: selectedItem ?? widget.selectedItem?.call(),
            itemBuilder: widget.itemBuilder,
            emptyDataView: emptyView,
            metadataUpdater: widget.metadataUpdater,
            onConfirmSelectSingleItem: (item) =>
                Navigator.of(context).pop(item),
            onLoadItems: widget.onLoadItems,
          ));
          hasTapOnTextField = false;
          focusedBorderAnimationController.reverse();

          if (item == null) {
            if (selectedItem == null) {
              errorBorderAnimationController.forward();
            }
            return;
          } else {
            errorBorderAnimationController.reverse();
          }

          textEditingController.text = item.title;

          selectedItem = item;
          widget.onConfirmSelectedItem?.call(item);
        }
      },
    );
  }
}

class ItemsPickerTextEditingController extends SelectableTextEditingController {
  @protected
  late Function() onClear;

  ItemsPickerTextEditingController({super.text});

  @override
  void resetData() {
    onClear();
  }
}
