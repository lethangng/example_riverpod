// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

// ignore: must_be_immutable
class DPConfirmPopupView extends StatefulWidget {
  final Widget title;
  final Widget content;
  final Widget cancelButtonTitle;
  final Widget confirmButtonTitle;

  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final bool isDestructive;

  const DPConfirmPopupView({
    super.key,
    required this.title,
    required this.content,
    required this.cancelButtonTitle,
    required this.confirmButtonTitle,
    required this.onConfirm,
    this.onCancel,
    this.isDestructive = false,
  });

  @override
  State<DPConfirmPopupView> createState() => _DPConfirmPopupViewState();
}

class _DPConfirmPopupViewState extends State<DPConfirmPopupView> {
  @override
  Widget build(BuildContext context) {
    return PopupView(
      cornerRadius: 16.0,
      height: 190.0,
      width: 270.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          VSpace.v16,
          widget.title,
          widget.content.defaultHorizontalPadding().center().expand(),
          Column(
            children: [
              LineSeparator(
                color: Colors.grey.shade200,
                margin: EdgeInsets.zero,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      if (widget.onCancel == null) {
                        context.popRoute();
                      } else {
                        widget.onCancel!();
                      }
                    },
                    child: widget.cancelButtonTitle.center(),
                  ).box(h: 48.0).expand(),
                  Container(
                      height: 50.0, color: Colors.grey.shade200, width: 1),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      context.popRoute();
                      widget.onConfirm();
                    },
                    child: widget.confirmButtonTitle.center(),
                  ).box(h: 48.0).expand(),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
