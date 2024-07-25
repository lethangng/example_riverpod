import 'package:mobile_framework/packages/clean_architecture/core/domain/usecase/usecase.dart';

typedef VoidUseCase<Parameters> = UseCase<void, Parameters>;
typedef VoidLongRunningUseCase<Parameters>
    = LongRunningUseCase<void, Parameters>;
typedef NoParamsUseCase<ReturnType> = UseCase<ReturnType, void>;
typedef NoParamsLongRunningUseCase<ReturnType>
    = LongRunningUseCase<ReturnType, void>;

typedef BoolUseCase<Parameters> = UseCase<bool, Parameters>;
typedef BoolLongRunningUseCase<Parameters>
    = LongRunningUseCase<bool, Parameters>;
typedef BoolNoParamsUseCase = UseCase<bool, void>;
typedef BoolNoParamsLongRunningUseCase = LongRunningUseCase<bool, void>;
