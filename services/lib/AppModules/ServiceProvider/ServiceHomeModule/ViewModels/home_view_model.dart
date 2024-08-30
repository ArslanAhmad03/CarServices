import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  RxInt index = 0.obs;

  acceptOrder({required String serviceEmail, required String serviceId,required String ownerEmail, required String ownerId}) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('AppUsers').doc(ownerEmail).collection('Booking').where('owner_id', isEqualTo: int.parse(ownerId))
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        await docRef.update({'status': 'Completed'});

      } else {
        print('Document not found for ownerId: $ownerId');
      }
    } catch (e) {
      print('Error Completed order: $e');
    }
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('AppUsers').doc(serviceEmail).collection('Booking').where('service_id', isEqualTo: int.parse(serviceId))
          .limit(1)
          .get();
      print(querySnapshot.docs);
      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        await docRef.update({'status': 'Completed'});

      } else {
        print('Document not found for ownerId: $serviceId');
      }
    } catch (e) {
      print('Error Completed order: $e');
    }
  }

  rejectOrder({required String serviceEmail, required String serviceId, required String ownerEmail, required String ownerId}) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('AppUsers').doc(ownerEmail).collection('Booking').where('owner_id', isEqualTo: int.parse(ownerId))
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {

        DocumentReference docRef = querySnapshot.docs.first.reference;
        await docRef.update({'status': 'Cancelled'});

      } else {
        print('Document not found for ownerId: $ownerId');
      }
    } catch (e) {
      print('Error Cancelled order: $e');
    }
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('AppUsers').doc(serviceEmail).collection('Booking').where('service_id', isEqualTo: int.parse(serviceId))
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {

        DocumentReference docRef = querySnapshot.docs.first.reference;
        await docRef.update({'status': 'Cancelled'});

      } else {
        print('Document not found for ownerId: $serviceId');
      }
    } catch (e) {
      print('Error Cancelled order: $e');
    }
  }

}
