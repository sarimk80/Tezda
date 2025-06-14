import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tezda/view/product_list.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  void _submit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: _email,
              password: _confirmPassword,
            );
         if(credential.user !=null){
               Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ProductList()),
          (route) => false,
        );
            }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Flushbar(
            messageText: Text("The password provided is too weak."),
            backgroundColor: Colors.red,
            messageColor: Colors.white,
          ).show(context);
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Flushbar(
            messageText: Text("The account already exists for that email."),
            backgroundColor: Colors.red,
            messageColor: Colors.white,
          ).show(context);
          print('The account already exists for that email.');
        }
      } catch (e) {
        Flushbar(
          messageText: Text(e.toString()),
          backgroundColor: Colors.red,
          messageColor: Colors.white,
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 50),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
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
                        value!.length < 6
                            ? 'Password must be at least 6 chars'
                            : null,
                onChanged: (value) {
                  _password = value;
                  setState(() {});
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator:
                    (value) =>
                        value != _password ? 'Passwords do not match' : null,
                onChanged: (value) {
                  _confirmPassword = value;
                  setState(() {});
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _submit(context),
                child: Text('Sign Up'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Already have an account? Sign In"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
