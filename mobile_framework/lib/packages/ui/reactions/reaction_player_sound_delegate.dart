abstract interface class ReactionSoundPlayerDelegate {
  Future<void> playSoundFocus();

  Future<void> playSoundPick();

  Future<void> playSoundReactionBoxUp();

  Future<void> playSoundReactionBoxDown();
}
