
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services/AppModules/AuthModules/ViewModels/auth_view_model.dart';
import 'package:services/AppModules/ServiceProvider/ServiceProfileModule/Models/service_model.dart';
import 'package:services/AppModules/ServiceProvider/ServiceProfileModule/Models/user_model.dart';

class BookingOrder extends StatefulWidget {
  final UserModel userModel;
  final List<ServiceModel> service;
  const BookingOrder({super.key, required this.userModel, required this.service});

  @override
  State<BookingOrder> createState() => _BookingOrderState();
}

class _BookingOrderState extends State<BookingOrder> {
  AuthViewModel authViewModel = Get.put(AuthViewModel());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleText = const TextStyle(
      color: Colors.black54,
      fontSize: 15.0,
      fontWeight: FontWeight.w600,
    );
    TextStyle greyText = TextStyle(
      color: Colors.grey.shade400,
      fontSize: 15.0,
      fontWeight: FontWeight.w600,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(6.0),
                child: Card(
                  child: Container(
                    height: Adaptive.h(60),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.userModel.userName,
                                  style: titleText,
                                ),
                                const Spacer(),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(widget.userModel.userImage),
                                ),
                              ],
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'UserID',
                              style: greyText,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              widget.userModel.userId.toString(),
                              style: titleText,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Email',
                              style: greyText,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              widget.userModel.userEmail,
                              style: titleText,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Number',
                              style: greyText,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              widget.userModel.userPhone,
                              style: titleText,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: Obx(
                                () => DropdownButtonFormField(
                                  onChanged: (Value) {
                                    authViewModel.selectedService.value = Value!;
                                  },
                                  items: List.generate(widget.service.length, (index) => DropdownMenuItem(
                                      value: widget.service[index].service_name,
                                        child: Text(widget.service[index].service_name)),
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'select service',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Price',
                              style: greyText,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Obx(() =>
                            Text(authViewModel.selectedService.value.isNotEmpty
                                  ? '${widget.service.firstWhere((element) => element.service_name == authViewModel.selectedService.value).service_price}'
                                  : 'Price not available',
                              style: titleText,
                            ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Description',
                              style: greyText,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Obx(() =>
                            Text(authViewModel.selectedService.value.isNotEmpty
                                  ? '${widget.service.firstWhere((service) => service.service_name == authViewModel.selectedService.value).service_desc}'
                                  : 'Service not selected',
                              style: titleText,
                            ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Card(
                child: Container(
                  height: Adaptive.h(50),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          authViewModel.controllerName.value.text,
                          style: titleText,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Number',
                          style: greyText,
                        ),
                        const SizedBox(height: 5.0),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: TextField(
                            controller: authViewModel.controllerPhone.value,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: "Enter Number...",
                              border: InputBorder.none,
                              prefixIcon: Icon(FluentIcons.person_48_filled),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Date',
                          style: greyText,
                        ),
                        const SizedBox(height: 5.0),
                        Obx(
                          () => Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: TextField(
                              keyboardType: TextInputType.datetime,
                              readOnly: true,
                              onTap: () {
                                authViewModel.selectDate(context);
                              },
                              onChanged: (value) {},
                              controller: TextEditingController(text: DateFormat.yMMMEd().format(authViewModel.selectedDate.value)),
                              decoration: InputDecoration(
                                hintText:  "Select a date",
                                border: InputBorder.none,
                                prefixIcon: const Icon(FluentIcons.calendar_12_filled),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Time',
                          style: greyText,
                        ),
                        const SizedBox(height: 5.0),
                        Obx(
                          () => Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: TextField(
                              keyboardType: TextInputType.datetime,
                              readOnly: true,
                              onTap: () {
                                authViewModel.selectTime(context);
                              },
                              onChanged: (value) {},
                              controller: TextEditingController(text: DateFormat.jm().format(authViewModel.selectedTime.value)),
                              decoration: InputDecoration(
                                hintText:"Select a time",
                                border: InputBorder.none,
                                prefixIcon:
                                    const Icon(FluentIcons.clock_12_filled),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                elevation: 8,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if(authViewModel.selectedService.value.isEmpty){
                                  Fluttertoast.showToast(
                                      msg: 'select service',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM);
                                } else if(authViewModel.controllerPhone.value.text.isEmpty){
                                  Fluttertoast.showToast(
                                      msg: 'enter phone',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM);
                                }else{
                                  authViewModel.showProgressDialog(context, 'checking...');
                                  Future.delayed(const Duration(seconds: 3), () {

                                    authViewModel.bookingOrder(
                                        userModel: widget.userModel,
                                        serviceModel: ServiceModel(
                                          service_name: authViewModel.selectedService.value,
                                          service_price: widget.service.firstWhere((element) => element.service_name == authViewModel.selectedService.value).service_price,
                                          service_desc: widget.service.firstWhere((element) => element.service_name == authViewModel.selectedService.value).service_desc,
                                        ));

                                    Fluttertoast.showToast(
                                        msg: 'ordered',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM);
                                    authViewModel.selectedService.value = "";

                                    Get.back();
                                  });
                                }
                              },
                              child: const Text(
                                'Confirm',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
