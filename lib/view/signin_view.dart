import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tezda/view/product_list.dart';
import 'package:tezda/view/signup_view.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
            if(credential.user !=null){
               Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ProductList()),
          (route) => false,
        );
            }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credentia') {
          Flushbar(
            messageText: Text("Incorrect credentia"),
            backgroundColor: Colors.red,
            messageColor: Colors.white,
          ).show(context);
          print("invalid-credentia");
        }
        if (e.code == 'user-not-found') {
          Flushbar(
            messageText: Text("No user found for that email."),
            backgroundColor: Colors.red,
            messageColor: Colors.white,
          ).show(context);
        } else if (e.code == 'wrong-password') {
          Flushbar(
            messageText: Text("Wrong password provided for that user."),
            backgroundColor: Colors.red,
            messageColor: Colors.white,
          ).show(context);
        } else {
          Flushbar(
            messageText: Text(e.code),
            backgroundColor: Colors.red,
            messageColor: Colors.white,
          ).show(context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator:
                    (value) =>
                        value!.isEmpty ? 'Please enter your email' : null,
                onSaved: (value) => _email = value!.trim(),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator:
                    (value) =>
                        value!.isEmpty ? 'Please enter your password' : null,
                onSaved: (value) => _password = value!,
              ),
              SizedBox(height: 24),
              ElevatedButton(onPressed: _submit, child: Text('Sign In')),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignupView()),
                  );
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
