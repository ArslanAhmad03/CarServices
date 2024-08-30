import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/AppModules/AuthModules/ViewModels/auth_view_model.dart';
import 'package:services/AppModules/AuthModules/Views/signin_view.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthViewModel authViewModel = Get.put(AuthViewModel());
  @override
  void initState() {
    super.initState();
    authViewModel.loginStatus();

    Future.delayed(
      const Duration(seconds: 2),
      () {
        Get.offAll(
          const SignInView(),
          duration: const Duration(milliseconds: 300),
          transition: Transition.rightToLeft,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Logo.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
