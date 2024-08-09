// ignore_for_file: unused_field

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:longevity_hub/components/Profile/custom_popup.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/models/gym_memberships_model/get_gym_video_model.dart';
import 'package:longevity_hub/screens/gym_membership_screens/excercise_screen.dart';
import 'package:longevity_hub/screens/gym_membership_screens/workout_detail_video_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:longevity_hub/utils/constants.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class WorkOutDetailScreen extends StatefulWidget {
  final VideoData videoData;
  const WorkOutDetailScreen({Key? key, required this.videoData})
      : super(key: key);

  @override
  State<WorkOutDetailScreen> createState() => _WorkOutDetailScreenState();
}

class _WorkOutDetailScreenState extends State<WorkOutDetailScreen> {
  late List<bool> _checkboxSelected;
  String? _videoThumbnail;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _generateThumbnail();
    _checkboxSelected = List<bool>.filled(widget.videoData.repsCount!, false);

    _loadUserId();
  }

  Future<void> _generateThumbnail() async {
    final String? thumbnail = await VideoThumbnail.thumbnailFile(
      video: baseURL + widget.videoData.video!,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      quality: 25,
    );

    setState(() {
      _videoThumbnail = thumbnail;
    });
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString('UserId');
      _loadRepsSelection();
    });
  }

  Future<void> _loadRepsSelection() async {
    if (_userId != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _checkboxSelected[0] =
            prefs.getBool('${_userId}_${widget.videoData.id}_reps_0') ?? false;
        _checkboxSelected[1] =
            prefs.getBool('${_userId}_${widget.videoData.id}_reps_1') ?? false;
        _checkboxSelected[2] =
            prefs.getBool('${_userId}_${widget.videoData.id}_reps_2') ?? false;
      });
    }
  }

  Future<void> _saveRepsSelection(int index) async {
    if (_userId != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('${_userId}_${widget.videoData.id}_reps_$index',
          _checkboxSelected[index]);
    }
  }

  void _onCheckboxTap(int index) {
    setState(() {
      if (index == 0 || _checkboxSelected[index - 1]) {
        _checkboxSelected[index] = true;
        _saveRepsSelection(index);
      } else {
        CustomPopup.showError("pleasecompleteprevious".tr);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              AppImages.backArrow,
              scale: 10,
              color: ColorManager.kblackColor,
            ),
          ),
          title: Text(
            "MyExercises".tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: ColorManager.kblackColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    "exercise".tr,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: ColorManager.kblackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                GestureDetector(
                  onTap: () {
                    Get.to(WorkOutVideoScreen(
                        videoUrl: widget.videoData.fireBaseAttachmentLink!,
                        name: widget.videoData.title!));
                  },
                  child: Container(
                    height: Get.height * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image:
                            // _videoThumbnail != null
                            //     ? FileImage(File(_videoThumbnail!))
                            //     :
                            AssetImage(AppImages.videotemp),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
                Padding(
                  padding: EdgeInsets.only(left: Get.width * .06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.videoData.title ?? "exercise".tr,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: ColorManager.kblackColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      SizedBox(
                        width: Get.width * 0.8,
                        child: Text(
                          widget.videoData.description ?? "",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: ColorManager.kGreyColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      ...List.generate(widget.videoData.repsCount!, (index) {
                        return ListTile(
                          onTap: () => _onCheckboxTap(index),
                          leading: Image.asset(
                            _checkboxSelected[index]
                                ? AppImages.checkbox
                                : AppImages.unselected,
                            height: Get.height * 0.02,
                          ),
                          title: Text(
                            "${index + 1}${index == 0 || index == 30 ? 'st' : index == 1 || index == 20 || index == 21 || index == 31 ? 'nd' : index == 2 || index == 22 ? 'rd' : 'th'} ${index == 0 ? "Rep" : "Reps"} ",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: ColorManager.kblackColor,
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: Get.height * 0.14,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: Get.width * 0.04),
                            child: CustomButton(
                              buttonheight: Get.height * 0.06,
                              backgroundColor: ColorManager.kPrimaryColor,
                              buttonwidth: Get.width * 0.8,
                              onPress: () {
                                Get.to(() => const GymExerciseScreen());
                              },
                              radius: 25,
                              mywidget: Text(
                                "Done".tr,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: ColorManager.kblackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
