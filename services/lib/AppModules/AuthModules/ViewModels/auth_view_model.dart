
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/AppModules/CarOwner/OwnerHomeModule/Views/owner_app_route_page.dart';
import 'package:services/AppModules/ServiceProvider/ServiceHomeModule/Views/app_route.dart';
import 'package:services/AppModules/ServiceProvider/ServiceProfileModule/Models/service_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ServiceProvider/ServiceProfileModule/Models/user_model.dart';

class AuthViewModel extends GetxController{

  RxBool loading = false.obs;
  RxBool hidepassword = false.obs;
  RxBool hidpassword = false.obs;

  RxString email = ''.obs;
  RxString pass = ''.obs;

  RxBool emailValidate = false.obs;
  RxBool passValidate = false.obs;

  RxString image = ''.obs;
  RxString imageUrl = ''.obs;
  RxString videoUrl = ''.obs;

  RxBool isChecked = false.obs;

  Rx<TextEditingController> controllerName = TextEditingController().obs;
  Rx<TextEditingController> controllerEmail = TextEditingController().obs;
  Rx<TextEditingController> controllerPassword = TextEditingController().obs;
  Rx<TextEditingController> controllerPhone = TextEditingController().obs;
  Rx<TextEditingController> controllerConfirmPassword = TextEditingController().obs;
  Rx<TextEditingController> controllerPrice = TextEditingController().obs;
  Rx<TextEditingController> controllerDescription = TextEditingController().obs;
  Rx<TextEditingController> controllerComment = TextEditingController().obs;
  Rx<TextEditingController> controllerUpdateServiceName = TextEditingController().obs;
  RxString userType = ''.obs;

  RxInt id = DateTime.now().millisecondsSinceEpoch.obs;

  RxBool isLoggedIn = false.obs;

  Rx<SelectRadio> character = SelectRadio.Service.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<DateTime> selectedTime = DateTime.now().obs;
  RxString formateDate = ''.obs;
  RxString formateTime = ''.obs;

  RxList serviceOption = [].obs;
  RxList isSelected = [].obs;
  RxList<ServiceModel> services = <ServiceModel>[].obs;
  //RxList<Map<String, dynamic>> commentsList = <Map<String, dynamic>>[].obs;
  RxList<dynamic> commentsList = <dynamic>[].obs;


  Future<void> signUp({required UserModel userModel, required ServiceModel serviceModel}) async {
    try {

      FirebaseFirestore.instance.collection('AppUsers').doc(userModel.userEmail)
          .set({
        "user_id": userModel.userId,
        "user_type": userModel.userType,
        "user_name": userModel.userName,
        "user_email": userModel.userEmail,
        "user_phone": userModel.userPhone,
        "user_password": userModel.userPassword,
        "user_image": userModel.userImage,
        "user_video": userModel.userVideo,
      });

      for (int i = 0; i < services.length; i++) {
        ServiceModel service = services[i];
        await FirebaseFirestore.instance
            .collection('AppUsers')
            .doc(userModel.userEmail)
            .collection("Services")
            .doc(service.service_name)
            .set({
          "service_name": service.service_name,
          "service_price": service.service_price,
          "service_desc": service.service_desc,
        });
      }
    } catch (e) {print(e.toString());}
  }

  Future<void> updateProfilelImage() async {
    try{
      await FirebaseFirestore.instance.collection('AppUsers').doc(controllerEmail.value.text)
          .update({
        "user_image" : imageUrl.value,
      });
    }catch(e){print(e.toString());}
  }

  Future<void> getServiceOption() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("Services")
          .doc('ServicesOption')
          .get();

      List getData = snapshot.data()!['service_name'] ?? [];
      serviceOption.value = getData;

    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  RxString selectedService = ''.obs;

  void bookingOrder({required UserModel userModel, required ServiceModel serviceModel}) async {
    final now = DateTime.now();
    if(controllerEmail.value.text.isNotEmpty){
      try{
        await FirebaseFirestore.instance
            .collection('AppUsers')
            .doc(controllerEmail.value.text)
            .collection('Booking')
            .add({
          "service_id": userModel.userId,
          "service_name": userModel.userName,
          "service_email": userModel.userEmail,
          "service_phone": userModel.userPhone,
          "service_image": userModel.userImage,
          "service_video": userModel.userVideo,

          "owner_id": id.value,
          "owner_name": controllerName.value.text,
          "owner_email": controllerEmail.value.text,
          "owner_phone": controllerPhone.value.text,
          "owner_image": imageUrl.value,
          "owner_video": 'null',

          "service_select": serviceModel.service_name,
          "service_price": serviceModel.service_price,
          "service_desc": serviceModel.service_desc,

          "date": selectedDate.value.toIso8601String(),
          "time": selectedTime.value.toIso8601String(),
          "now_time": now,

          "status": "Pending",
        });
      } catch(e){
        print("Booking Order ${e.toString()}");
      }
      try{
        await FirebaseFirestore.instance
            .collection('AppUsers')
            .doc(userModel.userEmail)
            .collection('Booking')
            .add({
          "service_id": userModel.userId,
          "service_name": userModel.userName,
          "service_email": userModel.userEmail,
          "service_phone": userModel.userPhone,
          "service_image": userModel.userImage,
          "service_video": userModel.userVideo,

          "owner_id": id.value,
          "owner_name": controllerName.value.text,
          "owner_email": controllerEmail.value.text,
          "owner_phone": controllerPhone.value.text,
          "owner_image": imageUrl.value,
          "owner_video": 'null',

          "service_select": serviceModel.service_name,
          "service_price": serviceModel.service_price,
          "service_desc": serviceModel.service_desc,

          "date": selectedDate.value.toIso8601String(),
          "time": selectedTime.value.toIso8601String(),
          "now_time": now,

          "status": "Pending",
        });
      } catch(e){
        print("Booking Order ${e.toString()}");
      }
    } else{
      print("Document path is empty");
    }
  }

