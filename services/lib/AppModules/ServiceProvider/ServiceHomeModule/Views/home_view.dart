
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/AppModules/AuthModules/ViewModels/auth_view_model.dart';
import 'package:services/AppModules/CarOwner/OwnerHomeModule/ViewModels/owner_home_view_model.dart';
import 'package:services/AppModules/ServiceProvider/ServiceHomeModule/Views/Components/tab_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  OwnerHomeViewModel ownerHomeViewModel = Get.put(OwnerHomeViewModel());
  AuthViewModel authViewModel = Get.put(AuthViewModel());

  @override
  void initState(){
    super.initState();
    //authViewModel.getAllUserData();

    ownerHomeViewModel.getBookingData(email: authViewModel.controllerEmail.value.text);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleAppBar = const TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold);
    TextStyle textStyleTab = const TextStyle(fontSize: 15.0);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Orders',
              style: textStyleAppBar,
            ),
            bottom: TabBar(
              labelColor: Colors.black87,
              indicatorColor: Colors.grey.shade800,
              unselectedLabelColor: Colors.black38,
              tabs: [
                Tab(
                  child: Text(
                    'Pending',
                    style: textStyleTab,
                  ),
                ),
                Tab(
                  child: Text(
                    'Completed',
                    style: textStyleTab,
                  ),
                ),
                Tab(
                  child: Text(
                    'Canceled',
                    style: textStyleTab,
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              OrderListView(status: "Pending"),
              OrderListView(status: "Completed"),
              OrderListView(status: "Cancelled"),
            ],
          ),
        ),
      ),
    );
  }
}