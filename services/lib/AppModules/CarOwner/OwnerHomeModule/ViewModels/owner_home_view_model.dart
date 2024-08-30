import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:services/AppModules/CarOwner/OwnerBookingModule/ViewModel/booking_view_model.dart';
import 'package:services/AppModules/ServiceProvider/ServiceProfileModule/Models/service_model.dart';
import 'package:services/AppModules/ServiceProvider/ServiceProfileModule/Models/user_model.dart';

class OwnerHomeViewModel extends GetxController{

  RxBool favourite = false.obs;
  RxBool bookMark = false.obs;

  RxBool pause = false.obs;
  RxList<UserModel> serviceProviderList  = <UserModel>[].obs;
  RxList<ServiceModel> getSer = <ServiceModel>[].obs;
  RxList<BookingModel> getBookData = <BookingModel>[].obs;
  RxList<String> getBookmarkUrl = <String>[].obs;

  getServiceProviders() async {
    FirebaseFirestore.instance.collection("AppUsers").snapshots().listen((event) {
      serviceProviderList.value = UserModel.jsonToList(event.docs).where((element) => element.userType=="1").toList();
    });
  }

  getServices({required email}) async {
    try {
      await FirebaseFirestore.instance.collection('AppUsers').doc(email).collection('Services').snapshots().listen((event) {
        getSer.value = ServiceModel.jsonToList(event.docs).toList();
      });
    } catch (e) {e.toString();}
  }

  getBookingData({required email}) async {
    try{
      await FirebaseFirestore.instance.collection('AppUsers').doc(email).collection('Booking').snapshots().listen((event) {
        getBookData.value = BookingModel.jsonToList(event.docs);
      });
    }catch(e){e.toString();}
  }

  void favouriteServices({required serviceEmail, required serviceName, required ownerEmail, required ownerName}) async {
      try{
        if(favourite == true){
          print("favourite $favourite");
          await FirebaseFirestore.instance.collection("AppUsers").doc(serviceEmail).collection("Favourite")
              .add({
            "favourite" : true,
            "service_email" : serviceEmail,
            "service_name" : serviceName,
            "owner_name" : ownerName,
            "owner_email" : ownerEmail,
          });

          await FirebaseFirestore.instance.collection("AppUsers").doc(ownerEmail).collection("Favourite")
              .add({
            "favourite" : true,
            "service_email" : serviceEmail,
            "service_name" : serviceName,
            "owner_name" : ownerName,
            "owner_email" : ownerEmail,
          });
        }else{
          print("favourite $favourite");
          try {
            QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('AppUsers').doc(serviceEmail).collection('Favourite').where('service_email', isEqualTo: serviceEmail)
                .limit(1)
                .get();
            if (querySnapshot.docs.isNotEmpty) {
              DocumentReference docRef = querySnapshot.docs.first.reference;
              await docRef.update({'favourite': false});
            } else {
              print('Document not found');
            }
          } catch (e) {
            print('Error favourite: $e');
          }
          try {
            QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('AppUsers').doc(ownerEmail).collection('Favourite').where('owner_email', isEqualTo: ownerEmail)
                .limit(1)
                .get();
            if (querySnapshot.docs.isNotEmpty) {
              DocumentReference docRef = querySnapshot.docs.first.reference;
              await docRef.update({'favourite': false});
            } else {
              print('Document not found');
            }
          } catch (e) {
            print('Error favourite: $e');
          }
        }
      }catch(e){e.toString();}
  }

  void bookmarkServices({required serviceEmail, required serviceName, required videoUrls, required ownerEmail, required ownerName}) async {
    try{
      if(bookMark == true){
        print("bookMark $bookMark");
        await FirebaseFirestore.instance.collection("AppUsers").doc(serviceEmail).collection("BookMark")
            .add({
          "bookmark" : true,
          "service_email" : serviceEmail,
          "service_name" : serviceName,
          "owner_name" : ownerName,
          "owner_email" : ownerEmail,
          "service-video" : videoUrls,
        });

        await FirebaseFirestore.instance.collection("AppUsers").doc(ownerEmail).collection("BookMark")
            .add({
          "bookmark" : true,
          "service_email" : serviceEmail,
          "service_name" : serviceName,
          "owner_name" : ownerName,
          "owner_email" : ownerEmail,
          "service-video" : videoUrls,
        });
      }else{
        print("bookMark $bookMark");
        try {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('AppUsers').doc(serviceEmail).collection('BookMark').where('service_email', isEqualTo: serviceEmail)
              .limit(1)
              .get();
          if (querySnapshot.docs.isNotEmpty) {
            DocumentReference docRef = querySnapshot.docs.first.reference;
            await docRef.update({'bookmark': false});
          } else {
            print('Document not found');
          }
        } catch (e) {
          print('Error bookmark: $e');
        }
        try {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('AppUsers').doc(ownerEmail).collection('BookMark').where('owner_email', isEqualTo: ownerEmail)
              .limit(1)
              .get();
          if (querySnapshot.docs.isNotEmpty) {
            DocumentReference docRef = querySnapshot.docs.first.reference;
            await docRef.update({'bookmark': false});
          } else {
            print('Document not found');
          }
        } catch (e) {
          print('Error bookmark: $e');
        }
      }
    }catch(e){e.toString();}
  }

  isFavourite({required email}) async {
    try{
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('AppUsers').doc(email).collection('Favourite').where('service_email', isEqualTo: email)
          .limit(1)
          .get();
      if(querySnapshot.docs.isNotEmpty){
        favourite.value = querySnapshot.docs.first["favourite"];
      }else{
        print('favo not found');
      }
    }catch(e){print(e.toString());}
  }

  isBookmark({required email}) async {
    try{
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('AppUsers').doc(email).collection('BookMark').where('service_email', isEqualTo: email)
          .limit(1)
          .get();
      if(querySnapshot.docs.isNotEmpty){
        bookMark.value = querySnapshot.docs.first["bookmark"];
      }else{
        print('favo not found');
      }
    }catch(e){print(e.toString());}
  }

  void getBookmarkVideo({required ownerEmail}) async{
    try{
      await FirebaseFirestore.instance.collection("AppUsers").doc(ownerEmail).collection("BookMark").snapshots().listen((QuerySnapshot snapshot) {
        snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
          var bookmark = documentSnapshot.get('bookmark');
          if(bookmark == true){
            var videoUrls = documentSnapshot.get("service-video");
            if(videoUrls != null){
              getBookmarkUrl.add(videoUrls);
            }
          }else{
            print('not found');
          }
        });
      });
    }catch(e){print(e.toString());}
  }
}