// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/data/controller/gym_membership_controller/gym_membership_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:video_player/video_player.dart';

class WorkOutVideoScreen extends StatefulWidget {
  final String videoUrl;
  String name = "Exercise";
  WorkOutVideoScreen({super.key, required this.videoUrl, required this.name});

  @override
  _WorkOutVideoScreenState createState() => _WorkOutVideoScreenState();
}

class _WorkOutVideoScreenState extends State<WorkOutVideoScreen> {
  late VideoPlayerController _controller;
  bool _isPlaying = true;
  bool _isMuted = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    final fullVideoUrl = widget.videoUrl;
    log(fullVideoUrl);
    _controller = VideoPlayerController.networkUrl(Uri.parse(fullVideoUrl))
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      }).catchError((error) {
        log("Video initialization error: $error");
        setState(() {
          _hasError = true;
        });
      });

    _controller.addListener(() {
      setState(() {
        GymMembershipController.i.setVideoDuration(_controller.value.position);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _playPause() {
    setState(() {
      if (_isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  void _muteUnmute() {
    setState(() {
      if (_isMuted) {
        _controller.setVolume(1.0);
      } else {
        _controller.setVolume(0.0);
      }
      _isMuted = !_isMuted;
    });
  }

  // String _formatDuration(Duration duration) {
  //   String twoDigits(int n) => n.toString().padLeft(2, "0");
  //   String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  //   String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  //   return "$twoDigitMinutes:$twoDigitSeconds";
  // }
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: _hasError
                ? Text(
                    "Failed to load video",
                    style: GoogleFonts.poppins(
                      fontSize: 17,
                      color: ColorManager.kWhiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : const CircularProgressIndicator(),
          ),
          Positioned(
              top: Get.height * 0.05,
              left: Get.width * 0.04,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  AppImages.backbutton,
                  scale: 10,
                ),
              )),
          Positioned(
            bottom: Get.height * 0.05,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: ColorManager.kWhiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    colors: const VideoProgressColors(
                      playedColor: Colors.orange,
                      bufferedColor: Colors.grey,
                      backgroundColor: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(_controller.value.position),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: ColorManager.kWhiteColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        _formatDuration(_controller.value.duration),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: ColorManager.kWhiteColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.repeat_rounded),
                        iconSize: 25,
                        color: Colors.white,
                        onPressed: _playPause,
                      ),
                      SizedBox(
                        width: Get.width * 0.04,
                      ),
                      Image.asset(
                        AppImages.back,
                        scale: 15,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: Get.width * 0.04,
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: Icon(_isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill),
                        iconSize: 64,
                        onPressed: _playPause,
                      ),
                      SizedBox(
                        width: Get.width * 0.04,
                      ),
                      Image.asset(
                        AppImages.forward,
                        scale: 15,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: Get.width * 0.04,
                      ),
                      IconButton(
                        icon:
                            Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
                        color: Colors.white,
                        onPressed: _muteUnmute,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
