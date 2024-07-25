import 'package:mobile_framework/packages/ui/reactions/reaction.dart';

class ReactionItem<T> {
  Reaction? reaction;

  bool get hasNoReaction => reaction == null;

  void resetReaction() => reaction = null;

  void setNewReaction(Reaction reaction) => this.reaction = reaction;

  ReactionItem({
    this.reaction,
  });
}
