import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/AppModules/AuthModules/ViewModels/auth_view_model.dart';
import 'package:services/AppModules/CarOwner/OwnerBookingModule/Views/Components/owner_tab_view.dart';
import 'package:services/AppModules/CarOwner/OwnerHomeModule/ViewModels/owner_home_view_model.dart';

class OwnerBookingView extends StatefulWidget {
  const OwnerBookingView({super.key});

  @override
  State<OwnerBookingView> createState() => _OwnerBookingViewState();
}

class _OwnerBookingViewState extends State<OwnerBookingView> {
  OwnerHomeViewModel ownerHomeViewModel = Get.put(OwnerHomeViewModel());
  AuthViewModel authViewModel = Get.put(AuthViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('/.................owner_booking_view');
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
              'My Order',
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
                OrderListsView(status: 'Pending'),
                OrderListsView(status: 'Completed'),
                OrderListsView(status: 'Cancelled'),
              ],
          ),
        ),
      ),
    );
  }
}
