import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:longevity_hub/components/health_insights/custom_calendar.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/dashboard_screens/menu_drawer.dart';
import 'package:longevity_hub/screens/schedule_screens/select_expert_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:dotted_line/dotted_line.dart';

class ScheduleScreen extends StatefulWidget {
  final bool navigateToMenuScreen;
  const ScheduleScreen({Key? key, this.navigateToMenuScreen = false})
      : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime selectedDate = DateTime.now();

  void _openCustomCalendar(BuildContext context) async {
    DateTime? pickedDate = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return CustomCalendar(
          selectedDate: selectedDate,
          onDateSelected: (DateTime date) {
            Navigator.of(context).pop(date);
          },
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: widget.navigateToMenuScreen
              ? const SizedBox.shrink()
              : InkWell(
                  onTap: () {
                    Get.to(() => const DrawerScreen());
                  },
                  child: Image.asset(
                    AppImages.backArrow,
                    scale: 10,
                    color: ColorManager.kblackColor,
                  ),
                ),
          title: Text(
            "myAppointments".tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: ColorManager.kblackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: Get.width * 0.04),
              child: InkWell(
                onTap: () {
                  Get.to(() => const SelectExpertScreen());
                },
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.appticon,
                      scale: 12,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                AppImages.background,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('MMM dd, yyyy').format(selectedDate),
                        style: GoogleFonts.poppins(
                          color: ColorManager.kblackColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.01,
                      ),
                      InkWell(
                        onTap: () => _openCustomCalendar(context),
                        child: Image.asset(
                          AppImages.calendarIcon,
                          scale: 7,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: const EdgeInsets.all(0),
                    labelColor: ColorManager.kPrimaryColor,
                    unselectedLabelColor: Colors.black.withOpacity(0.5),
                    indicatorColor: ColorManager.kPrimaryColor,
                    labelStyle: GoogleFonts.inter(
                        fontSize: 14, fontWeight: FontWeight.w600),
                    tabs: [
                      Tab(text: 'upcoming'.tr),
                      Tab(text: 'cOmpleted'.tr),
                      Tab(text: 'pending'.tr),
                      Tab(text: 'cancelled'.tr),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildTabContent('upcoming'.tr),
                        _buildTabContent('cOmpleted'.tr),
                        _buildTabContent('pending'.tr),
                        _buildTabContent('cancelled'.tr),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(String tabName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ListView.builder(
        itemCount: 10, // Set the number of items
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Mar 30,2024 | 08:00 AM",
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${"bookingid".tr} -OID-00012345",
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "booked".tr,
                            style: GoogleFonts.poppins(
                                color: ColorManager.kPrimaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorManager.kLightBlue.withOpacity(0.4),
                        border: Border.all(color: Colors.lightBlue),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0), // Added padding
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "onlineConsultation".tr,
                              style: GoogleFonts.roboto(
                                  color: ColorManager.kPrimaryColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Richard Will',
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Highly Intensity training',
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: RichText(
                                    textAlign: TextAlign.right,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Paid\n',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'AED 100.00',
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const DottedLine(
                              direction: Axis.horizontal,
                              lineLength: double.infinity,
                              lineThickness: 1.2,
                              dashLength: 4.0,
                              dashColor: Colors.black,
                              dashGapLength: 4.0,
                              dashRadius: 0.0,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Mar 30, 2024 | 10:00 AM",
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "reschedule".tr,
                                      style: GoogleFonts.inter(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    )),
                                ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              ColorManager.kRedColor),
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      "cancel".tr,
                                      style: GoogleFonts.inter(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
