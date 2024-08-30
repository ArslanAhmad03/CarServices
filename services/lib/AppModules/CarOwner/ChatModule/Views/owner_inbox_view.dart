
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/AppModules/CarOwner/ChatModule/Views/InboxListItem/inbox_list_item.dart';

class OwnerInboxView extends StatelessWidget {
  const OwnerInboxView({super.key});

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
          actions: [
            IconButton(
                onPressed: (){
                  print('search');
                  },
                icon: const Icon(FluentIcons.search_12_regular,size: 25,color: Colors.black,),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: 10,
            itemBuilder: (context, int index){
              return GestureDetector(
                onTap: (){
                  print("tap index tile $index");
                  Get.to(InboxListItem(username: index));
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
    );
  }
}
