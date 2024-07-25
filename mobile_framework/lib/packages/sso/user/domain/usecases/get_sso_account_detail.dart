// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobile_framework/mobile_framework.dart';

class GetSSOAccountDetailUC extends NoParamsLongRunningUseCase<SSOAccount> {
  ISSOAccountRepository repository;

  GetSSOAccountDetailUC({
    required this.repository,
  });

  @override
  Future<SSOAccount> call({void params}) {
    return repository
        .getSSOAccountDetail()
        .onError((error) => showError(error))
        .mapToValue()
        .onNullJustReturn(SSOAccount());
  }
}
