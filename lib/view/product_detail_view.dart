import 'package:flutter/material.dart';
import 'package:tezda/model/products_model.dart';

class ProductDetailView extends StatelessWidget {
  final ProductsModel model;
  const ProductDetailView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(model.title ?? '')),
      body: Column(
        children: [
          Text(model.description ?? ''),
          Text(model.category ?? ''),
          Text(model.rating?.count.toString() ?? ''),
          Text(model.price.toString() ?? ''),
          Text(model.rating?.rate.toString() ?? ''),
        ],
      ),
    );
  }
}
