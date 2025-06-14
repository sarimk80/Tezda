import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda/model/products_model.dart';
import 'package:tezda/service/product_service.dart';
import 'package:tezda/view/ios_native.dart';
import 'package:tezda/view/product_detail_view.dart';
import 'package:tezda/view/user_profile.dart';

class ProductList extends ConsumerWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(getUserListProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfile()),
              );
            },
            icon: Icon(Icons.person_2_rounded),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => IosNative()),
              );
            },
            icon: Icon(Icons.apple_rounded),
          ),
        ],
        title: Text("Products"),
      ),
      body: value.when(
        data:
            (data) => ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return productTile(data[index], context);
              },
            ),
        error: (error, _) => Text(error.toString()),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

Widget productTile(ProductsModel model, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(top: 8, bottom: 8, left: 4, right: 4),
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailView(model: model),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white70,
        ),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: model.image ?? '',
              imageBuilder: (context, image) {
                return Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: image, fit: BoxFit.contain),
                  ),
                );
              },
            ),
            SizedBox(width: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(model.title ?? '', softWrap: true),
            ),
            Spacer(),
            Text(" ${model.price.toString()}"),
          ],
        ),
      ),
    ),
  );
}
