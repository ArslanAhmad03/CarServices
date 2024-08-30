import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services/AppModules/AuthModules/ViewModels/auth_view_model.dart';
import 'package:services/AppModules/ServiceProvider/ServiceHomeModule/Views/app_route.dart';
import 'package:services/AppModules/ServiceProvider/ServiceProfileModule/Models/service_model.dart';
import 'package:services/AppModules/ServiceProvider/ServiceProfileModule/Models/user_model.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path/path.dart' as path;

import '../../../Utis/text_edit_field.dart';

class UploadView extends StatefulWidget {
  final UserModel userModel;

  const UploadView({super.key, required this.userModel});

  @override
  State<UploadView> createState() => _UploadViewState();
}

class _UploadViewState extends State<UploadView> {
  AuthViewModel authViewModel = Get.put(AuthViewModel());
  final FirebaseStorage _storage = FirebaseStorage.instance;

  File? _video;
  VideoPlayerController? _controller;
  File? _thumbnailData;

  Future getVideo(ImageSource video) async {
    final pickedFile = await ImagePicker().pickVideo(
      source: video,
    );

    if (pickedFile != null) {
      _video = File(pickedFile.path);

      final thumbnailData = await VideoThumbnail.thumbnailFile(
        video: _video!.path,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.PNG,
        quality: 60,
      );

      setState(() {
        _thumbnailData = File(thumbnailData!);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No video selected')),
      );
    }
    _uploadVideo();
  }

  Future<void> _uploadVideo() async {
    final fileVideo = File(_video!.path);
    final fileName = path.basename(fileVideo.path);
    final ref = _storage.ref().child(fileName);
    final uploadVideo = ref.putFile(fileVideo);

    await uploadVideo;
    final downurl = ref.getDownloadURL().then((value) {
      authViewModel.videoUrl.value = value;
    });
  }

  @override
  void initState() {
    super.initState();
    authViewModel.getServiceOption();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Media'),
        elevation: 0,
        backgroundColor: Colors.black54,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    width: 5.0,
                  ),
                  Card(
                    child: SizedBox(
                      height: 200.0,
                      width: 150.0,
                      child: _controller == null && _thumbnailData != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.memory(
                                _thumbnailData!.readAsBytesSync(),
                                fit: BoxFit.cover,
                              ),
                            )
                          : IconButton(
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
                                                        getVideo(ImageSource
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
                                                      onPressed: () {
                                                        getVideo(
                                                            ImageSource.camera);
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
                                            ]),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.video_collection,
                                size: 40.0,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  const SizedBox(
                    height: 200.0,
                    width: 150.0,
                    child: Text(
                      'Upload Video to enhance your services',
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              SizedBox(
                height: 220,
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: authViewModel.serviceOption.length,
                    itemBuilder: (BuildContext, int index) {
                      return Obx(() => Row(
                            children: [
                              Checkbox(
                                value: authViewModel.isSelected.contains(
                                    authViewModel.serviceOption[index]),
                                onChanged: (value) {
                                  if (authViewModel.isSelected.contains(
                                      authViewModel.serviceOption[index])) {
                                    authViewModel.isSelected.remove(
                                        authViewModel.serviceOption[index]);
                                  } else {
                                    if (authViewModel.controllerPrice.value.text
                                            .isNotEmpty &&
                                        authViewModel.controllerDescription
                                            .value.text.isNotEmpty) {
                                      authViewModel.isSelected.add(
                                          authViewModel.serviceOption[index]);
                                    } else {
                                      authViewModel.isSelected.remove(
                                          authViewModel.serviceOption[index]);
                                    }
                                  }
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SingleChildScrollView(
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.8,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      authViewModel
                                                          .serviceOption[index],
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text('  Price'),
                                                const SizedBox(height: 5.0),
                                                TextEditField(
                                                  controller: authViewModel
                                                      .controllerPrice.value,
                                                  hintText: "Price",
                                                  width: 100.w,
                                                  prefixIcon:
                                                      Icons.price_change,
                                                  inputType:
                                                      TextInputType.number,
                                                ),
                                                const SizedBox(
                                                  height: 15.0,
                                                ),
                                                const Text('  Description'),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  height: 120,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color: Colors.grey,
                                                          blurRadius: 0.5)
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10.0),
                                                    child: TextField(
                                                      controller: authViewModel
                                                          .controllerDescription
                                                          .value,
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'enter description....',
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                      keyboardType:
                                                          TextInputType.text,
                                                      maxLines: 5,
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        if (authViewModel
                                                            .controllerPrice
                                                            .value
                                                            .text
                                                            .isEmpty) {
                                                          Fluttertoast
                                                              .showToast(
                                                            msg: 'enter Price',
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                          );
                                                        } else if (authViewModel
                                                            .controllerDescription
                                                            .value
                                                            .text
                                                            .isEmpty) {
                                                          Fluttertoast
                                                              .showToast(
                                                            msg:
                                                                'enter Description',
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                          );
                                                        } else {
                                                          ServiceModel service = ServiceModel(
                                                              service_name:
                                                                  authViewModel
                                                                          .serviceOption[
                                                                      index],
                                                              service_price:
                                                                  authViewModel
                                                                      .controllerPrice
                                                                      .value
                                                                      .text,
                                                              service_desc:
                                                                  authViewModel
                                                                      .controllerDescription
                                                                      .value
                                                                      .text);

                                                          authViewModel.services
                                                              .add(service);
                                                          authViewModel
                                                              .isSelected
                                                              .add(authViewModel
                                                                      .serviceOption[
                                                                  index]);
                                                          Get.back();
                                                        }
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Colors
                                                                      .black87),
                                                      child: const Text(
                                                        ' Ok  ',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(authViewModel.serviceOption[index]),
                            ],
                          ));
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (authViewModel.videoUrl.value.isEmpty) {
                        Fluttertoast.showToast(
                            msg: 'video uploading...',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM);
                      } else if (authViewModel
                          .controllerPrice.value.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: 'enter price...',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM);
                      } else {
                        authViewModel.showProgressDialog(context, 'Confirming...');
                        Future.delayed(Duration(seconds: 3), () {
                          try {
                            authViewModel.signUp(
                              userModel: UserModel(
                                userId: widget.userModel.userId,
                                userType: "1",
                                userName: widget.userModel.userName,
                                userEmail: widget.userModel.userEmail,
                                userPhone: widget.userModel.userPhone,
                                userPassword: widget.userModel.userPassword,
                                userImage: widget.userModel.userImage,
                                userVideo: authViewModel.videoUrl.value,
                              ),
                              serviceModel: ServiceModel(
                                service_name: '',
                                service_price: authViewModel.controllerPrice.value.text,
                                service_desc: authViewModel.controllerDescription.value.text,
                              ),
                            );
                            Get.offAll(const AppRoute());
                            Fluttertoast.showToast(
                                msg: 'Account Created',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM);
                          } catch (e) {
                            "Sign Up Page ${e.toString()}";
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black54,
                    ),
                    child: const Text(
                      '   Upload   ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
