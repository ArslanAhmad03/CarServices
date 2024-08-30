import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/AppModules/ServiceProvider/ChatModule/Views/inbox_view.dart';
import 'package:services/AppModules/ServiceProvider/ServiceHomeModule/ViewModels/home_view_model.dart';
import 'package:services/AppModules/ServiceProvider/ServiceHomeModule/Views/home_view.dart';
import 'package:services/AppModules/ServiceProvider/ServiceProfileModule/Views/profile_view.dart';

class AppRoute extends StatefulWidget {
  const AppRoute({super.key});

  @override
  State<AppRoute> createState() => _AppRouteState();
}

class _AppRouteState extends State<AppRoute> {
  HomeViewModel homeViewModel = Get.put(HomeViewModel());

  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        extendBody: true,
        body: [
          const HomeView(),
          const InboxView(),
          const ProfileView(),
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
