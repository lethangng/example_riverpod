import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

const appProviderObserverTag = "AppProviderObserver";

class AppProviderObserver extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    if (provider.from != null) {
      log('Provider ${provider.name ?? provider.toString()} was added with arg ${provider.argument}',
          name: "👨‍👩‍👧‍👦");
    } else if (value != null) {
      log('Provider ${provider.name ?? provider.toString()} was initialized with $value',
          name: "➕");
    } else {
      log('Provider ${provider.name ?? provider.toString()} was initialized',
          name: "➕");
    }
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    log('Provider ${provider.name ?? provider.toString()} was disposed',
        name: "🗑");
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log('Provider ${provider.name ?? provider.toString()} updated from $previousValue to $newValue',
        name: "🔄");
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    log('Provider ${provider.name ?? provider.toString()} threw $error at $stackTrace',
        name: "❌");
  }
}
