import 'package:mobile_framework/mobile_framework.dart';

class CheckUserExistedUC extends RefLongRunningUseCase<bool, String> {
  ISSOAccountRepository repository;

  @override
  Future<bool> call({String? params}) async {
    return repository
        .checkUserExisted(params ?? "")
        .asFuture()
        .then((value) => value.isSuccess);
  }

  CheckUserExistedUC({
    required this.repository,
  });
}

final checkUserExistedUCProvider = RefUseCaseProviderFactory.createAutoDispose(
    (ref) => CheckUserExistedUC(repository: SSOAccountRepository()));
