import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:services/AppModules/AuthModules/ViewModels/auth_view_model.dart';
import 'package:services/AppModules/AuthModules/Views/edit_view.dart';
import 'package:services/AppModules/AuthModules/Views/forget_view.dart';
import 'package:services/AppModules/AuthModules/Views/signin_view.dart';
import 'package:path/path.dart' as path;
import 'package:services/AppModules/CarOwner/OwnerHomeModule/ViewModels/owner_home_view_model.dart';
import 'package:services/AppModules/CarOwner/OwnerProfileModule/Views/video_collection_view.dart';

class OwnerProfileView extends StatefulWidget {
  OwnerProfileView({super.key});

  @override
  State<OwnerProfileView> createState() => _OwnerProfileViewState();
}

class _OwnerProfileViewState extends State<OwnerProfileView> {
  OwnerHomeViewModel ownerHomeViewModel = Get.put(OwnerHomeViewModel());
  AuthViewModel authViewModel = Get.put(AuthViewModel());
  final FirebaseStorage storage = FirebaseStorage.instance;
  TextStyle textStyle = const TextStyle(
      color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold);

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
    final ref = storage.ref().child(filename);
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
    ownerHomeViewModel.getBookmarkVideo(
        ownerEmail: authViewModel.controllerEmail.value.text);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: textStyle,
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: authViewModel.imageUrl.value.isNotEmpty
                              ? ClipOval(
                                  child: Image.network(
                                    authViewModel.imageUrl.value,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                  ),
                                )
                              : ClipOval(
                                  child: Image.asset(
                                    'assets/Logo.png',
                                    fit: BoxFit.cover,
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
                                      borderRadius: const BorderRadius.only(
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

                                                        authViewModel
                                                            .updateProfilelImage();
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
                                                    style:
                                                        TextStyle(fontSize: 12),
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
                                                      onPressed: () async {
                                                        getImage(
                                                            ImageSource.camera);

                                                        authViewModel
                                                            .updateProfilelImage();
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
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ])),
                                  );
                                },
                              );
                            },
                            icon: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                              ),
                              child: const Icon(
                                FluentIcons.camera_16_regular,
                                size: 30.0,
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
              height: 20.0,
            ),
            Text(
              authViewModel.controllerName.value.text,
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 30,
              width: 210,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1.0,
                    ),
                  ]),
              child: Center(
                child: Text(
                  authViewModel.controllerEmail.value.text,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 365,
              width: 320,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 1.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        authViewModel.delayAnimation(
                            page: VideoCollectionList(
                                videoUrls: ownerHomeViewModel.getBookmarkUrl));
                      },
                      child: ListTile(
                        title: const Text('MyCollection'),
                        leading: const Icon(FluentIcons.collections_20_regular),
                        trailing: IconButton(
                            onPressed: () {
                              print('collection');
                            },
                            icon: const Icon(
                                FluentIcons.arrow_forward_16_filled)),
                      ),
                    ),
                    const Divider(),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return const EditProfile();
                          },
                        );
                      },
                      child: ListTile(
                        title: const Text('EditProfile'),
                        leading: const Icon(FluentIcons.edit_12_regular),
                        trailing: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return const EditProfile();
                                },
                              );
                            },
                            icon: const Icon(
                                FluentIcons.arrow_forward_16_filled)),
                      ),
                    ),
                    const Divider(),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return const ForgetPage();
                          },
                        );
                      },
                      child: ListTile(
                        title: const Text('ChangePassword'),
                        leading: const Icon(FluentIcons.lock_closed_12_regular),
                        trailing: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return const ForgetPage();
                                  });
                            },
                            icon: const Icon(
                                FluentIcons.arrow_forward_16_filled)),
                      ),
                    ),
                    const Divider(),
                    GestureDetector(
                      onTap: () {
                        print('setting');
                      },
                      child: ListTile(
                        title: const Text('Support'),
                        leading:
                            const Icon(FluentIcons.person_support_16_regular),
                        trailing: IconButton(
                            onPressed: () {
                              print('setting');
                            },
                            icon: const Icon(
                                FluentIcons.arrow_forward_16_filled)),
                      ),
                    ),
                    const Divider(),
                    GestureDetector(
                      onTap: () {
                        authViewModel.logout();
                        Get.offAll(const SignInView());
                      },
                      child: ListTile(
                        title: const Text('LogOut'),
                        leading: const Icon(FluentIcons.sign_out_20_regular),
                        trailing: IconButton(
                            onPressed: () {
                              authViewModel.logout();
                              Get.offAll(const SignInView());
                            },
                            icon: const Icon(
                                FluentIcons.arrow_forward_16_filled)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
