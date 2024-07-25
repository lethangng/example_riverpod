import 'package:mobile_framework/mobile_framework.dart';

class DeleteSSOAccountUC extends BoolNoParamsLongRunningUseCaseBuilder {
  final ISSOAccountRepository repository;

  DeleteSSOAccountUC(this.repository) : super(
      builder: () => repository
          .deleteSSOAccount()
          .isSuccess());
}