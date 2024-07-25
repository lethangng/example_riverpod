// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_framework/mobile_framework.dart';

final deleteFileUCProvider = Provider.autoDispose<DeleteFileUC>((ref) {
  return DeleteFileUC(
    repository: ref.watch<IFileRepository>(fileRepositoryProvider),
  ).setRef(ref);
});

class DeleteFileUC extends LongRunningUseCase<bool, String?>
    with RefCompatible {
  IFileRepository repository;

  DeleteFileUC({
    required this.repository,
  });

  @override
  Future<bool> call({String? params}) {
    return repository
        .deleteFile(params ?? "")
        .cancelBy(ref)
        .onSuccess((value) => showSuccess("Xoá file thành công!"))
        .isSuccess();
  }
}
