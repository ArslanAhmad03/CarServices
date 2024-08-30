
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services/AppModules/AuthModules/ViewModels/auth_view_model.dart';
import 'package:services/AppModules/AuthModules/Views/signup_view.dart';
import 'package:services/AppModules/CarOwner/OwnerHomeModule/Views/owner_app_route_page.dart';
import 'package:services/AppModules/ServiceProvider/ServiceHomeModule/Views/app_route.dart';
import 'package:services/Utis/text_edit_field.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  AuthViewModel authViewModel = Get.put(AuthViewModel());

  void signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: authViewModel.controllerEmail.value.text,
        password: authViewModel.controllerPassword.value.text,
      );
      final userDoc = await FirebaseFirestore.instance
          .collection('AppUsers')
          .doc(authViewModel.controllerEmail.value.text)
          .get();

      if (authViewModel.controllerEmail.value.text.isEmpty) {
        Fluttertoast.showToast(
            msg: 'Enter email',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      } else if (authViewModel.controllerPassword.value.text.isEmpty) {
        Fluttertoast.showToast(
            msg: 'Enter password',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      }

      authViewModel.showProgressDialog(context, 'Confirming...');
      Future.delayed(Duration(seconds: 2), (){
        if (userDoc.exists) {
          final userType = userDoc.data()!['user_type'];
          if (userType == '1') {
            Get.offAll(const AppRoute());
            Fluttertoast.showToast(
              msg: 'Sign In Success',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
          } else {
            Get.to(const OwnerAppRoutePage());
            Fluttertoast.showToast(
              msg: 'Sign In Success',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
          }
        }
      });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        Fluttertoast.showToast(
            msg: 'The account does not exist',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      }
      if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: 'wrong password',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
      if (e.code == 'channel-error') {
        Fluttertoast.showToast(
          msg: 'Enter email & password',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
      if (e.code == 'invalid-email') {
        Fluttertoast.showToast(
          msg: 'email not correct',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    }
  }

  @override
  void initState(){
    super.initState();
    /// authViewModel.getAllUserData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => authViewModel.loading.value
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Get.to(
                                    const SignUpView()
                                );
                                authViewModel.controllerEmail.value.clear();
                                authViewModel.controllerPassword.value.clear();
                              },
                              child: const Text(
                                'SignUp',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 130,
                        ),
                        const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 40.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Text(
                          'Enter Your Detail To Proceed Further',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        TextEditField(
                          controller: authViewModel.controllerEmail.value,
                          hintText: "Email",
                          width: 100.w,
                          prefixIcon: Icons.email,
                          inputType: TextInputType.emailAddress,
                          errorText: authViewModel.emailValidate.value ? 'enter email' : null,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        TextEditField(
                          controller: authViewModel.controllerPassword.value,
                          hintText: "Password",
                          width: 100.w,
                          prefixIcon: Icons.password,
                          inputType: TextInputType.visiblePassword,
                          errorText: authViewModel.passValidate.value ? 'enter password' : null,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: authViewModel.isChecked.value,
                              onChanged: (value) {
                                authViewModel.isChecked.value = value!;
                                if(authViewModel.isChecked.value){
                                  authViewModel.rememberStatus();
                                }else{
                                  authViewModel.logout();
                                }
                              },
                            ),
                            const Text('Remember'),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              signIn();
                              authViewModel.getAllUserData();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              elevation: 8,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account"),
                            TextButton(
                              onPressed: () {
                                Get.to(const SignUpView());
                              },
                              child: const Text('SignUp'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}