  Future<void> getAllUserData() async {
    try {
      await FirebaseFirestore.instance
          .collection('AppUsers')
          .doc(controllerEmail.value.text)
          .get()
          .then((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          final userData = snapshot.data() as Map<String, dynamic>;

          id.value = userData['user_id'] ?? 'id not found';
          userType.value = userData['user_type'] ?? 'user type not found';
          imageUrl.value = userData['user_image'] ?? 'No Name';
          controllerName.value.text = userData['user_name'] ?? 'No Email';
          controllerEmail.value.text = userData['user_email'] ?? 'No Status';
          controllerPhone.value.text = userData['user_phone'] ?? 'No Phone';
          videoUrl.value = userData['user_video'] ?? 'No Video';
          controllerPassword.value.text = userData['user_password'] ?? 'No Password';
        } else {
          print('Document email does not exist.');
        }
      });
    } catch (e) {
      print('is this ... ${e}');
    }
  }

  void rememberStatus() async {
    print("..................remember Status .........................");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setBool('isLoggedIn', true);
    await sharedPreferences.setString('userEmail', controllerEmail.value.text);
    await sharedPreferences.setString('userPassword', controllerPassword.value.text);
    await sharedPreferences.setString('userType', userType.value);

    isLoggedIn.value = true;
  }

  void loginStatus() async {
    print("..................login Status.........................");
    final prefs = await SharedPreferences.getInstance();
    final isLogIn = prefs.getBool('isLoggedIn') ?? false;

    isLoggedIn.value = isLogIn;

    if (isLoggedIn.value) {
      final enteredUserEmail = prefs.getString('userEmail');
      final enteredPassword = prefs.getString('userPassword');
      final userType = prefs.getString('userType');

      if (enteredUserEmail != null && enteredPassword != null) {

        if (userType == '1') {
          Get.to(const AppRoute());
        } else if (userType == '0') {
          Get.to(const OwnerAppRoutePage());
        } else {
          print('user type not found');
        }
      }
    }
  }

  void logout() async {
    print("...........auth_logout...............");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.setString('userEmail', "");
    await prefs.setString('userPassword', "");

    controllerName.value.clear();
    controllerEmail.value.clear();
    controllerPassword.value.clear();
    controllerPhone.value.clear();
    controllerConfirmPassword.value.clear();
    image.value = "";
    imageUrl.value = "";
    videoUrl.value = "";
  }

  Future<void> updateProfile() async {
    print('........update profile....');

    try {
      await FirebaseFirestore.instance.collection('AppUsers').doc(controllerEmail.value.text)
            .update({
        "user_name": controllerName.value.text,
        "user_phone": controllerPhone.value.text,
      });
    } catch (e) {
      print("error : ${e.toString()}");
    }
  }

  Future<void> updateServices({required serviceName}) async{
    print('//.................updateServices');
    print(controllerEmail.value.text);
    try{
      await FirebaseFirestore.instance.collection('AppUsers').doc(controllerEmail.value.text).collection('Services').doc(serviceName)
          .update({
        "service_name" : controllerUpdateServiceName.value.text,
        "service_price" : controllerPrice.value.text,
        "service_desc" : controllerDescription.value.text,
      });
    }catch(e){print(e.toString());}
  }

  void selectDate(context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.tryParse(formateDate.value),
        firstDate: DateTime(2018),
        lastDate: DateTime(2030));
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  void selectTime(context) async {
    print('...........selectTime,,,,,,,,,,,,,');
    await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      selectedTime.value = DateTime(0,0,0,value!.hour,value.minute);
    });
  }

  Future<void> comments({required email}) async {
    print('........comments.........');
    try{
      FirebaseFirestore.instance.collection('AppUsers').doc(email).collection('Comments')
          .add({
        "msg" : controllerComment.value.text,
        "service_email" : email,
        "owner_email" : controllerEmail.value.text,
        "owner_name" : controllerName.value.text,
        "owner_image" : imageUrl.value,
      });
    }catch(e){print(e.toString());}
  }

  Future<void> getComments({required email}) async {
    print('........get comments.........$email');
    try{
      await FirebaseFirestore.instance.collection('AppUsers').doc(email).collection('Comments').get().then((QuerySnapshot snapshot) {
        if (snapshot.docs.isNotEmpty) {
          List<DocumentSnapshot> comm = snapshot.docs;

          commentsList.clear();

          comm.forEach((comment) {commentsList.add(comment.data() as Map<String, dynamic>);
          });

        } else {
          print("data not");
        }
      });
    }catch(e){print("data not f${e.toString()}");}
  }

  void showProgressDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 30),
              Text(message),
            ],
          ),
        );
      },
    );
  }
  void delayAnimation({required Widget page, Duration duration = const Duration(milliseconds: 400), Transition transition = Transition.rightToLeft, bool opaque = true,}) {
    Get.to(page, duration: duration, transition: transition, opaque: opaque);
  }

}
enum SelectRadio { Service, Owner }
