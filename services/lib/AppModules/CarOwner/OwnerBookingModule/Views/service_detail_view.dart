
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services/AppModules/CarOwner/OwnerBookingModule/Views/booking_order_view.dart';
import 'package:services/AppModules/CarOwner/OwnerHomeModule/ViewModels/owner_home_view_model.dart';
import 'package:services/AppModules/ServiceProvider/ServiceProfileModule/Models/user_model.dart';

import '../../../AuthModules/ViewModels/auth_view_model.dart';

class ServiceDetailView extends StatefulWidget {
  final UserModel userModel;

  const ServiceDetailView({super.key, required this.userModel});

  @override
  State<ServiceDetailView> createState() => _ServiceDetailViewState();
}

class _ServiceDetailViewState extends State<ServiceDetailView> {
  OwnerHomeViewModel ownerHomeViewModel = OwnerHomeViewModel();
  AuthViewModel authViewModel = Get.put(AuthViewModel());

  TextStyle textStyle = TextStyle(fontSize: 15,fontWeight: FontWeight.w600);
  TextStyle _textStyle = TextStyle(fontSize: 15,fontWeight: FontWeight.w400);

  @override
  void initState() {
    // TODO: implement initState
    ownerHomeViewModel.isFavourite(email: widget.userModel.userEmail);
    ownerHomeViewModel.getServices(email: widget.userModel.userEmail);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Service Detail',
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 350,
            width: 100.w,
            color: Colors.grey.shade200,
            child: Image.network(
              widget.userModel.userImage,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: Adaptive.h(40),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(widget.userModel.userName,style: textStyle),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(widget.userModel.userEmail,style: _textStyle),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(widget.userModel.userPhone,style: _textStyle),
                  const SizedBox(
                    height: 80,
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 50,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.grey.shade200),
                          child: IconButton(
                            onPressed: () {
                              ownerHomeViewModel.favourite.value = !ownerHomeViewModel.favourite.value;
                              ownerHomeViewModel.favouriteServices(serviceName: widget.userModel.userName, serviceEmail: widget.userModel.userEmail, ownerName: authViewModel.controllerName.value.text, ownerEmail: authViewModel.controllerEmail.value.text);
                            },
                            icon: ownerHomeViewModel.favourite.value
                                ? const Icon(
                                    FluentIcons.heart_12_filled,
                                    color: Colors.red,
                                    size: 35,
                                  )
                                : const Icon(
                                    FluentIcons.heart_12_regular,
                                    size: 35,
                                  ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.grey.shade200),
                          child: ElevatedButton(
                            onPressed: () {
                              authViewModel.delayAnimation(page: BookingOrder(userModel:  widget.userModel,service: ownerHomeViewModel.getSer));
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
                              'Book Now',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
