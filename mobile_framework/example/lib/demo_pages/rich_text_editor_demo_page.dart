import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';
import 'package:mobile_framework/packages/ui/rich_text_editor/rich_text_web_editor_controller.dart';
import 'package:mobile_framework/packages/ui/rich_text_editor/rich_text_web_editor_initializer.dart';

class RichTextEditorDemoPage extends StatefulWidget {
  const RichTextEditorDemoPage({super.key});

  @override
  State<RichTextEditorDemoPage> createState() => _RichTextEditorDemoPageState();
}

class _RichTextEditorDemoPageState extends State<RichTextEditorDemoPage>
    with ImagesPickerCompatible, PickerSettings, ImageSourceCompatible {
  late final RichTextWebEditorController controller =
      RichTextWebEditorController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rich Text Editor Demo'),
        actions: [
          const Icon(Icons.html).onTapWidget(() {}).paddingOnly(right: 12)
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            RichTextWebEditor(
              controller: controller,
              initialHtml:
                  "<p>K&iacute;nh gửi C&ocirc;ng ty cổ phần c&ocirc;ng nghệ Ommani,</p>\n<p>Dưới đ&acirc;y l&agrave; danh s&aacute;ch nh&acirc;n sự được cử sang l&agrave;m onsite của Tập đo&agrave;n c&ocirc;ng nghiệp Viettel - C&ocirc;ng ty Viettel Telecom</p>\n<p>Danh s&aacute;ch n&agrave;y c&oacute; 04 nh&acirc;n sự:</p>\n<table style=\"border-collapse: collapse; width: 100%;\" border=\"1\">\n<tbody>\n<tr>\n<td style=\"width: 31.3399%; text-align: center;\"><strong>STT</strong></td>\n<td style=\"width: 31.3399%; text-align: center;\"><strong>Họ v&agrave; t&ecirc;n</strong></td>\n<td style=\"width: 31.3399%; text-align: center;\"><strong>Chức danh</strong></td>\n</tr>\n<tr>\n<td style=\"width: 31.3399%; text-align: center;\">01</td>\n<td style=\"width: 31.3399%;\">Nguyễn Văn A</td>\n<td style=\"width: 31.3399%;\">Trưởng nh&oacute;m</td>\n</tr>\n<tr>\n<td style=\"width: 31.3399%; text-align: center;\">02</td>\n<td style=\"width: 31.3399%; text-align: center;\">Trần Ngọc B</td>\n<td style=\"width: 31.3399%; text-align: center;\">Lập tr&igrave;nh hệ thống</td>\n</tr>\n<tr>\n<td style=\"width: 31.3399%; text-align: center;\">03</td>\n<td style=\"width: 31.3399%; text-align: center;\">Phan Th&agrave;nh C</td>\n<td style=\"width: 31.3399%; text-align: center;\">Lập tr&igrave;nh Web</td>\n</tr>\n<tr>\n<td style=\"width: 31.3399%; text-align: center;\">04</td>\n<td style=\"width: 31.3399%; text-align: center;\">L&ecirc; Thị D</td>\n<td style=\"width: 31.3399%; text-align: center;\">Tester</td>\n</tr>\n</tbody>\n</table>",
              height: '',
              initializer: RichTextWebEditorInitializer(init: {
                "selector": "textarea",
                "plugin": "link table",
                "mobile": {
                  "toolbar":
                      "undo redo | bold italic underline table | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | removeformat",
                }
              }, editorId: ''),
              cssListBuilder: [],
              focusNode: focusNode,
            ).bottomCenter(),
          ],
        ),
      ),
    );
  }
}
