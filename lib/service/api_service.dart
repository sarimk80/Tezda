import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:tezda/model/products_model.dart';

class ApiService {
  final Dio dio = Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com'));

  Future<List<ProductsModel>> getAllProducts() async {
    final response = await dio.get('/products');
    final data = response.data as List;

    var products = data.map((json) => ProductsModel.fromJson(json)).toList();
    return products;
  }
}
