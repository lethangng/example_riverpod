import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final refreshTokenServiceProvider = Provider<IRefreshTokenService>((ref) =>
    throw UnimplementedError(
        "IRefreshTokenService must be overridden in ProviderScope"));
final refreshTokenRequestDetectorProvider =
    Provider<RefreshTokenRequestDetector>((ref) => throw UnimplementedError(
        "RefreshTokenRequestDetector must be overridden in ProviderScope"));

abstract class IRefreshTokenService {
  abstract bool isRefreshToken;

  Future<bool> refreshToken();
}

abstract class RefreshTokenRequestDetector {
  bool isRefreshTokenRequest(DioException exp);
}
