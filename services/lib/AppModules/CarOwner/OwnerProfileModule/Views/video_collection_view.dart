import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/AppModules/CarOwner/OwnerProfileModule/Views/ViewModels/profile_view_model.dart';
import 'package:video_player/video_player.dart';

class VideoCollectionList extends StatefulWidget {
  final List<String> videoUrls;

  const VideoCollectionList({
    super.key,
    required this.videoUrls,
  });

  @override
  State<VideoCollectionList> createState() => _VideoCollectionListState();
}

class _VideoCollectionListState extends State<VideoCollectionList> {
  ProfileViewModel profileViewModel = Get.put(ProfileViewModel());

  final controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    for (String videoUrl in widget.videoUrls) {
      final videoController  = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
        ..initialize().then((_) {
          setState(() {
            profileViewModel.isVideoLoading.add(false);
          });
        });
      videoController.addListener(() {
        if (!videoController.value.isInitialized || videoController.value.isBuffering) {
          setState(() {
            profileViewModel.isVideoLoading[profileViewModel.controllers.indexOf(videoController)] = true;
          });
        } else {
          setState(() {
            profileViewModel.isVideoLoading[profileViewModel.controllers.indexOf(videoController)] = false;
          });
        }
      });

      videoController.pause();
      videoController.setLooping(true);
      profileViewModel.controllers.add(videoController);
      profileViewModel.isVideoLoading.add(true);
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (var videoController in profileViewModel.controllers) {
      videoController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Saved Videos',
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: PageView.builder(
          controller: controller,
          itemCount: widget.videoUrls.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    if (profileViewModel.controllers[index].value.isPlaying) {
                      profileViewModel.controllers[index].pause();
                    } else {
                      profileViewModel.controllers[index].play();
                      // profileViewModel.isPlaying.value = true;
                    }
                  },
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: controller.viewportFraction,
                      child: VideoPlayer(profileViewModel.controllers[index]),
                    ),
                  ),
                ),
                if (profileViewModel.isVideoLoading[index])
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                Obx(
                  () => profileViewModel.isPlaying.value
                      ? const SizedBox()
                      : Positioned(
                          top: 320,
                          right: 150,
                          child: IconButton(
                              onPressed: () {
                                profileViewModel.controllers[index].play();
                                profileViewModel.isPlaying.value = true;
                              },
                              icon: Icon(
                                FluentIcons.play_12_filled,
                                color: Colors.white,
                                size: 50.0,
                              ))
                          //
                          ),
                ),
              ],
            );
          },
        ));
  }
}
