
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ProfileViewModel extends  GetxController{

  RxBool mark = false.obs;

  RxBool isPlaying = false.obs;

  RxList<VideoPlayerController> controllers = <VideoPlayerController>[].obs;
  RxList<bool> isVideoLoading = <bool>[].obs;
}