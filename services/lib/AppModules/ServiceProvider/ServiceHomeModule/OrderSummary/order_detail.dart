import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:services/AppModules/CarOwner/OwnerBookingModule/ViewModel/booking_view_model.dart';
import 'package:services/AppModules/ServiceProvider/ServiceHomeModule/ViewModels/home_view_model.dart';

class OrderDetail extends StatefulWidget {
  final BookingModel order;

  const OrderDetail({super.key, required this.order});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  HomeViewModel homeViewModel = Get.put(HomeViewModel());

  TextStyle textStyleAppBar = const TextStyle(
      color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold);
  TextStyle titleText = const TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.w800,
      overflow: TextOverflow.ellipsis);
  TextStyle greyText = const TextStyle(
      color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.order.serviceSelect),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Order Summary',
                style: textStyleAppBar,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: ClipOval(
                              child: Image.network(
                                widget.order.serviceImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Divider(
                        color: Colors.red,
                        endIndent: 60,
                        indent: 60,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'ID',
                            style: greyText,
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 180,
                            child: Text(
                              widget.order.ownerId,
                              style: titleText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'Name',
                            style: greyText,
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 180,
                            child: Text(
                              widget.order.ownerName,
                              style: titleText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'Phone',
                            style: greyText,
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 180,
                            child: Text(
                              widget.order.ownerPhone,
                              style: titleText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'Email',
                            style: greyText,
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 180,
                            child: Text(
                              widget.order.ownerEmail,
                              style: titleText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'Status',
                            style: greyText,
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 180,
                            child: Text(
                              widget.order.status,
                              style: titleText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'Description',
                            style: greyText,
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 180,
                            child: Text(
                              widget.order.serviceDesc,
                              style: titleText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'Schedule',
                            style: greyText,
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 180,
                            child: Text(
                              "${DateFormat.yMMMEd().format(widget.order.date)}",
                              style: titleText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Text(
                            'Time',
                            style: greyText,
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 180,
                            child: Text(
                              "${DateFormat.jm().format(widget.order.time)}",
                              style: titleText,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      const Divider(
                        color: Colors.red,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Total',
                                    style: greyText,
                                  ),
                                  const Spacer(),
                                  Text(
                                    widget.order.servicePrice,
                                    style: titleText,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          if (widget.order.status != "Completed" &&
                              widget.order.status != "Cancelled")
                            ElevatedButton(
                              onPressed: () {
                                homeViewModel.acceptOrder(
                                    serviceEmail: widget.order.serviceEmail,
                                    serviceId: widget.order.serviceId,
                                    ownerEmail: widget.order.ownerEmail,
                                    ownerId: widget.order.ownerId);
                                Get.back();
                              },
                              child: Text("Accept",
                                  style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                            ),
                          const Spacer(),
                          if (widget.order.status != "Completed" &&
                              widget.order.status != "Cancelled")
                            ElevatedButton(
                              onPressed: () {
                                homeViewModel.rejectOrder(
                                    serviceEmail: widget.order.serviceEmail,
                                    serviceId: widget.order.serviceId,
                                    ownerEmail: widget.order.ownerEmail,
                                    ownerId: widget.order.ownerId);
                                Get.back();
                              },
                              child: Text("Reject",
                                  style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                            ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
