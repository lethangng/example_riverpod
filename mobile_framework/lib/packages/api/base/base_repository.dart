import 'package:mobile_framework/packages/api/builders/disposable.dart';
import 'package:mobile_framework/packages/api/builders/request_creator.dart';
import 'package:mobile_framework/packages/api/builders/url_builder.dart';

/// [BaseRepository] is a base class for all repositories
/// Use [make] to create a new request
abstract class BaseRepository {
  final URLBuilder urlBuilder;

  @Deprecated("disposable will no longer be used")
  Disposable? disposable;

  BaseRepository({required this.urlBuilder, this.disposable});

  @Deprecated("Use make instead")
  RequestMaker get creator => RequestMaker(urlBuilder);

  RequestMaker get make => RequestMaker(urlBuilder);
}
