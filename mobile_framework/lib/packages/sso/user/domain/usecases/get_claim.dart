import 'package:mobile_framework/mobile_framework.dart';

class GetClaimUC extends NoParamsLongRunningUseCaseBuilder<SSOAccount> {
  ISSOAccountRepository repository;

  GetClaimUC(this.repository)
      : super(builder: () {
          return repository
              .getClaims()
              .mapToValue()
              .onNullJustReturn(SSOAccount());
        });
}
