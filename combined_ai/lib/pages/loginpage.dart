import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:combined_ai/components/my_button.dart';
import 'package:combined_ai/components/textfield.dart';
import 'package:combined_ai/pages/registerpage.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const LoginPage({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], // Fixed background color
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('lib/images/mainlogo.png', height: 200.0),
                const SizedBox(height: 30.0),
                const Text(
                  "Welcome back, you've been missed",
                  style: TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
                const SizedBox(height: 20.0),
                _LoginForm(
                  usernameController: usernameController,
                  passwordController: passwordController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const _LoginForm({
    required this.usernameController,
    required this.passwordController,
  });

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  String? errorMessage;
  bool isLoading = false;

  Future<void> signIn() async {
    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: widget.usernameController.text.trim(),
        password: widget.passwordController.text,
      );
      setState(() => errorMessage = null);
    } on FirebaseAuthException catch (e) {
      setState(() => errorMessage = e.message);
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (errorMessage != null)
          Text(
            errorMessage!,
            style: const TextStyle(color: Colors.red, fontSize: 14.0),
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: 15.0),
        CustomTextWidget(
          controller: widget.usernameController,
          hintText: 'Email',
          obscureText: false,
        ),
        const SizedBox(height: 15.0),
        CustomTextWidget(
          controller: widget.passwordController,
          hintText: 'Password',
          obscureText: true,
        ),
        const SizedBox(height: 5.0),
        TextButton(
          onPressed: () {}, // Add forgot password functionality here
          child: const Text("Forgot Password", style: TextStyle(color: Colors.blueAccent)),
        ),
        const SizedBox(height: 25.0),
        isLoading
            ? const CircularProgressIndicator()
            : MyButton(onTap: signIn, text: 'Sign In'),
        const SizedBox(height: 25.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Don't have an Account? ", style: TextStyle(color: Colors.black)),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(
                      emailController: widget.usernameController,
                      passwordController: widget.passwordController,
                      confirmPasswordController: TextEditingController(),
                    ),
                  ),
                );
              },
              child: const Text('Register Now', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 15.0)),
            ),
          ],
        ),
      ],
    );
  }
}
