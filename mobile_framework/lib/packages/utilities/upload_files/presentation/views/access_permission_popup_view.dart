import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_framework/mobile_framework.dart' hide ImageSource;

class AccessPermissionPopupView extends ConsumerStatefulWidget {
  ImageSource source;
  Function() onOpenSettings;

  @override
  ConsumerState<AccessPermissionPopupView> createState() =>
      _AccessPermissionPopupViewState();

  AccessPermissionPopupView({
    super.key,
    required this.source,
    required this.onOpenSettings,
  });
}

class _AccessPermissionPopupViewState
    extends ConsumerState<AccessPermissionPopupView> {
  String get title => switch (widget.source) {
        // TODO: Handle this case.
        ImageSource.camera => "Truy cập máy ảnh",
        // TODO: Handle this case.
        ImageSource.gallery => "Truy cập thư viện ảnh",
      };

  String get description => switch (widget.source) {
        // TODO: Handle this case.
        ImageSource.camera =>
          "Bạn đã tắt quyền truy cập máy ảnh trước đó, để bật tính năng này hãy chọn cài đặt và bật quyền truy cập máy ảnh",
        // TODO: Handle this case.
        ImageSource.gallery =>
          "Bạn đã tắt quyền truy cập thư viện ảnh trước đó, để bật tính năng này hãy chọn cài đặt và bật quyền truy cập thư viện ảnh"
      };

  @override
  Widget build(BuildContext context) {
    return PopupView(
        width: context.width * 0.8,
        child: Column(
          children: [
            VSpace.v10,
            Text(
              title,
              style: ref.theme.defaultTextStyle.semiBold,
            ),
            VSpace.v10,
            Text(
              description,
              style: ref.theme.mediumTextStyle,
              textAlign: TextAlign.center,
            ).defaultHorizontalPadding(),
            VSpace.v12,
            Row(
              children: [
                ClipRRect(
                  borderRadius: 12.0.borderAll(),
                  child: PrimaryButton(
                      color: Colors.grey.shade100,
                      title: Text(
                        "Hủy",
                        style: ref.theme.mediumTextStyle.semiBold,
                      ),
                      onPressed: () async {
                        await Navigator.of(context).maybePop();
                      }),
                ).expand(),
                HSpace.h12,
                ClipRRect(
                  borderRadius: 12.0.borderAll(),
                  child: PrimaryButton(
                      color: ref.theme.mainColor,
                      title: Text(
                        "Cài đặt",
                        style: ref.theme.mediumTextStyle.white,
                      ),
                      onPressed: () async {
                        await Navigator.of(context).maybePop();
                        widget.onOpenSettings();
                      }),
                ).expand(),
              ],
            ).defaultHorizontalPadding(),
            VSpace.v12,
          ],
        ));
  }
}
