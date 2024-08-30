import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services/AppModules/AuthModules/ViewModels/auth_view_model.dart';
import 'package:services/AppModules/CarOwner/OwnerHomeModule/ViewModels/owner_home_view_model.dart';
import 'package:services/AppModules/ServiceProvider/ServiceHomeModule/OrderSummary/order_detail.dart';

class OrderListView extends StatefulWidget {
  OrderListView({super.key, required this.status});

  final String status;

  @override
  State<OrderListView> createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  OwnerHomeViewModel ownerHomeViewModel = Get.put(OwnerHomeViewModel());

  AuthViewModel authViewModel = AuthViewModel();

  TextStyle textStyleTab = const TextStyle(fontSize: 15.0);

  TextStyle titleTabView = const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w800);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Obx(() =>
          SizedBox(
            height: Adaptive.h(75),
            child: ownerHomeViewModel.getBookData.where((p0) => p0.status == widget.status).isEmpty
                ? const Center(
                    child: Text(
                      'No data available',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView.builder(
                    itemCount: ownerHomeViewModel.getBookData
                        .where((p0) => p0.status == widget.status)
                        .length,
                    itemBuilder: (context, index) {
                      final added = ownerHomeViewModel.getBookData
                          .where((p0) => p0.status == widget.status)
                          .toList()[index];
                      if (added.status == widget.status) {
                        return GestureDetector(
                          onTap: () {
                            authViewModel.delayAnimation(
                                page: OrderDetail(order: added));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          ownerHomeViewModel
                                              .getBookData[index].ownerName,
                                          style: titleTabView,
                                        ),
                                        const Spacer(),
                                        Text(
                                            'RS/= ${ownerHomeViewModel.getBookData[index].servicePrice}'),
                                      ],
                                    ),
                                    const Spacer(),
                                    const Row(
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            'Service',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                        Spacer(),
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            'Schedule',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: 150,
                                            child: Text(
                                              ownerHomeViewModel
                                                  .getBookData[index]
                                                  .serviceSelect,
                                              style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            )),
                                        const Spacer(),
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            "${DateFormat.jm().format(ownerHomeViewModel.getBookData[index].time)}",
                                            style: const TextStyle(
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        Icon(
                                            widget.status == "Pending"
                                                ? Icons.timelapse_rounded
                                                : widget.status == "Completed"
                                                    ? Icons
                                                        .check_circle_outlined
                                                    : widget.status == "Cancelled"
                                                        ? Icons.cancel_outlined
                                                        : Icons.error_rounded,
                                            color: widget.status == "Pending"
                                                ? Colors.orangeAccent
                                                : widget.status == "Completed"
                                                    ? Colors.green
                                                    : widget.status == "Cancelled"
                                                        ? Colors.red
                                                        : Colors.grey),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
          ),
          ),
        ],
      ),
    );
  }
}
