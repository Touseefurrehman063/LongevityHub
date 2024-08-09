import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:longevity_hub/components/Login/authTextField.dart';
import 'package:longevity_hub/components/custom_button.dart';
import 'package:longevity_hub/helpers/color_manager.dart';
import 'package:longevity_hub/screens/longevity_store_screens/pay_now_screen.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  String _selectedAddress = 'Home';
  List<Map<String, String>> addresses = [
    {
      'title': 'Home',
      'address': '57, Ward Street, 95700, Harrah, United Arab Emirates',
      'value': 'Home'
    },
    {
      'title': 'Work',
      'address': '57, Ward Street, 95700, Harrah, United Arab Emirates',
      'value': 'Work'
    },
    {
      'title': 'Other',
      'address': '57, Ward Street, 95700, Harrah, United Arab Emirates',
      'value': 'Other'
    },
  ];

  void _addNewAddress(String title, String address, String value) {
    addresses.add({
      'title': title,
      'address': address,
      'value': value,
    });
    setState(() {});
  }

  void _editAddress(int index, String title, String address) {
    addresses[index]['title'] = title;
    addresses[index]['address'] = address;
    addresses[index]['value'] = title.toLowerCase();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "shippingaddress".tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: ColorManager.kblackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppImages.newBackground,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.02,
              horizontal: Get.width * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      AppImages.addressIcon,
                      scale: 12,
                    ),
                    Image.asset(
                      AppImages.summeryIcon,
                      scale: 12,
                    ),
                    Image.asset(
                      AppImages.paymentIcon,
                      scale: 12,
                    )
                  ],
                ),
                SizedBox(height: Get.height * 0.02),
                Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "address".tr,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.kblackColor,
                        ),
                      ),
                      Text(
                        "Summary".tr,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.kblackColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: Get.width * .03),
                        child: Text(
                          "payment".tr,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorManager.kblackColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
                Expanded(
                  child: ListView.builder(
                    itemCount: addresses.length + 1,
                    itemBuilder: (context, index) {
                      if (index < addresses.length) {
                        return _buildAddressContainer(
                          addresses[index]['title']!,
                          addresses[index]['address']!,
                          addresses[index]['value']!,
                          index,
                        );
                      } else {
                        return SizedBox(
                          height: Get.height * 0.07,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.06),
                              child: CustomButton(
                                backgroundColor: ColorManager.kPrimaryColor,
                                onPress: () => _showAddAddressDialog(),
                                mywidget: Text(
                                  "addnewaddress".tr,
                                  style: GoogleFonts.poppins(
                                    color: ColorManager.kblackColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                radius: 10,
                                buttonheight: Get.height * 0.086,
                                buttonwidth: Get.width * 0.75,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: Get.height * 0.05),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: Get.width * 0.125,
            child: CustomButton(
              buttonheight: Get.height * 0.06,
              backgroundColor: ColorManager.kPrimaryColor,
              buttonwidth: Get.width * 0.75,
              onPress: () async {
                Get.to(() => const PayNowScreen());
              },
              mywidget: Text(
                "next".tr,
                style: GoogleFonts.poppins(
                  color: ColorManager.kblackColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              radius: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressContainer(
      String title, String address, String value, int index) {
    return InkWell(
      onTap: (() {
        setState(() {
          _selectedAddress = value;
        });
      }),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color.fromARGB(255, 228, 228, 228),
            width: 0.5,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Radio<String>(
                      value: value,
                      groupValue: _selectedAddress,
                      activeColor: ColorManager.kPrimaryColor,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedAddress = newValue!;
                        });
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.kblackColor,
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.6,
                          child: Text(
                            address,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: ColorManager.kblackColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: Get.width * 0.08,
                    ),
                    PopupMenuButton<String>(
                      child: Image.asset(
                        AppImages.verticalDots,
                        scale: 20,
                      ),
                      onSelected: (String value) {
                        if (value == 'Edit Address') {
                          _showAddAddressDialog(
                            index: index,
                            initialTitle: title,
                            initialAddress: address,
                          );
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          const PopupMenuItem<String>(
                            value: 'Edit Address',
                            child: Text(
                              'Edit Address',
                              style: TextStyle(color: ColorManager.kblackColor),
                            ),
                          ),
                        ];
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddAddressDialog(
      {int? index, String? initialTitle, String? initialAddress}) {
    TextEditingController titleController =
        TextEditingController(text: initialTitle);
    TextEditingController addressController =
        TextEditingController(text: initialAddress);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            index == null ? "Add New Address" : "Edit Address",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ColorManager.kPrimaryColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AuthTextField(
                controller: titleController,
                hintText: "Title",
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              AuthTextField(
                controller: addressController,
                hintText: "Address",
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.kPrimaryColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (index == null) {
                  _addNewAddress(
                    titleController.text,
                    addressController.text,
                    titleController.text.toLowerCase(),
                  );
                } else {
                  _editAddress(
                    index,
                    titleController.text,
                    addressController.text,
                  );
                }
                Navigator.of(context).pop();
              },
              child: Text(
                index == null ? 'Add' : 'Save',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.kPrimaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
