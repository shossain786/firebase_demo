import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/features/login/model/login_model.dart';
import 'package:firebase_demo/features/login/repo/login_repo.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _psswordController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    log('PAGES REFRESHED');
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(
          gradient: SweepGradient(
            tileMode: TileMode.mirror,
            colors: [
              Colors.indigo,
              Colors.white54,
              Colors.deepOrangeAccent,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // EMAIL
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      hintText: 'Enter Your Email id',
                      counterStyle: TextStyle(
                        fontSize: 28,
                        color: Colors.black,
                      )),
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                // PASSWORD
                TextFormField(
                  controller: _psswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Enter Your Password',
                    counterStyle: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 20),
                // LOGIN BUTTON
                _isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          if (_emailController.text.isNotEmpty &&
                              _psswordController.text.isNotEmpty) {
                            // LOGIN LOGIC
                            log(_emailController.text.toString());
                            log(_psswordController.text.toString());
                            setState(() {
                              _isLoading = true;
                            });
                            await Future.delayed(const Duration(seconds: 2));
                            LoginRepo loginRepo = LoginRepo();

                            UserCredential userCredential =
                                await loginRepo.login(
                              loginModel: LoginModel(
                                email:
                                    _emailController.text.toLowerCase().trim(),
                                password: _psswordController.text.trim(),
                              ),
                            );
                            setState(() {
                              _isLoading = false;
                            });
                            log(userCredential.toString());
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Please provide email and password'),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          }
                        },
                        child: const Text('Login'),
                      ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
