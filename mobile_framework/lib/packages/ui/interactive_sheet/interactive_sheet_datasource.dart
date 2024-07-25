import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

abstract class InteractiveSheetDataSource {
  double interactiveSheetMinHeightRatio() {
    return 0.4;
  }

  double interactiveSheetMaxHeightRatio() {
    return 0.85;
  }

  double interactiveSheetInitialRatio() {
    return 0.4;
  }

  Widget interactiveSheetChildWidget(ScrollController? controller);

  Widget interactiveSheetAppBarWidget();

  bool interactiveSheetShouldChangeToFloatingForm();

  bool interactiveSheetShouldShowIndicator();
}

class InteractiveListItem {
  String title;
  bool isSelected = false;
  Widget icon = const SizedBox();
  Function() onPressed;

  /// If [permissions] is null, it means that the item is always visible.
  List<SSOPermission>? permissions;

  final bool hasIcon;

  InteractiveListItem.normal(
      {this.isSelected = false,
      required this.title,
      required this.onPressed,
      this.permissions})
      : hasIcon = false,
        icon = const SizedBox();

  InteractiveListItem.icon(
      {this.isSelected = false,
      required this.icon,
      required this.title,
      required this.onPressed,
      this.permissions})
      : hasIcon = true;
}

class InteractiveSheetListDataSource extends InteractiveSheetDataSource {
  final Widget? header;
  final List<InteractiveListItem> items;
  final bool supportMultipleSelection;
  final bool isFloating;
  final bool canShowIndicator;
  final double? minHeightRatio;
  final double? maxHeightRatio;
  final double? initialHeightRatio;

  final InteractiveSheetListItemPressedCallback? onItemPressed;
  final InteractiveSheetListItemBuilder? itemBuilder;
  final InteractiveSheetListItemStyleBuilder? itemTextStyle;
  InteractiveSheetListItemSeparatorBuilder? itemSeparatorBuilder;

  InteractiveSheetListDataSource(this.items,
      {this.header,
      this.minHeightRatio,
      this.maxHeightRatio,
      this.initialHeightRatio,
      @Deprecated("Use onPressed in InteractiveListItem") this.onItemPressed,
      this.itemBuilder,
      this.itemTextStyle,
      this.itemSeparatorBuilder,
      this.supportMultipleSelection = false,
      this.isFloating = false,
      this.canShowIndicator = true});

  @override
  double interactiveSheetInitialRatio() {
    return initialHeightRatio ?? super.interactiveSheetInitialRatio();
  }

  @override
  double interactiveSheetMaxHeightRatio() {
    return maxHeightRatio ?? super.interactiveSheetMaxHeightRatio();
  }

  @override
  double interactiveSheetMinHeightRatio() {
    return minHeightRatio ?? super.interactiveSheetMinHeightRatio();
  }

  @override
  Widget interactiveSheetAppBarWidget() {
    return header ?? const SizedBox.shrink();
  }

  @override
  Widget interactiveSheetChildWidget(ScrollController? controller) {
    return _buildListView(controller: controller);
  }

  Widget _buildListView({ScrollController? controller}) {
    var _items = items.where((e) {
      if (e.permissions == null) {
        return true;
      }
      var hasPermission = SSOPermissionManager().hasPermissions(e.permissions!);
      return hasPermission;
    }).toList();

    return ListView.separated(
            controller: controller,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: controller == null
                ? const NeverScrollableScrollPhysics()
                : null,
            itemBuilder: (context, index) {
              var item = _items.elementAt(index);
              return InkWell(
                child: itemBuilder != null
                    ? itemBuilder!(context, index)
                    : _defaultItem(item, index),
                onTap: () async {
                  item.isSelected = true;

                  onItemPressed?.call(index);
                  item.onPressed();

                  if (supportMultipleSelection) {
                    return;
                  }

                  // reset all items which are not current item to unselected status
                  items.where((element) => element != item).forEach((element) {
                    element.isSelected = false;
                  });
                },
              );
            },
            separatorBuilder: (context, index) {
              return itemSeparatorBuilder?.call(index) ??
                  LineSeparator(
                    color: Colors.grey.shade200,
                    margin: EdgeInsets.zero,
                  );
            },
            itemCount: _items.length)
        .paddingSymmetric(horizontal: 12.0);
  }

  Widget _defaultItem(InteractiveListItem item, int index) {
    var hasLeftIcon = item.hasIcon;
    var canSelect = item.isSelected;
    return SizedBox(
        height: 56,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: hasLeftIcon ? 12.0 : 0),
                    item.icon,
                    SizedBox(width: hasLeftIcon ? 12.0 : 0),
                    Text(item.title, style: itemTextStyle?.call(index)),
                  ],
                ),
                canSelect
                    ? Icon(
                        Icons.check,
                        color: GlobalThemeConfiguration.global()?.mainColor,
                      )
                    : Container(),
              ],
            ),
            //const SizedBox(height: 16.0,),
          ],
        ));
  }

  @override
  bool interactiveSheetShouldChangeToFloatingForm() {
    return isFloating;
  }

  @override
  bool interactiveSheetShouldShowIndicator() {
    return canShowIndicator;
  }
}

class InteractiveSheetContentDataSource extends InteractiveSheetDataSource {
  final Widget? header;
  final Widget child;
  final double? minHeightRatio;
  final double? maxHeightRatio;
  final double? initialHeightRatio;
  final bool isFloating;
  final bool canShowIndicator;

  InteractiveSheetContentDataSource(this.child,
      {this.header,
      this.minHeightRatio,
      this.maxHeightRatio,
      this.initialHeightRatio,
      this.isFloating = false,
      this.canShowIndicator = true});

  @override
  Widget interactiveSheetAppBarWidget() {
    return header ?? const SizedBox.shrink();
  }

  @override
  Widget interactiveSheetChildWidget(ScrollController? controller) {
    return child;
  }

  @override
  double interactiveSheetInitialRatio() {
    return initialHeightRatio ?? super.interactiveSheetInitialRatio();
  }

  @override
  double interactiveSheetMaxHeightRatio() {
    return maxHeightRatio ?? super.interactiveSheetMaxHeightRatio();
  }

  @override
  double interactiveSheetMinHeightRatio() {
    return minHeightRatio ?? super.interactiveSheetMinHeightRatio();
  }

  @override
  bool interactiveSheetShouldChangeToFloatingForm() {
    return isFloating;
  }

  @override
  bool interactiveSheetShouldShowIndicator() {
    return canShowIndicator;
  }
}
