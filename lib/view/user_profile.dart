import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda/service/firebase_service.dart';
import 'package:tezda/view/signin_view.dart';

class UserProfile extends ConsumerWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(firebaselogout);
    final user = ref.watch(firebaseCurrentUser);
    return Scaffold(
      appBar: AppBar(title: Text("User Profile")),
      body: Column(
        children: [
          user.when(
            data: (data) {
              return Text(data?.email ?? '');
            },
            error: (error, stackTrace) {
              return Text(error.toString());
            },
            loading: () {
              return CircularProgressIndicator();
            },
          ),
          ElevatedButton(
            onPressed: () async {
              value.when(
                data: (data) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SigninView()),
                    (route) => false,
                  );
                },
                error: (error, _) {},
                loading: () {},
              );
            },
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
