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
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // EMAIL
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter Your Email id',
                ),
              ),
              const SizedBox(height: 20),
              // PASSWORD
              TextFormField(
                controller: _psswordController,
                decoration: const InputDecoration(
                  hintText: 'Enter Your Password',
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

                          UserCredential userCredential = await loginRepo.login(
                            loginModel: LoginModel(
                              email: _emailController.text.toLowerCase().trim(),
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
      )),
    );
  }
}
