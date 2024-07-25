// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

final deleteFilesUCProvider = Provider.autoDispose<DeleteFilesUC>((ref) {
  return DeleteFilesUC(
    repository: ref.watch<IFileRepository>(fileRepositoryProvider),
  ).setRef(ref);
});

class DeleteFilesUC extends LongRunningUseCase<bool, List<String>?>
    with RefCompatible {
  IFileRepository repository;

  DeleteFilesUC({
    required this.repository,
  });

  @override
  Future<bool> call({List<String>? params}) {
    return repository
        .deleteFiles(params ?? [])
        .cancelBy(ref)
        .onSuccess((value) => showSuccess("Xoá file thành công!"))
        .isSuccess();
  }
}
