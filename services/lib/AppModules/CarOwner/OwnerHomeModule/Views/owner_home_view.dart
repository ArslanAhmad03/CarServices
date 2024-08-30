import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/AppModules/AuthModules/ViewModels/auth_view_model.dart';
import 'package:services/AppModules/CarOwner/OwnerHomeModule/Views/Components/video_list_item.dart';
import '../ViewModels/owner_home_view_model.dart';

class OwnerHomeView extends StatefulWidget {
  const OwnerHomeView({super.key});

  @override
  State<OwnerHomeView> createState() => _OwnerHomeViewState();
}

class _OwnerHomeViewState extends State<OwnerHomeView> {
  OwnerHomeViewModel ownerHomeViewModel = OwnerHomeViewModel();
  AuthViewModel authViewModel = Get.put(AuthViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //authViewModel.getAllUserData();
    ownerHomeViewModel.getServiceProviders();
    ownerHomeViewModel.getBookingData(email: authViewModel.controllerEmail.value.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Obx(
        () => PageView.builder(
          controller: PageController(initialPage: 0),
          itemCount: ownerHomeViewModel.serviceProviderList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return ProviderListItem(
              userModel: ownerHomeViewModel.serviceProviderList[index],
            );
          },
        ),
      ),
    );
  }
}
