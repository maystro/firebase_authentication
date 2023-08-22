import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_authentication/controller/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signInWithEmailPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  Future<void> createUserWithEmailPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  Widget _title() {
    return const Text('Firebase Authentication');
  }

  Widget _entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget _errorMessage() {
    return Text(
      errorMessage!,
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
          isLogin ? signInWithEmailPassword : createUserWithEmailPassword,
      child: Text(isLogin ? 'Login' : 'Register'),
    );
  }

  Widget _loginAndRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Login' : 'Register'),
    );
  }

  Widget _loginWithGoogleButton() {
    return ElevatedButton(
      onPressed: () async {
        await Auth().signInWithGoogle();
      },
      child: Text('Login with Google'),
    );
  }

  Widget _loginWithFacebookButton() {
    return ElevatedButton(
      onPressed: () async {
        await Auth().signInWithGoogle();
      },
      child: Text('Login with Facebook'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _title(),
        ),
        body: Column(children: [
          _entryField('Email', _emailController),
          _entryField('Password', _passwordController),
          _errorMessage(),
          _submitButton(),
          _loginAndRegisterButton(),
          _loginWithGoogleButton(),
          _loginWithFacebookButton()
        ]));
  }
}
