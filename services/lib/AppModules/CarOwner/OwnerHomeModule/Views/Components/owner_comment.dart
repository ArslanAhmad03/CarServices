
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/AppModules/AuthModules/ViewModels/auth_view_model.dart';

class OwnerChat extends StatefulWidget {
  final String email;

  OwnerChat({super.key, required this.email});

  @override
  State<OwnerChat> createState() => _OwnerChatState();
}

class _OwnerChatState extends State<OwnerChat> {
  AuthViewModel authViewModel = Get.put(AuthViewModel());
  List commentsList = [];

  @override
  void initState() {
    super.initState();
    authViewModel.getComments(email: widget.email);
  }

  void _addComment() {
    if (authViewModel.controllerComment.value.text.isNotEmpty) {
      authViewModel.comments(email: widget.email).then((_) {
        authViewModel.getComments(email: widget.email);
      });
      authViewModel.controllerComment.value.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 5.0,
              ),
              const Text(
                'Comments',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(
                height: 320,
                child: authViewModel.commentsList.isEmpty
                    ? const Center(
                        child: Text(
                          'No comments available',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      )
                    : ListView.builder(
                        itemCount: authViewModel.commentsList.length,
                        itemBuilder: (BuildContext, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12.0)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    authViewModel.commentsList[index]['owner_image'] != null
                                        ? SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: ClipOval(
                                              child: Image.network(
                                                authViewModel.commentsList[index]['owner_image'],
                                                fit: BoxFit.cover,
                                              )
                                            ),
                                          )
                                        : const Icon(
                                            FluentIcons.fluent_24_filled,
                                            size: 30,
                                          ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(authViewModel.commentsList[index]['owner_name'] ?? 'name here'),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        SizedBox(
                                          width: 250,
                                          child: Text(
                                            authViewModel.commentsList[index]['msg'],
                                            style: const TextStyle(fontSize: 12.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 280,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        controller: authViewModel.controllerComment.value,
                        decoration: const InputDecoration(
                          hintText: 'add comment...',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.text,
                        style: const TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      FluentIcons.send_16_filled,
                      size: 20.0,
                    ),
                    onPressed: () {
                      _addComment();
                      // if (authViewModel.controllerComment.value.text.isNotEmpty) {
                      //   authViewModel.comments(email: widget.email);
                      //
                      //   authViewModel.controllerComment.value.clear();
                      // } else {
                      //   //
                      // }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
