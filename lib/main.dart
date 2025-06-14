import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tezda/model/products_model.dart';
import 'package:tezda/service/firebase_service.dart';
import 'package:tezda/service/product_service.dart';
import 'package:tezda/view/product_detail_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tezda/view/product_list.dart';
import 'package:tezda/view/signin_view.dart';
import 'package:tezda/view/signup_view.dart';
import 'firebase_options.dart';

part 'main.g.dart';

@riverpod
String helloWorld(Ref ref) {
  return 'Hello world';
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final value = ref.watch(firebaseUserProvider);

    ref.listen(firebaseUserProvider, (_, next) {
      if (next.value != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ProductList()),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SigninView()),
          (route) => false,
        );
      }
    });

    return CircularProgressIndicator();
  }
}
