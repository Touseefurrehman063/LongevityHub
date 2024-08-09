import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/gym_membership/custom_appointments_notes.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/schedule_screens/select_expert_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

import '../../components/custom_button.dart';

class ExpertAppointmentScreen extends StatefulWidget {
  const ExpertAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<ExpertAppointmentScreen> createState() =>
      _ExpertAppointmentScreenState();
}

class _ExpertAppointmentScreenState extends State<ExpertAppointmentScreen> {
  late DateTime _selectedDate;
  int selectedIndex = 1;
  final FocusNode _focusNode1 = FocusNode();
  TextEditingController notesCont = TextEditingController();
  final List<String> headings = [
    "10:00",
    "14:00",
    "18:00",
    "22:00",
    "02:00",
    "06:00",
    "10:00",
    "14:00",
  ];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Get.offAll(() => const SelectExpertScreen());
            },
            child: Image.asset(
              AppImages.backArrow,
              scale: 10,
              color: ColorManager.kblackColor,
            ),
          ),
          title: Text(
            "bookAppointment".tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: ColorManager.kblackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.04,
              vertical: Get.height * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Get.height * 0.01),
                Center(
                  child: Image.asset(
                    AppImages.trainerImage,
                    scale: 2,
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Richard Will",
                      style: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: Get.width * 0.02),
                    Image.asset(
                      AppImages.onlineIcon,
                      scale: 10,
                      color: Colors.green,
                    ),
                  ],
                ),
                Text(
                  "High Intensity Training",
                  style: GoogleFonts.poppins(
                    color: ColorManager.kblackColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                Container(
                  height: Get.height * 0.03,
                  width: Get.width * 0.14,
                  decoration: BoxDecoration(
                    color: ColorManager.kPrimaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.onlineVector,
                        scale: 4,
                      ),
                      SizedBox(width: Get.width * 0.015),
                      Text(
                        "online".tr,
                        style: GoogleFonts.poppins(
                          color: ColorManager.kblackColor,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.025),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "selectDate".tr,
                        style: GoogleFonts.poppins(
                          color: ColorManager.kblackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                EasyInfiniteDateTimeLine(
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  focusDate: _selectedDate,
                  onDateChange: (selectedDate) {
                    setState(() {
                      _selectedDate = selectedDate;
                    });
                  },
                  showTimelineHeader: false,
                  dayProps: EasyDayProps(
                    height: Get.height * 0.09,
                    width: Get.width * 0.14,
                    dayStructure: DayStructure.monthDayNumDayStr,
                    activeDayStyle: DayStyle(
                      dayNumStyle: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      dayStrStyle: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                      monthStrStyle: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: ColorManager.kPrimaryColor,
                      ),
                    ),
                    inactiveDayStyle: DayStyle(
                      dayNumStyle: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      dayStrStyle: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                      monthStrStyle: GoogleFonts.poppins(
                        color: ColorManager.kblackColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        color: ColorManager.kWhiteColor,
                        border: Border.all(
                          color: const Color.fromARGB(255, 238, 238, 238),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.025),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "selectTime".tr,
                        style: GoogleFonts.poppins(
                          color: ColorManager.kblackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * .02),
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: headings.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: Get.width * 0.02,
                      mainAxisSpacing: Get.height * 0.005,
                      childAspectRatio: 2.5,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: HighlightDefinition(
                          time: headings[index],
                          isSelected: selectedIndex == index,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.025),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "appointmentNotes".tr,
                        style: GoogleFonts.poppins(
                          color: ColorManager.kblackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                CustomNotesField(
                  controller: notesCont,
                  hintText: "",
                  focusNode: _focusNode1,
                  maxLines: 5,
                ),
                SizedBox(height: Get.height * 0.02),
                Center(
                  child: CustomButton(
                    buttonheight: Get.height * 0.07,
                    backgroundColor: ColorManager.kPrimaryColor,
                    buttonwidth: Get.width * 0.85,
                    onPress: () async {
                      // Get.to(() => const GymExerciseScreen());
                    },
                    mywidget:
                        // AuthController
                        //             .i.isLoading ==
                        //         true
                        //     ? const CircularProgressIndicator(
                        //         color: Colors.white,
                        //       )
                        //     :
                        Text(
                      "bookNow".tr,
                      style: GoogleFonts.poppins(
                          color: ColorManager.kblackColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w700),
                    ),
                    radius: 33,
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

class HighlightDefinition extends StatelessWidget {
  final String time;
  final bool isSelected;

  const HighlightDefinition({
    required this.time,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected ? ColorManager.kPrimaryColor : Colors.transparent,
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : const Color.fromARGB(255, 236, 235, 235),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  time,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
