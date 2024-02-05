// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tanist/screens/auth/login_screen.dart';
import 'package:tanist/screens/home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  final void Function()? onPressed;
  const RegisterScreen({super.key, this.onPressed});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  createUserWithEmailAndPassword(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      setState(() {
        isLoading = false;
      });

      // Navigate to HomeScreen after successful registration
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: const HomeScreen(),
          type: PageTransitionType.rightToLeft,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The account already exists for that password.'),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The account already exists for that email.'),
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
                        createUserWithEmailAndPassword(context);
                      }
                    },
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Colors.white,
                          ))
                        : const Text("Daftar"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: const LoginScreen(),
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
                        "Sudah punya akun? Masuk disini",
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
