import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quizix/data/database/user_service.dart';
import 'package:quizix/data/provider/user_provider.dart';
import 'package:quizix/models/user_model.dart';
import 'package:quizix/utils/app_images.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isObscured = true;
  String? _msg;

  Future<void> _registerHandle() async {
    try{
      final data = await UserService.insertUser(UserModel(
        name: nameController.text,
        password: passwordController.text.trim(),
        email: emailController.text.trim(),
        profile: AppImages.defaultProfile,
        point: 0,
        gender: '-',
        rank: 'beginner',
      ));

      if(data == false){
        setState(() {
          _msg = 'Email sudah terdaftar';
        });
        return;
      }

      if(!mounted) return;
      context.read<UserProvider>().loadAllData();
      context.pop(); // balik ke login/home
    }catch(e){
      debugPrint('Terjadi kesalahan pada _registerHandle: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f7ff),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Icon(Icons.person_add, size: 80, color: Colors.blueAccent),
                const SizedBox(height: 20),

                const Text(
                  "Create Account",
                  style: TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Register to continue",
                  style: TextStyle(color: Colors.black54),
                ),

                const SizedBox(height: 30),

                // Name
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_outline),
                    hintText: "Full Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Name cannot be empty";
                    if (v.length < 3) return "Name too short";
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Email cannot be empty";
                    if (!v.contains("@")) return "Invalid email";
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password
                TextFormField(
                  controller: passwordController,
                  obscureText: isObscured,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isObscured ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          isObscured = !isObscured;
                        });
                      },
                    ),
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Password cannot be empty";
                    if (v.length < 6) return "Minimum 6 characters";
                    return null;
                  },
                ),
                if (_msg != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    _msg!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],


                const SizedBox(height: 30),

                // Register Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _registerHandle();
                      }
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 14),
                TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text("Already have an account? Login"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
