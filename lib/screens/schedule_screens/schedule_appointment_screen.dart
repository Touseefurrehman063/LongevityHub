import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/components/custom_time_slot/custom_schedule_timeSlot.dart';
import 'package:longevity_hub/components/schedule_card/schedule_card.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/schedule_screens/schedule_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleAppointmentScreen extends StatefulWidget {
  const ScheduleAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleAppointmentScreen> createState() =>
      _ScheduleAppointmentScreenState();
}

class _ScheduleAppointmentScreenState extends State<ScheduleAppointmentScreen> {
  DateTime _selectedDay = DateTime.now();
  int _selectedTimeSlotIndex = -1;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Appointment",
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
        child: Stack(
          children: [
            // Background Image
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
                    height: Get.height * 0.025,
                  ),
                  Column(
                    children: [
                      ScheduleCard(
                        centerText: "Jason Ronald",
                        centerText2: "High Intensity Training",
                        centerText3: "5 years experience",
                        bkColor: const Color(0xFF2C2C2E),
                        buttontext: "4.6",
                        trailingImage: AppImages.person,
                        statustext: "Booked",
                        dateTimeText:
                            "Feb 20, 2022 | \n                  16:00",
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      LayoutBuilder(builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Container(
                          // width: Get.width,
                          // height: Get.height * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color(0xff2c2c2e),
                          ),
                          child: Column(
                            children: [
                              TableCalendar(
                                focusedDay: _selectedDay,
                                selectedDayPredicate: (day) =>
                                    isSameDay(day, _selectedDay),
                                firstDay: DateTime(2020),
                                lastDay: DateTime(2025),
                                daysOfWeekHeight: 40,
                                daysOfWeekStyle: const DaysOfWeekStyle(
                                  weekdayStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                weekendDays: const [],
                                calendarFormat: CalendarFormat.month,
                                onDaySelected: (selectedDay, focusedDay) {
                                  setState(() {
                                    _selectedDay = selectedDay;
                                  });
                                },
                                pageJumpingEnabled: true,
                                availableCalendarFormats: const {
                                  CalendarFormat.month: 'Month'
                                },
                                headerStyle: HeaderStyle(
                                  formatButtonVisible: false,
                                  titleCentered: true,
                                  leftChevronIcon: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(255, 66, 66, 66),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.chevron_left,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  rightChevronIcon: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(255, 66, 66, 66),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.chevron_right,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  titleTextStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                calendarStyle: CalendarStyle(
                                  isTodayHighlighted: true,
                                  outsideDaysVisible: true,
                                  weekendTextStyle: const TextStyle(
                                    color: ColorManager.kWhiteColor,
                                  ),
                                  outsideTextStyle: const TextStyle(
                                    color: Color.fromARGB(255, 94, 93, 93),
                                  ),
                                  rangeEndTextStyle:
                                      const TextStyle(color: Colors.white),
                                  rangeHighlightColor: Colors.white,
                                  weekNumberTextStyle:
                                      const TextStyle(color: Colors.white),
                                  todayTextStyle:
                                      const TextStyle(color: Colors.white),
                                  defaultTextStyle: const TextStyle(
                                      color: ColorManager.kWhiteColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                  selectedTextStyle: const TextStyle(
                                      color: ColorManager.kblackColor),
                                  selectedDecoration: const BoxDecoration(
                                      color: ColorManager.kPrimaryColor,
                                      shape: BoxShape.circle),
                                  todayDecoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      // color: ColorManager.kPrimaryColor,
                                      shape: BoxShape.circle),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.84,
                                child: const Divider(
                                  color: Color.fromARGB(255, 173, 172, 172),
                                  thickness: 1,
                                  height: 0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Time",
                                      style: GoogleFonts.poppins(
                                          color: ColorManager.kWhiteColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    24 * 2,
                                    (index) {
                                      int hour = index ~/ 2;
                                      int minute = (index % 2) * 30;

                                      String formattedHour = hour == 0
                                          ? '12'
                                          : (hour % 12).toString();
                                      String formattedMinute =
                                          minute == 0 ? '00' : '30';
                                      String period = hour < 12 ? 'AM' : 'PM';

                                      String time =
                                          '$formattedHour:$formattedMinute  $period';

                                      return Padding(
                                        padding: EdgeInsets.only(
                                            right: Get.width * 0.06),
                                        child: CustomTimeSlot(
                                          index:
                                              index, // Pass the index to identify each time slot
                                          buttonheight: Get.height * 0.05,
                                          buttonwidth: Get.width * 0.25,
                                          backgroundColor: Colors.transparent,
                                          onSelect: (int selectedIndex) {
                                            setState(() {
                                              // Set the selected index in the state
                                              _selectedTimeSlotIndex =
                                                  selectedIndex;
                                            });
                                          },
                                          isSelected: _selectedTimeSlotIndex ==
                                              index, // Check if this slot is selected
                                          mywidget: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                time,
                                                style: GoogleFonts.poppins(
                                                  color:
                                                      _selectedTimeSlotIndex ==
                                                              index
                                                          ? ColorManager
                                                              .kWhiteColor
                                                          : Colors.grey,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          radius: 22,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              )
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  Center(
                    child: CustomButton(
                      buttonheight: Get.height * 0.07,
                      backgroundColor: ColorManager.kPrimaryColor,
                      buttonwidth: Get.width * 0.75,
                      onPress: () {
                        Get.offAll(() => const ScheduleScreen());
                      },
                      mywidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Book Appointment",
                            style: GoogleFonts.poppins(
                                color: ColorManager.kblackColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      radius: 10,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
