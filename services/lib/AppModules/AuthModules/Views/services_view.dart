import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:services/AppModules/AuthModules/ViewModels/auth_view_model.dart';
import 'package:services/AppModules/ServiceProvider/ServiceProfileModule/Models/service_model.dart';

class ServiceView extends StatefulWidget {
  final List<ServiceModel> service;

  ServiceView({super.key, required this.service});

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  AuthViewModel authViewModel = Get.put(AuthViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'My Services',
          style: textStyle,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: widget.service.length,
          itemBuilder: (BuildContext, index) {
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.8,
                              child: ListView(
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    widget.service[index].service_name,
                                    style: const TextStyle(fontSize: 20.0),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(color: Colors.grey, blurRadius: 0.5)
                                      ],
                                    ),
                                    child: TextField(
                                      controller: authViewModel.controllerUpdateServiceName.value,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: widget.service[index].service_name,
                                        hintStyle: TextStyle(color: Colors.grey),
                                        prefixIcon: Icon(FluentIcons.app_title_20_regular),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(color: Colors.grey, blurRadius: 0.5)
                                      ],
                                    ),
                                    child: TextField(
                                      controller: authViewModel.controllerPrice.value,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: widget.service[index].service_price,
                                        hintStyle: TextStyle(color: Colors.grey),
                                        prefixIcon: Icon(FluentIcons.app_title_20_regular),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(color: Colors.grey, blurRadius: 0.5)
                                      ],
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: TextField(
                                        controller: authViewModel.controllerDescription.value,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: widget.service[index].service_desc,
                                          hintStyle: TextStyle(color: Colors.grey),
                                        ),
                                        keyboardType: TextInputType.text,
                                        maxLines: 5,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  ElevatedButton(
                                    onPressed: (){
                                      if(authViewModel.controllerUpdateServiceName.value.text.isEmpty){
                                        Fluttertoast.showToast(
                                          msg: 'enter service name',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                        );
                                      }else if(authViewModel.controllerPrice.value.text.isEmpty){
                                        Fluttertoast.showToast(
                                          msg: 'enter price',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                        );
                                      }else if(authViewModel.controllerDescription.value.text.isEmpty){
                                        Fluttertoast.showToast(
                                          msg: 'enter description',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                        );
                                      }else {
                                        authViewModel.updateServices(serviceName: widget.service[index].service_name);

                                        authViewModel.showProgressDialog(context, 'Please wait...');
                                        Future.delayed(Duration(seconds: 3),() {
                                         Get.back();
                                        });

                                        Get.back();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black87,
                                    ),
                                    child: const Text('Update Service',style: TextStyle(color: Colors.white),),
                                  ),
                                ],
                              )
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 1.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(widget.service[index].service_name,  style: const TextStyle(overflow: TextOverflow.ellipsis)),
                        subtitle: SizedBox(height: 60,width: 130,child: Text(widget.service[index].service_desc, style: const TextStyle(overflow: TextOverflow.ellipsis))),
                        trailing: Text(widget.service[index].service_price,  style: const TextStyle(overflow: TextOverflow.ellipsis)),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
