import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services/AppModules/AuthModules/ViewModels/auth_view_model.dart';
import 'package:services/AppModules/AuthModules/Views/signin_view.dart';
import 'package:services/AppModules/AuthModules/Views/uploading_view.dart';
import 'package:services/AppModules/CarOwner/OwnerHomeModule/Views/owner_app_route_page.dart';
import 'package:services/AppModules/ServiceProvider/ServiceProfileModule/Models/service_model.dart';
import 'package:services/AppModules/ServiceProvider/ServiceProfileModule/Models/user_model.dart';
import 'package:services/Utis/text_edit_field.dart';
import 'package:path/path.dart' as path;

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  AuthViewModel authViewModel = Get.put(AuthViewModel());
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> getImage(ImageSource source) async {
    final photo = await ImagePicker().pickImage(source: source);
    if (photo != null) {
      authViewModel.image.value = photo.path;
    }
    uploadImage();
  }
  Future<void> uploadImage() async {
    final file = File(authViewModel.image.value);
    final filename = path.basename(file.path);
    final ref = _storage.ref().child(filename);
    final uploadTask = ref.putFile(file);

    await uploadTask;
    final downurl = await ref.getDownloadURL().then((value) {
      authViewModel.imageUrl.value = value;
    });

    print('Image Url : ${authViewModel.imageUrl.value}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'SignUp',
                    style:
                        TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'Enter Your Detail To Proceed Further',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(60.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black54,
                                spreadRadius: 1.0,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 120,
                                width: 120,
                                child: Obx(
                                  () => ClipOval(
                                    child: authViewModel.image.value == ""
                                        ? Image.asset(
                                            'assets/dummy.png',
                                            fit: BoxFit.cover,
                                          )
                                        : Image.file(
                                            File(authViewModel.image.value),
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 120,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(12.0),
                                              topLeft: Radius.circular(12.0),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 60,
                                                      width: 60,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          getImage(ImageSource
                                                              .gallery);
                                                          Get.back();
                                                        },
                                                        icon: Image.asset(
                                                          'assets/gallery.png',
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Text(
                                                      'Gallery',
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 60,
                                                      width: 60,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          getImage(ImageSource
                                                              .camera);
                                                          Get.back();
                                                        },
                                                        icon: Image.asset(
                                                          'assets/camera.png',
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Text(
                                                      'Camera',
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.white,
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt_outlined,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('  Name'),
                        const SizedBox(height: 5.0),
                        TextEditField(
                          controller: authViewModel.controllerName.value,
                          hintText: "Name",
                          width: 100.w,
                          prefixIcon: Icons.person,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        const Text('  Email'),
                        const SizedBox(height: 5.0),
                        TextEditField(
                          controller: authViewModel.controllerEmail.value,
                          hintText: "Email",
                          width: 100.w,
                          prefixIcon: Icons.email,
                          inputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        const Text('  Phone'),
                        const SizedBox(height: 5.0),
                        TextEditField(
                          controller: authViewModel.controllerPhone.value,
                          hintText: "Phone",
                          width: 100.w,
                          prefixIcon: Icons.phone,
                          inputType: TextInputType.phone,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        const Text('  Password'),
                        const SizedBox(height: 5.0),
                        Obx(() => TextEditField(
                              controller:
                                  authViewModel.controllerPassword.value,
                              hintText: "Password",
                              width: 100.w,
                              prefixIcon: Icons.password,
                              inputType: TextInputType.visiblePassword,
                              isPassword: authViewModel.hidepassword.value,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  authViewModel.hidepassword.value =
                                      !authViewModel.hidepassword.value;
                                },
                                icon: !authViewModel.hidepassword.value
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                              ),
                            )),
                        const SizedBox(
                          height: 15.0,
                        ),
                        const Text('  Confirm Password'),
                        const SizedBox(height: 5.0),
                        Obx(() => TextEditField(
                              controller:
                                  authViewModel.controllerConfirmPassword.value,
                              hintText: "Confirm Password",
                              width: 100.w,
                              prefixIcon: Icons.password,
                              inputType: TextInputType.visiblePassword,
                              isPassword: authViewModel.hidpassword.value,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  authViewModel.hidpassword.value =
                                      !authViewModel.hidpassword.value;
                                },
                                icon: !authViewModel.hidpassword.value
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: SelectRadio.Service,
                              groupValue: authViewModel.character.value,
                              onChanged: (SelectRadio? value) {
                                authViewModel.character.value = value!;
                              },
                            ),
                            const Text(' Services '),
                          ],
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Row(
                          children: [
                            Radio(
                              value: SelectRadio.Owner,
                              groupValue: authViewModel.character.value,
                              onChanged: (SelectRadio? value) {
                                authViewModel.character.value = value!;
                              },
                            ),
                            const Text(' Owner '),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                email: authViewModel.controllerEmail.value.text,
                                password: authViewModel.controllerPassword.value.text,
                              )
                              .then((value) => {
                                    if (authViewModel.controllerName.value.text.isEmpty)
                                      {
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter name'), duration: Duration(milliseconds: 300))),
                                      }
                                    else if (authViewModel.controllerEmail.value.text.isEmpty)
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text('Enter email'), duration: Duration(milliseconds: 300))),
                                      }
                                    else if (authViewModel.controllerPhone.value.text.isEmpty)
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(content: Text('Enter phone'), duration: Duration(milliseconds: 300))),
                                      }
                                    else if (authViewModel.controllerPassword.value.text.isEmpty)
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(content: Text('Enter password'), duration: Duration(milliseconds: 300))),
                                      }
                                    else if (authViewModel.controllerConfirmPassword.value.text.isEmpty)
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(content: Text('Enter confirm password'), duration: Duration(milliseconds: 300))),
                                      }
                                    else if (authViewModel.controllerPassword.value.text != authViewModel.controllerConfirmPassword.value.text)
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text('password not same'), duration: Duration(milliseconds: 300))),
                                      }
                                    else if (authViewModel.character.value.toString() == 'SelectRadio.Service')
                                      {
                                        Get.offAll(UploadView(userModel: UserModel(
                                          userId: authViewModel.id.value,
                                          userType: "1",
                                          userName: authViewModel.controllerName.value.text,
                                          userEmail: authViewModel.controllerEmail.value.text,
                                          userPhone: authViewModel.controllerPhone.value.text,
                                          userPassword: authViewModel.controllerPassword.value.text,
                                          userImage: authViewModel.imageUrl.value,
                                          userVideo: '',
                                        ))),
                                      }
                                    else
                                      {
                                        authViewModel.signUp(userModel: UserModel(
                                                userId: authViewModel.id.value,
                                                userType: "0",
                                                userName: authViewModel.controllerName.value.text,
                                                userEmail: authViewModel.controllerEmail.value.text,
                                                userPhone: authViewModel.controllerPhone.value.text,
                                                userPassword: authViewModel.controllerPassword.value.text,
                                                userImage: authViewModel.imageUrl.value,
                                                userVideo: ''),
                                            serviceModel: ServiceModel(
                                                service_name: '',
                                                service_price: '',
                                                service_desc: '')),
                                        Get.offAll(const OwnerAppRoutePage()),
                                        Fluttertoast.showToast(
                                          msg: 'Account Created',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                        ),
                                      }
                                  });
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            Fluttertoast.showToast(
                                msg: 'The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            Fluttertoast.showToast(
                                msg:
                                    'The account already exists for this email.');
                          }
                        }
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
                        'Sign Up',
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
                      const Text("Already have an account"),
                      TextButton(
                        onPressed: () {
                          Get.back(
                            result: const SignInView(),
                          );
                          authViewModel.controllerName.value.clear();
                          authViewModel.controllerEmail.value.clear();
                          authViewModel.controllerPhone.value.clear();
                          authViewModel.controllerPassword.value.clear();
                          authViewModel.controllerConfirmPassword.value.clear();
                        },
                        child: const Text('SignIn'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
