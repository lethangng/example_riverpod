import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/packages/clean_architecture/core/domain/usecase/usecase.dart';

class RefUseCaseProviderFactory {
  static Provider<T> create<R, P, T extends RefUseCase<R, P>>(
      T Function(ProviderRef<T> ref) createFn,
      {List<ProviderOrFamily>? dependencies}) {
    return Provider<T>((ref) {
      return createFn(ref).setRef(ref);
    }, dependencies: dependencies);
  }

  static AutoDisposeProvider<T>
      createAutoDispose<R, P, T extends RefUseCase<R, P>>(
          T Function(ProviderRef<T> ref) createFn,
          {List<ProviderOrFamily>? dependencies}) {
    return Provider.autoDispose<T>((ref) {
      return createFn(ref).setRef(ref);
    }, dependencies: dependencies);
  }

  static AutoDisposeProviderFamily<T, Arg>
      createAutoDisposeFamily<R, P, Arg, T extends RefUseCase<R, P>>(
          T Function(ProviderRef<T> ref, Arg arg) createFn,
          {List<ProviderOrFamily>? dependencies}) {
    return Provider.family.autoDispose<T, Arg>((ref, arg) {
      return createFn(ref, arg).setRef(ref);
    }, dependencies: dependencies);
  }

  static ProviderFamily<T, Arg>
      createFamily<R, P, Arg, T extends RefUseCase<R, P>>(
          T Function(ProviderRef<T> ref, Arg arg) createFn,
          {List<ProviderOrFamily>? dependencies}) {
    return Provider.family<T, Arg>((ref, arg) {
      return createFn(ref, arg).setRef(ref);
    }, dependencies: dependencies);
  }
}
