import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tezda/service/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final getUserListProvider = FutureProvider((ref) async {
  final api = ref.watch(apiServiceProvider);

  return api.getAllProducts();
});
