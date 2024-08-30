import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services/AppModules/CarOwner/OwnerBookingModule/ViewModel/booking_view_model.dart';

class OwnerOrderDetail extends StatefulWidget {
  final BookingModel order;

  const OwnerOrderDetail({
    super.key,
    required this.order,
  });

  @override
  State<OwnerOrderDetail> createState() => _OwnerOrderDetailState();
}

class _OwnerOrderDetailState extends State<OwnerOrderDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('object.....');
    print(widget.order.serviceSelect);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleAppBar = const TextStyle(
        color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold);
    TextStyle titleText = const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w800, overflow: TextOverflow.ellipsis);
    TextStyle greyText = const TextStyle(
        color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.w600);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.order.serviceSelect),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'Order Summary',
                style: textStyleAppBar,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                height: Adaptive.h(90),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
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
                              widget.order.serviceId,
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
                              widget.order.serviceName,
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
                              widget.order.servicePhone,
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
                              widget.order.serviceEmail,
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
                            'Date',
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
                        height: 20.0,
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
