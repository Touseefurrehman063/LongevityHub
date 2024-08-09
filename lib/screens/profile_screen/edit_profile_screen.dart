// ignore_for_file: unused_local_variable, unused_field, non_constant_identifier_names, avoid_print, no_leading_underscores_for_local_identifiers, unnecessary_import

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/Profile/edit_profile_field.dart';
import 'package:longevity_hub/components/Profile/phone_textfield.dart';
import 'package:longevity_hub/components/Profile/profile_textfield.dart';
import 'package:longevity_hub/components/custom_appbar.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/data/controller/auth_controller.dart';
import 'package:longevity_hub/data/controller/intro_steps_controller/intro_steps_controller.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/models/activity_level_model/activity_level_model.dart';
import 'package:longevity_hub/repositories/auth_repo/auth_repo.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:longevity_hub/utils/constants.dart';
import 'package:longevity_hub/utils/searchable_dropdown/searchable_disease_dropdown.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/searchable_dropdown/searchable_dropdown.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isFirstContainerSelected = false;
  bool _isLoading = false; // Define the loading state variable
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    AuthController.i.selectedDiseases.clear();
    AuthController.i.passFunc();
    StepsController.i.getactivitiylevel();
    StepsController.i.getDiseases();
    AuthController.i.selectedDiseases;
    // AuthController.i.removeCountryCode(phone)
    // if (AuthController.i.phonecont.text.isNotEmpty) {
    //   AuthController.i.phonecont.text =
    //       AuthController.i.removeCountryCode(AuthController.i.phonecont.text);
    // }
    String? phoneText = AuthController.i.phonecont.text;
    if (phoneText.isNotEmpty) {
      AuthController.i.phonecont.text =
          AuthController.i.removeCountryCode(phoneText);
    }
    super.initState();
  }

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          centerText: "editprofile".tr,
          leadingOnPressed: () async {
            // await AuthRepository().profiledetail();
            Get.back();
          },
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height * 0.02),
                  Center(
                    child: Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: ImageProfile(),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.03),
                  EditProfileCustomTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'pleaseenterusername'.tr;
                      }

                      RegExp regex = RegExp(r'^[a-zA-Z ]+$');
                      if (!regex.hasMatch(value)) {
                        return 'shouldOnlycontainAlphabets'.tr;
                      }
                      return null;
                    },
                    labelText: 'fullname'.tr,
                    hintText: 'fullname'.tr,
                    controller: AuthController.i.fullnamecont,
                  ),
                  EditPhoneCustomField(
                    keyboardTypenew: TextInputType.phone,
                    initialCountryCode:
                        AuthController.i.user?.countryCode ?? 'AE',
                    showCountryCodePicker: true,
                    onCountryCodeChanged: (code) {
                      log("Country code changed to: $code");
                      setState(() {
                        AuthController.i.countryCode = code;
                        AuthController.i.phonecont.text = AuthController.i
                            .removeCountryCode(AuthController.i.phonecont.text);
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'pleaseenterphone'.tr;
                      }

                      RegExp regex = RegExp(r'^[0-9- ]+$');
                      if (!regex.hasMatch(value)) {
                        return 'phoneshouldcontaindigits'.tr;
                      }
                      return null;
                    },
                    labelText: 'phone'.tr,
                    hintText: 'phone'.tr,
                    controller: AuthController.i.phonecont,
                  ),
                  // Center(
                  //   child: AuthTextField(
                  //     keyboardType: TextInputType.phone,
                  //     controller: AuthController.i.phone,
                  //     showCountryCodePicker: true,
                  //     formatters: [
                  //       FilteringTextInputFormatter.digitsOnly,
                  //       LengthLimitingTextInputFormatter(11),
                  //       PhoneNumberFormatter(),
                  //     ],
                  //     onCountryCodeChanged: (code) {
                  //       log("Country code changed to: $code");
                  //       setState(() {
                  //         AuthController.i.countryCode = code;
                  //       });
                  //     },
                  //     validator: (value) {
                  //       if (value!.isEmpty) {
                  //         return 'Enter phone'.tr;
                  //       }

                  //       RegExp regex = RegExp(r'^[0-9- ]+$');
                  //       if (!regex.hasMatch(value)) {
                  //         return 'Phone number should only contain digits';
                  //       }
                  //       return null;
                  //     },
                  //     hintText: 'Phone'.tr,
                  //   ),
                  // ),
                  EditCustomTextField(
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'pleaseenteraddress'.tr;
                      }
                      return null;
                    },
                    labelText: 'emailAddress'.tr,
                    hintText: 'emailAddress'.tr,
                    controller: AuthController.i.emailcont,
                    enabled: false,
                    readonly: true,
                  ),
                  EditProfileCustomTextFieldWeight(
                    keyboardTypenew: TextInputType.number,
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'pleaseenterweight'.tr;
                      }
                      return null;
                    },
                    labelText: 'weight'.tr,
                    hintText: 'weight'.tr,
                    controller: AuthController.i.weightcont,
                  ),
                  EditProfileCustomTextFieldHeight(
                    keyboardTypenew: TextInputType.number,
                    validator: (p0) {
                      if (p0!.isEmpty) {
                        return 'pleaseenterheight'.tr;
                      }
                      return null;
                    },
                    labelText: 'height'.tr,
                    hintText: 'height'.tr,
                    controller: AuthController.i.heightcont,
                  ),
                  EditCustomTextField(
                    suffixIcon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: ColorManager.kblackColor,
                    ),
                    prefixIcon: AuthController.i.gendercont.text == "Male"
                        ? const Icon(
                            Icons.male_rounded,
                            color: ColorManager.kGreyColor,
                          )
                        : const Icon(
                            Icons.female_rounded,
                            color: ColorManager.kGreyColor,
                          ),
                    onTap: () async {},
                    enabled: false,
                    readonly: true,
                    labelText: 'gender'.tr,
                    hintText: 'gender'.tr,
                    controller: AuthController.i.gendercont,
                  ),
                  EditCustomTextField(
                    keyboardTypenew: TextInputType.number,
                    // validator: (p0) {
                    //   if (p0!.isEmpty) {
                    //     return 'Please Enter Age'.tr;
                    //   }
                    //   return null;
                    // },
                    labelText: 'age'.tr,
                    enabled: true,
                    hintText: 'age'.tr,
                    controller: AuthController.i.agecont,
                    readonly: true,
                  ),
                  GetBuilder<AuthController>(builder: (cont) {
                    return EditProfileCustomTextField(
                      suffixIcon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: ColorManager.kblackColor,
                      ),
                      onTap: () async {
                        AuthController.i.selectedDiseases.clear();
                        AuthController.i.preselectedIds = [];
                        AuthController.i.preselectedIds =
                            AuthController.i.diseasesid!.split(", ");

                        AuthController.i.selectedDiseases.isEmpty;
                        print(
                            "${AuthController.i.selectedDiseases.map((d) => d.name).toList()}");
                        await searchabledropdowndisease(
                            context, StepsController.i.diseaseList);

                        // StepsController.i.getDiseases();

                        AuthController.i.update();
                      },
                      readonly: true,
                      labelText: 'disease'.tr,
                      hintText: cont.selectedDiseases.isEmpty
                          ? 'selectdiseases'.tr
                          : cont.selectedDiseases
                              .map((d) => d.name)
                              .toList()
                              .join(', '),
                    );
                  }),
                  EditProfileCustomTextField(
                    suffixIcon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: ColorManager.kblackColor,
                    ),
                    onTap: () async {
                      PhysicalActivityLevels generic =
                          await searchabledropdownlevel(
                              context, StepsController.i.activitylevellist);
                      StepsController.i.getactivitiylevel();
                      StepsController.i.selectedActivityLevel = null;
                      StepsController.i.updateActivityLevel(generic);
                      if (generic.id == null) {
                        StepsController.i.selectedActivityLevel = generic;
                        StepsController.i.selectedActivityLevel =
                            (generic.id == null)
                                ? null
                                : StepsController.i.selectedActivityLevel;
                      }
                      AuthController.i.activitylevelcont.text =
                          StepsController.i.selectedActivityLevel?.name ?? '';
                      AuthController.i.selectedActivityLevelId =
                          StepsController.i.selectedActivityLevel?.id ?? '';
                    },
                    readonly: true,
                    labelText: 'activitylevel'.tr,
                    hintText: StepsController.i.selectedActivityLevel?.id ==
                                "" ||
                            StepsController.i.selectedActivityLevel?.id == null
                        ? 'activitylevel'.tr
                        : StepsController.i.selectedActivityLevel?.name
                            .toString(),
                    controller: AuthController.i.activitylevelcont,
                  ),

                  Center(
                    child: CustomButton(
                      buttonheight: Get.height * 0.07,
                      backgroundColor: ColorManager.kPrimaryColor,
                      buttonwidth: Get.width * 0.7,
                      onPress: () async {
                        if (_formKey.currentState!.validate()) {
                          _toggleLoading();
                          String str = "";
                          if (_imageFile != null) {
                            str = await AuthRepository()
                                .uploadPicture(_imageFile!);
                          }
                          AuthController.i.toggleHeightUnit();
                          AuthController.i.toggleWeightUnit();
                          await AuthRepository().updateprofile();

                          _toggleLoading();
                        }
                      },
                      radius: 15,
                      mywidget: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "update".tr,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: ColorManager.kblackColor,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  XFile? _imageFile;
  late File _heicImage;
  final ImagePicker _picker = ImagePicker();
  PickedFile? pickedFile;
  void TakePhoto(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _heicImage = File(pickedFile.path);
        _imageFile = pickedFile;
      });
    } else {
      // Handle the case when the user cancels the image selection
      print("No image selected");
    }
  }

  Widget ImageProfile() {
    ImageProvider _getImageProvider() {
      if (_imageFile != null) {
        return FileImage(File(_imageFile!.path));
      } else if (AuthController.i.user?.picturePath != null) {
        return NetworkImage(baseURL + AuthController.i.user!.picturePath!);
      } else {
        return AssetImage(AppImages.avatar);
      }
    }
    // ImageProvider _getImageProvider() {
    //   if (_imageFile != null) {
    //     return FileImage(File(_imageFile!.path));
    //   } else if (AuthController.i.user?.picturePath != null) {
    //     return FileImage(File(AuthController.i.user?.picturePath!));
    //   } else {
    //     return AssetImage(AppImages.yoga);
    //   }
    // }

    return Stack(
      children: <Widget>[
        CircleAvatar(radius: 50.0, backgroundImage: _getImageProvider()),
        Positioned(
          bottom: 5.0,
          right: 2.0,
          left: 75,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (builder) => bottomsheet(),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              color: Colors.orange,
              size: 28.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "choosephoto".tr,
            style: GoogleFonts.raleway(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorManager.kPrimaryColor,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton.icon(
                icon:
                    const Icon(Icons.camera, color: ColorManager.kPrimaryColor),
                onPressed: () {
                  TakePhoto(ImageSource.camera);
                  Navigator.pop(context);
                },
                label: Text(
                  "camera".tr,
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.kPrimaryColor,
                  ),
                ),
              ),
              TextButton.icon(
                icon:
                    const Icon(Icons.image, color: ColorManager.kPrimaryColor),
                onPressed: () {
                  TakePhoto(ImageSource.gallery);
                  Navigator.pop(context);
                },
                label: Text(
                  "gallery".tr,
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.kPrimaryColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
