import 'package:mobile_framework/packages/clean_architecture/core/domain/usecase/usecase.dart';

abstract class UseCaseBuilder<ReturnType, Parameters>
    extends UseCase<ReturnType, Parameters> {
  ReturnType Function(Parameters?) builder;

  UseCaseBuilder({
    required this.builder,
  });

  @override
  ReturnType call({Parameters? params}) {
    return builder(params);
  }
}

abstract class LongRunningUseCaseBuilder<ReturnType, Parameters>
    extends LongRunningUseCase<ReturnType, Parameters> {
  final Future<ReturnType> Function(Parameters?) builder;

  LongRunningUseCaseBuilder({
    required this.builder,
  });

  @override
  Future<ReturnType> call({Parameters? params}) {
    return builder(params);
  }
}

abstract class NoParamsUseCaseBuilder<ReturnType>
    extends UseCaseBuilder<ReturnType, void> {
  NoParamsUseCaseBuilder({
    required ReturnType Function() builder,
  }) : super(builder: (_) => builder());
}

abstract class NoParamsLongRunningUseCaseBuilder<ReturnType>
    extends LongRunningUseCaseBuilder<ReturnType, void> {
  NoParamsLongRunningUseCaseBuilder({
    required Future<ReturnType> Function() builder,
  }) : super(builder: (_) => builder());
}

abstract class BoolUseCaseBuilder<Parameters>
    extends UseCaseBuilder<bool, Parameters> {
  BoolUseCaseBuilder({
    required super.builder,
  });
}

abstract class BoolLongRunningUseCaseBuilder<Parameters>
    extends LongRunningUseCaseBuilder<bool, Parameters> {
  BoolLongRunningUseCaseBuilder({
    required super.builder,
  });
}

abstract class BoolNoParamsUseCaseBuilder
    extends NoParamsUseCaseBuilder<bool> {
  BoolNoParamsUseCaseBuilder({
    required super.builder,
  });
}

abstract class BoolNoParamsLongRunningUseCaseBuilder
    extends NoParamsLongRunningUseCaseBuilder<bool> {
  BoolNoParamsLongRunningUseCaseBuilder({
    required super.builder,
  });
}

abstract class VoidUseCaseBuilder<Parameters>
    extends UseCaseBuilder<void, Parameters> {
  VoidUseCaseBuilder({
    required super.builder,
  });
}

abstract class VoidLongRunningUseCaseBuilder<Parameters>
    extends LongRunningUseCaseBuilder<void, Parameters> {
  VoidLongRunningUseCaseBuilder({
    required super.builder,
  });
}

abstract class VoidNoParamsUseCaseBuilder
    extends NoParamsUseCaseBuilder<void> {
  VoidNoParamsUseCaseBuilder({
    required super.builder,
  });
}

abstract class VoidNoParamsLongRunningUseCaseBuilder
    extends NoParamsLongRunningUseCaseBuilder<void> {
  VoidNoParamsLongRunningUseCaseBuilder({
    required super.builder,
  });
}
