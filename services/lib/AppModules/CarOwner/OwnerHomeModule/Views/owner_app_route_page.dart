import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/AppModules/CarOwner/ChatModule/Views/owner_inbox_view.dart';
import 'package:services/AppModules/CarOwner/OwnerBookingModule/Views/owner_booking_view.dart';
import 'package:services/AppModules/CarOwner/OwnerHomeModule/Views/owner_home_view.dart';
import 'package:services/AppModules/CarOwner/OwnerProfileModule/Views/owner_profile_view.dart';
import 'package:services/AppModules/ServiceProvider/ServiceHomeModule/ViewModels/home_view_model.dart';

class OwnerAppRoutePage extends StatefulWidget {
  const OwnerAppRoutePage({super.key});

  @override
  State<OwnerAppRoutePage> createState() => _OwnerAppRoutePageState();
}

class _OwnerAppRoutePageState extends State<OwnerAppRoutePage> {
  HomeViewModel homeViewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        extendBody: true,
        body: [
          const OwnerHomeView(),
          const OwnerInboxView(),
          const OwnerBookingView(),
          OwnerProfileView(),
        ].elementAt(homeViewModel.index.value),
        bottomNavigationBar: CurvedNavigationBar(
          height: 50,
          index: 0,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.black,
          color: Colors.black38,
          animationCurve: Curves.ease,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) {
            homeViewModel.index.value = index;
          },
          letIndexChange: (index) => true,
          items: const [
            Icon(
              FluentIcons.home_12_filled,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              FluentIcons.chat_12_filled,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              FluentIcons.cart_16_filled,
              //Icons.sell_sharp,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              FluentIcons.person_12_filled,
              size: 30,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}