import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:operaeasy_app/services/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return MockApiService();
});
