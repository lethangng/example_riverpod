import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mime/mime.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:thumbnailer/thumbnailer.dart';

class FilesContainerView extends ConsumerStatefulWidget {
  final Function(List<AppFile> selectedFiles) onSelectFiles;
  final Function(int index) onRemoveFileAt;
  final List<AppFile> initialFiles;
  final String? title;
  final String? description;

  bool isFilePicker = false;
  bool multiSelect;
  bool onlyPickOneFile = false;

  @override
  ConsumerState<FilesContainerView> createState() => _FilesContainerViewState();

  FilesContainerView.images({
    super.key,
    required this.onSelectFiles,
    required this.onRemoveFileAt,
    this.title,
    this.description,
    this.initialFiles = const [],
    this.multiSelect = false,
    this.onlyPickOneFile = false,
  }) {
    isFilePicker = false;
  }

  FilesContainerView.files({
    super.key,
    required this.onSelectFiles,
    required this.onRemoveFileAt,
    this.title,
    this.description,
    this.initialFiles = const [],
    this.multiSelect = false,
    this.onlyPickOneFile = false,
  }) {
    isFilePicker = true;
  }
}

class _FilesContainerViewState extends ConsumerState<FilesContainerView>
    with
        TickerProviderStateMixin,
        FilesPickerCompatible,
        ImagesPickerCompatible,
        GlobalThemePlugin,
        PickerSettings {
  late AnimationController controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 350));
  late AnimationController itemFileColorAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 250));

  late Animation<double?> widthAnimation;
  late Animation<double?> itemWidthAnimation;
  late Animation<double> opacityAnimation;
  late Animation<Color> loadingFileColorTween;

  // late RxBool rxIsFilesPicked = false.obs;

  late PickMultiImagesUC pickMultiImagesUC = PickMultiImagesUC();
  late PickSingleImageUC pickSingleImageUC = PickSingleImageUC();

  late PickMultiFilesUC pickMultiFilesUC = PickMultiFilesUC();
  late PickSingleFileUC pickSingleFileUC = PickSingleFileUC();

  late StateProvider<bool> isFilePickedStateProvider =
      StateProvider<bool>((ref) => false);

  List<AppFile> selectedFiles = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    itemFileColorAnimationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    widthAnimation = Tween<double?>(
            begin: MediaQuery.of(globalKey.currentContext!).size.width - 40,
            end: 100.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    itemWidthAnimation = Tween<double?>(begin: 0, end: 100.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    opacityAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    loadingFileColorTween =
        Tween<Color>(begin: conf.mainColor, end: conf.mainColor).animate(
            CurvedAnimation(
                parent: itemFileColorAnimationController,
                curve: Curves.easeInOut));

    pickMultiImagesUC.pickerDelegate = this;
    pickSingleImageUC.pickerDelegate = this;

    pickMultiFilesUC.pickerDelegate = this;
    pickSingleFileUC.pickerDelegate = this;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    ref.listen(isFilePickedStateProvider, (previous, isPicked) {
      if (isPicked) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
  }

  @override
  void didUpdateWidget(covariant FilesContainerView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    selectedFiles = widget.initialFiles;

    ref.read(isFilePickedStateProvider.notifier).state =
        selectedFiles.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Text(widget.title!, style: conf.defaultTextStyle.semiBold),
        VSpace.v8,
        CustomScrollView(
          scrollDirection: Axis.horizontal,
          slivers: [
            SliverPinnedHeader(
                child: DottedBorder(
                        dashPattern: const [10, 4],
                        borderType: BorderType.RRect,
                        radius: 8.0.circularRadius,
                        color: Colors.grey.shade400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.cloud_upload_fill,
                              size: 30,
                              color: conf.mainColor,
                            ),
                            VSpace.v8,
                            Text(
                              widget.isFilePicker ? "Chọn file" : "Chọn ảnh",
                              style: conf.secondaryTextStyle,
                            ).copyWith(textAlign: TextAlign.center),
                          ],
                        ).center().onTapWidget(() async {
                          if (widget.isFilePicker) {
                            _onOpenFilesPicker();
                          } else {
                            _onOpenImagesPicker();
                          }
                        }))
                    .box(h: 100.0, w: widthAnimation.value)
                    .align(Alignment.centerLeft)),
            SliverClip(
              child: SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                sliver: SliverAnimatedOpacity(
                  duration: const Duration(milliseconds: 350),
                  opacity: ref.watch(isFilePickedStateProvider) ? 1 : 0,
                  sliver: SliverFillRemaining(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => HSpace.h8,
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedFiles.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          fit: StackFit.loose,
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              height: 100,
                              clipBehavior: Clip.antiAlias,
                              width: itemWidthAnimation.value,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border:
                                      Border.all(color: Colors.grey.shade400)),
                              child: Image(
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Thumbnail(
                                        decoration: WidgetDecoration(
                                          backgroundColor: Colors.white,
                                          wrapperBgColor: Colors.white,
                                          iconColor: conf.mainColor,
                                          textColor: Colors.black,
                                        ),
                                        mimeType: lookupMimeType(
                                                selectedFiles[index]
                                                    .file
                                                    .path) ??
                                            "",
                                        widgetSize: 80,
                                        name: selectedFiles[index].fileName,
                                        useWaterMark: false,
                                        onlyIcon: true,
                                        dataSize: 100,
                                        dataResolver: () => compute(
                                            (file) => file.readAsBytes(),
                                            selectedFiles[index].file),
                                      ),
                                    );
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        height: 14,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            borderRadius: 7.0.borderAll()),
                                        child: LinearProgressIndicator(
                                          backgroundColor: Colors.grey.shade200,
                                          minHeight: 20,
                                          valueColor: loadingFileColorTween,
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      ),
                                    );
                                  },
                                  image: NetworkToFileImage(
                                      url: selectedFiles[index].fullUrl,
                                      file:
                                          File(selectedFiles[index].fullUrl))),
                            ).onTapWidget(() {
                              if (selectedFiles[index].isLocalFile) {
                                SimpleWebView.localFile(
                                        title: "Xem trước",
                                        url: selectedFiles[index].fullUrl)
                                    .show();
                              } else {
                                SimpleWebView.remoteFile(
                                        title: "Xem trước",
                                        url: selectedFiles[index].fullUrl)
                                    .show();
                              }
                            }),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                selectedFiles.removeAt(index);
                                widget.onRemoveFileAt(index);
                                ref
                                    .read(isFilePickedStateProvider.notifier)
                                    .state = selectedFiles.isNotEmpty;
                                setState(() {});
                              },
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10.0),
                                  // border: Border.all(
                                  //   color: Colors.red,
                                  //   width: 1.0,
                                  // ),
                                ),
                                child: Icon(
                                  Icons.close_rounded,
                                  size: 16,
                                  color: Colors.grey.shade700,
                                ),
                              ).paddingAll(10),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ).box(h: 100),
        VSpace.v12,
        if (widget.description != null)
          Text(widget.description!,
              style: conf.secondaryTextStyle
                  .size(12)
                  .textColor(Colors.grey.shade600)),
      ],
    );
  }

  void _onOpenImagesPicker() async {
    if (widget.multiSelect) {
      var files = await pickMultiImagesUC();

      if (files == null) {
        return;
      }

      _addSelectFiles(files);
      return;
    }

    var options = [
      InteractiveListItem.icon(
          icon: Icon(
            CupertinoIcons.camera,
            size: 24,
            color: Colors.grey.shade600,
          ),
          title: "Chụp ảnh",
          onPressed: () async {
            await appRouter.maybePop();
            pickSingleImageUC.source = PhotoSource.camera;
            var file = await pickSingleImageUC();

            if (file == null) {
              return;
            }

            _addSelectFiles([file]);
          }),
      InteractiveListItem.icon(
          icon: Icon(
            CupertinoIcons.photo_fill,
            size: 24,
            color: Colors.grey.shade600,
          ),
          title: "Chọn ảnh từ thư viện",
          onPressed: () async {
            await appRouter.maybePop();
            pickSingleImageUC.source = PhotoSource.gallery;
            var file = await pickSingleImageUC();

            if (file == null) {
              return;
            }

            _addSelectFiles([file]);
          }),
    ];

    InteractiveSheet.fixedList(
      header: SizedBox(
          height: 44.0,
          child: Text("Chọn nguồn ảnh", style: conf.defaultTextStyle.semiBold)
              .fontSize(17)
              .center()),
      items: options,
      itemBuilder: ((context, index) {
        var item = options[index];
        return SizedBox(
          height: 44.0,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 8.0),
                item.icon,
                const SizedBox(width: 12.0),
                Text(item.title,
                    style: const TextStyle().size(14).weight(FontWeight.w500)),
              ],
            ),
          ]),
        );
      }),
      itemSeparatorBuilder: (index) => Column(
        children: [
          VSpace.v8,
          LineSeparator(
            color: Colors.grey.shade200,
            margin: EdgeInsets.zero,
          ),
          VSpace.v10,
        ],
      ),
    ).show();
  }

  void _onOpenFilesPicker() async {
    if (widget.multiSelect) {
      var files = await pickMultiFilesUC();
      if (files == null) {
        return;
      }

      _addSelectFiles(files);
      return;
    }

    var file = await pickSingleFileUC();

    if (file == null) {
      return;
    }

    _addSelectFiles([file]);
  }

  void _addSelectFiles(List<AppFile> files) {
    if (widget.onlyPickOneFile) {
      selectedFiles = files;
    } else {
      selectedFiles.insertAll(0, files);
    }

    widget.onSelectFiles(selectedFiles);
    ref.read(isFilePickedStateProvider.notifier).state = true;
    setState(() {});
  }
}
