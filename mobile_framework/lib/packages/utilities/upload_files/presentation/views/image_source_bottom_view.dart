import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

class ImageSourceBottomView extends StatelessWidget {
  VoidCallback onCameraPressed;
  VoidCallback onGalleryPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 44,
            child: Center(
              child: Text(
                "Chọn nguồn ảnh",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              await Navigator.of(context).maybePop();
              onCameraPressed();
            },
            child: SizedBox(
              height: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  Icon(CupertinoIcons.photo_camera,
                      color: Colors.grey.shade700, size: 24),
                  const SizedBox(width: 12),
                  const Text(
                    "Máy ảnh",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              await Navigator.of(context).maybePop();
              onGalleryPressed();
            },
            child: SizedBox(
              height: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  Icon(CupertinoIcons.photo_on_rectangle,
                      color: Colors.grey.shade700, size: 24),
                  const SizedBox(width: 12),
                  const Text(
                    "Thư viện ảnh",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: context.mediaQuery.viewPadding.bottom + 12,
          )
        ],
      ),
    );
  }

  ImageSourceBottomView({
    super.key,
    required this.onCameraPressed,
    required this.onGalleryPressed,
  });
}

mixin ImageSourceCompatible on ImagesPickerCompatible {
  bool get supportMultiplePickOnGallery => false;

  void showImageSourceBottomSheet(BuildContext context,
      {required Function(AppFile? result) onSelectImage,
      required Function(List<AppFile>? result) onSelectImages,
      bool isFloating = true}) async {
    return context.showInteractiveSheet(InteractiveSheet.fixedList(
      isFloating: isFloating,
      items: [
        InteractiveListItem.icon(
            icon: const Icon(
              CupertinoIcons.photo_camera,
              size: 24,
            ),
            title: "Chụp ảnh",
            onPressed: () async {
              await Navigator.of(context).maybePop();

              singlePickFromCamera().then((value) async {
                onSelectImage(value);
              });
            }),
        InteractiveListItem.icon(
            icon: const Icon(
              CupertinoIcons.photo_on_rectangle,
              size: 24,
            ),
            title: "Chọn từ thư viện ảnh",
            onPressed: () async {
              await Navigator.of(context).maybePop();
              Future result;

              if (supportMultiplePickOnGallery) {
                result = multiPickFromGallery();
              } else {
                result = singlePickFromGallery();
              }

              result.then((value) async {
                if (value is List<AppFile>) {
                  onSelectImages(value);
                } else {
                  onSelectImage(value);
                }
              });
            })
      ],
    ));
  }
}
