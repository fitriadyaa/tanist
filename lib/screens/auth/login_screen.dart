// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tanist/screens/auth/register_screen.dart';
import 'package:tanist/screens/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onPressed;
  const LoginScreen({super.key, this.onPressed});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  signInWithEmailAndPassword(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      setState(() {
        isLoading = false;
      });

      // Navigate to HomeScreen after successful login
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: const HomeScreen(),
          type: PageTransitionType.rightToLeft,
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'user-not-found') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email anda belum terdaftar'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password anda salah atau belum terdaftar'),
          ),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Add two new state variables
  bool _obscureText = true; // This will toggle the password visibility
  IconData _passwordIcon = Icons.visibility_off; // This will toggle the icon

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
      _passwordIcon = _obscureText ? Icons.visibility_off : Icons.visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: OverflowBar(
              overflowSpacing: 20,
              children: [
                const Text(
                  "Halo",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const Text(
                  "Ayok pelajari tanaman anda",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextFormField(
                  controller: _email,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Email belum terisi';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  obscureText: _obscureText,
                  controller: _password,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Password belum terisi';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(_passwordIcon),
                      onPressed:
                          _togglePasswordVisibility, // Call the toggle function
                    ),
                    border: const OutlineInputBorder(),
                    focusColor: const Color(0xFF219653),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF219653)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        signInWithEmailAndPassword(context);
                      }
                    },
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                        : const Text("LOGIN"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: const RegisterScreen(),
                        type: PageTransitionType.rightToLeft,
                      ),
                    );
                  },
                  child: SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: TextButton(
                      onPressed: widget.onPressed,
                      child: const Text(
                        "Belum punya akun? Daftar disini",
                        style: TextStyle(
                          color: Color(0xFF219653),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
