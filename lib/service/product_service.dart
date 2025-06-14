import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tezda/model/like_product_model.dart';
import 'package:tezda/service/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final getUserListProvider = FutureProvider((ref) async {
  final api = ref.watch(apiServiceProvider);

  return api.getAllProducts();
});

final likePostProvider = FutureProvider.family<void, LikeProductModel>((
  ref,
  model,
) async {
  var box = await Hive.openBox('Products');

  box.put(model.productId, model.isLike);
});
