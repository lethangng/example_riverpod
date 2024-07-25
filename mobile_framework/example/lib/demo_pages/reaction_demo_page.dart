import 'package:flutter/material.dart';
import 'package:mobile_framework/mobile_framework.dart';

class SampleNewsItem extends ReactionItem {
  String text;

  SampleNewsItem({
    required this.text,
    super.reaction,
  });
}

class ReactionDemoPage extends StatelessWidget {
  List<SampleNewsItem> items = [
    SampleNewsItem(text: "News 1"),
    SampleNewsItem(text: "News 2"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Reaction Demo Page'),
        ),
        body: Container(
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              ReactionBuilder(
                builder: (context, type) {
                  return Container(
                    color: Colors.blue,
                    child: type != ReactionType.unselected
                        ? Lottie.asset(type.lottiePath, width: 20, height: 20)
                        : null,
                  );
                },
                onSelectReaction: (ReactionType type) {},
                size: const Size(30, 30),
              ),
              const Spacer(),
              ReactionBuilder(
                onSelectReaction: (ReactionType type) {
                  print(type);
                },
                builder: (context, type) => Container(
                  height: 40,
                  width: 40,
                  color: Colors.red,
                ),
                size: const Size(60, 60),
              ).align(Alignment.bottomCenter).flexible()
            ],
          ),
        ));
  }
}
