import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/AppModules/AuthModules/ViewModels/auth_view_model.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    AuthViewModel authViewModel = Get.put(AuthViewModel());
    TextStyle textStyle = const TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: textStyle,
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Name ',
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: authViewModel.controllerName.value,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Enter Name...",
                    border: InputBorder.none,
                    prefixIcon: Icon(FluentIcons.person_12_filled),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Phone',
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: authViewModel.controllerPhone.value,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Enter Phone...",
                    border: InputBorder.none,
                    prefixIcon: Icon(FluentIcons.phone_12_filled),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    authViewModel.updateProfile();

                    authViewModel.showProgressDialog(context, "wait...");
                    Future.delayed(Duration(seconds: 3), (){
                      Get.back();
                    });
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black54,
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
