
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services/AppModules/ServiceProvider/ChatModule/InboxListItem/inbox_list_item.dart';

class InboxView extends StatelessWidget {
  const InboxView({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleAppBar = const TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Messages',style: textStyleAppBar,),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: SizedBox(
          height: Adaptive.h(90),
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, int index){
              return GestureDetector(
                onTap: (){
                  Get.to(InboxList(username: index,));
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Icon(FluentIcons.fluent_24_filled),
                    ),
                    title: Text('Name'),
                    subtitle: Text("subtitle Text automatically ImplyLeading overflow: TextOverflow.ellipsis",style: TextStyle(overflow: TextOverflow.ellipsis,),maxLines: 2,),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
