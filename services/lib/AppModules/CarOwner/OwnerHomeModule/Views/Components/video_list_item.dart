import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:services/AppModules/AuthModules/ViewModels/auth_view_model.dart';
import 'package:services/AppModules/CarOwner/OwnerBookingModule/Views/service_detail_view.dart';
import 'package:services/AppModules/CarOwner/OwnerHomeModule/ViewModels/owner_home_view_model.dart';
import 'package:services/AppModules/CarOwner/OwnerHomeModule/Views/Components/owner_comment.dart';
import 'package:services/AppModules/ServiceProvider/ServiceProfileModule/Models/user_model.dart';
import 'package:video_player/video_player.dart';

class ProviderListItem extends StatefulWidget {
  final UserModel userModel;

  const ProviderListItem({super.key, required this.userModel,});

  @override
  State<ProviderListItem> createState() => _ProviderListItemState();
}

class _ProviderListItemState extends State<ProviderListItem> {
  OwnerHomeViewModel ownerHomeViewModel = OwnerHomeViewModel();
  AuthViewModel authViewModel = Get.put(AuthViewModel());
  VideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    ownerHomeViewModel.isFavourite(email: widget.userModel.userEmail);
    ownerHomeViewModel.isBookmark(email: widget.userModel.userEmail);
    authViewModel.getComments(email: widget.userModel.userEmail);

    controller = VideoPlayerController.networkUrl(Uri.parse(widget.userModel.userVideo))
          ..initialize().then((_) {
            setState(() {});
          });
    controller!.play();
    controller!.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            if (controller!.value.isPlaying) {
              controller!.pause();
              ownerHomeViewModel.pause.value = true;
            } else {
              controller!.play();
              ownerHomeViewModel.pause.value = false;
            }
          },
          onDoubleTap: () {
            ownerHomeViewModel.favourite.value = !ownerHomeViewModel.favourite.value;
          },
          child: Center(
            child: controller!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: controller!.value.aspectRatio,
                    child: VideoPlayer(controller!),
                  )
                : const CircularProgressIndicator(),
          ),
        ),
        Obx(
          () => ownerHomeViewModel.pause.value
              ? Positioned(
                  top: 360,
                  right: 150,
                  child: IconButton(
                     onPressed: () {
                       controller!.play();
                       ownerHomeViewModel.pause.value = false;
                     },
                    icon: Icon(FluentIcons.play_12_filled, color: Colors.white, size: 50.0),
                  ),
                )
              : const SizedBox(),
        ),
        Positioned(
          bottom: 20,
          left: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(widget.userModel.userName),
              const SizedBox(
                height: 5.0,
              ),
              const SizedBox(
                width: 300,
                child: Text(
                  'https://drive.google.com/file/d/1GzBAL17ypGidmNDPpsbY-0Yq80zVW-83/view?usp=drive_link',
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
        Obx(
          () => Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {

                    authViewModel.delayAnimation(page: ServiceDetailView(userModel: widget.userModel));
                    controller!.pause();

                  },
                  child: CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(widget.userModel.userImage),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                IconButton(
                  onPressed: () {

                    ownerHomeViewModel.favourite.value = !ownerHomeViewModel.favourite.value;
                    ownerHomeViewModel.favouriteServices(serviceName: widget.userModel.userName, serviceEmail: widget.userModel.userEmail, ownerName: authViewModel.controllerName.value.text, ownerEmail: authViewModel.controllerEmail.value.text);
                  },
                  icon: ownerHomeViewModel.favourite.value
                      ? const Icon(
                          FluentIcons.heart_12_filled,
                          color: Colors.red,
                          size: 35,
                        )
                      : const Icon(
                          FluentIcons.heart_12_regular,
                          size: 35,
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return OwnerChat(email: widget.userModel.userEmail);
                      },
                    );
                  },
                  icon: const Icon(
                    FluentIcons.chat_12_regular,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                IconButton(
                  onPressed: () {

                    ownerHomeViewModel.bookMark.value = !ownerHomeViewModel.bookMark.value;
                    ownerHomeViewModel.bookmarkServices(serviceName: widget.userModel.userName, serviceEmail: widget.userModel.userEmail, videoUrls: widget.userModel.userVideo ,ownerName: authViewModel.controllerName.value.text, ownerEmail: authViewModel.controllerEmail.value.text);
                    },
                  icon: ownerHomeViewModel.bookMark.value
                      ? const Icon(
                          FluentIcons.bookmark_16_filled,
                          color: Colors.amber,
                          size: 30,
                        )
                      : const Icon(
                          FluentIcons.bookmark_16_regular,
                          size: 30,
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                IconButton(
                  onPressed: () async {
                    await FlutterShare.share(
                        title: 'Send',
                        linkUrl: 'https://drive.google.com/file/d/1GzBAL17ypGidmNDPpsbY-0Yq80zVW-83/view?usp=drive_link');
                  },
                  icon: const Icon(
                    FluentIcons.share_16_regular,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
