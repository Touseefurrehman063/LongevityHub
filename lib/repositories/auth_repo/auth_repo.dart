// ignore_for_file: unused_local_variable, non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:longevity_hub/components/Profile/custom_popup.dart';
import 'package:longevity_hub/data/controller/auth_controller.dart';
import 'package:longevity_hub/data/localDB/local_db.dart';
import 'package:longevity_hub/models/forget_email_verification_model/change_pass_model.dart';
import 'package:longevity_hub/models/forget_email_verification_model/forget_email_verification_model.dart';
import 'package:longevity_hub/models/forget_email_verification_model/otp_verification_model.dart';
import 'package:longevity_hub/models/forget_email_verification_model/reset_forget_pass_model.dart';
import 'package:longevity_hub/models/user_model/delete_user_model.dart';
import 'package:longevity_hub/models/user_model/logout_user_model.dart';
import 'package:longevity_hub/models/user_model/user_model.dart';
import 'package:longevity_hub/repositories/login_repository/login_repo.dart';
import 'package:longevity_hub/screens/auth_screens/create_newpassword.dart';
import 'package:longevity_hub/screens/auth_screens/login.dart';
import 'package:longevity_hub/screens/auth_screens/old_pass_success.dart';
import 'package:longevity_hub/screens/auth_screens/otp_screen.dart';
import 'package:longevity_hub/screens/auth_screens/password_success.dart';
import 'package:longevity_hub/screens/dashboard_screens/menu_drawer.dart';
import 'package:longevity_hub/screens/profile_screen/profile_screens.dart';
import 'package:longevity_hub/screens/steps_screen/gender_screen.dart';
import 'package:longevity_hub/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AuthRepository {
  Future<bool> getProfileDetail() async {
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    var body = {};

    try {
      var response = await http.post(Uri.parse(AppConstants.getprofiledetail),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        UserDataModel localUser = await LocalDb().getProfileData();
        var responseData = jsonDecode(response.body);
        AuthController.i.user?.cNICNumber =
            responseData['CNICNumber'] ?? AuthController.i.user?.cNICNumber;
        AuthController.i.user?.mRNo =
            responseData['MRNo'] ?? AuthController.i.user?.mRNo;
        AuthController.i.user?.identityType =
            responseData['IdentityType'] ?? AuthController.i.user?.identityType;
        AuthController.i.user?.name =
            responseData['Name'] ?? AuthController.i.user?.name;
        AuthController.i.user?.identityTypeName =
            responseData['IdentityTypeName'] ??
                AuthController.i.user?.identityTypeName;
        AuthController.i.user?.patientTypeName =
            responseData['PatientTypeName'] ??
                AuthController.i.user?.patientTypeName;
        AuthController.i.user?.patientTypeId = responseData['PatientTypeId'] ??
            AuthController.i.user?.patientTypeId;
        AuthController.i.user?.personTitleId = responseData['PersonTitleId'] ??
            AuthController.i.user?.personTitleId;
        AuthController.i.user?.title =
            responseData['Title'] ?? AuthController.i.user?.title;
        AuthController.i.user?.prefix =
            responseData['Prefix'] ?? AuthController.i.user?.prefix;
        AuthController.i.user?.firstName =
            responseData['FirstName'] ?? AuthController.i.user?.firstName;
        AuthController.i.user?.middleName =
            responseData['MiddleName'] ?? AuthController.i.user?.middleName;
        AuthController.i.user?.id =
            responseData['Id'] ?? AuthController.i.user?.id;
        AuthController.i.user?.lastName =
            responseData['LastName'] ?? AuthController.i.user?.lastName;
        AuthController.i.user?.gender =
            responseData['Gender'] ?? AuthController.i.user?.gender;
        AuthController.i.user?.genderId =
            responseData['GenderId'] ?? AuthController.i.user?.genderId;
        AuthController.i.user?.relationshipTypeId =
            responseData['RelationshipTypeId'] ??
                AuthController.i.user?.relationshipTypeId;
        AuthController.i.user?.relationshipTypeName =
            responseData['RelationshipTypeName'] ??
                AuthController.i.user?.relationshipTypeName;
        AuthController.i.user?.guardianName =
            responseData['GuardianName'] ?? AuthController.i.user?.guardianName;
        AuthController.i.user?.maritalStatusId =
            responseData['MaritalStatusId'] ??
                AuthController.i.user?.maritalStatusId;
        AuthController.i.user?.maritalStatus = responseData['MaritalStatus'] ??
            AuthController.i.user?.maritalStatus;
        AuthController.i.user?.dateOfBirth =
            responseData['DateOfBirth'] ?? AuthController.i.user?.dateOfBirth;
        AuthController.i.user?.referenceId =
            responseData['ReferenceId'] ?? AuthController.i.user?.referenceId;
        AuthController.i.user?.picturePath =
            responseData['PicturePath'] ?? AuthController.i.user?.picturePath;
        AuthController.i.user?.country =
            responseData['Country'] ?? AuthController.i.user?.country;

        AuthController.i.user?.countryId =
            responseData['CountryId'] ?? AuthController.i.user?.countryId;
        AuthController.i.user?.stateOrProvince =
            responseData['StateOrProvince'] ??
                AuthController.i.user?.stateOrProvince;
        AuthController.i.user?.city =
            responseData['City'] ?? AuthController.i.user?.city;
        AuthController.i.user?.cityId =
            responseData['CityId'] ?? AuthController.i.user?.cityId;
        AuthController.i.user?.address =
            responseData['Address'] ?? AuthController.i.user?.address;
        AuthController.i.user?.cellNumber =
            responseData['CellNumber'] ?? AuthController.i.user?.cellNumber;
        AuthController.i.user?.telephoneNumber =
            responseData['TelephoneNumber'] ??
                AuthController.i.user?.telephoneNumber;
        AuthController.i.user?.email =
            responseData['Email'] ?? AuthController.i.user?.email;
        AuthController.i.user?.occupationId =
            responseData['OccupationId'] ?? AuthController.i.user?.occupationId;
        AuthController.i.user?.occupation =
            responseData['Occupation'] ?? AuthController.i.user?.occupation;
        AuthController.i.user?.nOKFirstName =
            responseData['NOKFirstName'] ?? AuthController.i.user?.nOKFirstName;
        AuthController.i.user?.nOKLastName =
            responseData['NOKLastName'] ?? AuthController.i.user?.nOKLastName;
        AuthController.i.user?.nOKRelation =
            responseData['NOKRelation'] ?? AuthController.i.user?.nOKRelation;
        AuthController.i.user?.nOKRelationId = responseData['NOKRelationId'] ??
            AuthController.i.user?.nOKRelationId;
        AuthController.i.user?.nOKCNICNumber = responseData['NOKCNICNumber'] ??
            AuthController.i.user?.nOKCNICNumber;
        AuthController.i.user?.nOKCellNumber = responseData['NOKCellNumber'] ??
            AuthController.i.user?.nOKCellNumber;
        AuthController.i.user?.bloodGroup =
            responseData['BloodGroup'] ?? AuthController.i.user?.bloodGroup;
        AuthController.i.user?.bloodGroupId =
            responseData['BloodGroupId'] ?? AuthController.i.user?.bloodGroupId;
        AuthController.i.user?.age =
            responseData['Age'] ?? AuthController.i.user?.age;
        AuthController.i.user?.latitude =
            responseData['Latitude'] ?? AuthController.i.user?.latitude;
        AuthController.i.user?.longitude =
            responseData['Longitude'] ?? AuthController.i.user?.longitude;
        AuthController.i.user?.errorMessage =
            responseData['ErrorMessage'] ?? AuthController.i.user?.errorMessage;
        AuthController.i.user?.height =
            responseData['Height'] ?? AuthController.i.user?.height;
        AuthController.i.user?.weight =
            responseData['Weight'] ?? AuthController.i.user?.longitude;
        AuthController.i.user?.heightMeasurementCategoryId =
            responseData['HeightMeasurementCategoryId'] ??
                AuthController.i.user?.longitude;
        AuthController.i.user?.heightMeasurementCategoryName =
            responseData['HeightMeasurementCategoryName'] ??
                AuthController.i.user?.heightMeasurementCategoryName;
        AuthController.i.user?.weightMeasurementCategoryId =
            responseData['WeightMeasurementCategoryId'] ??
                AuthController.i.user?.weightMeasurementCategoryId;
        AuthController.i.user?.weightMeasurementCategoryName =
            responseData['WeightMeasurementCategoryName'] ??
                AuthController.i.user?.weightMeasurementCategoryName;
        AuthController.i.user?.physicalActivityLevelId =
            responseData['PhysicalActivityLevelId'] ??
                AuthController.i.user?.physicalActivityLevelId;
        AuthController.i.user?.physicalActivityLevelName =
            responseData['PhysicalActivityLevelName'] ??
                AuthController.i.user?.physicalActivityLevelName;
        AuthController.i.user?.physicalActivitiesListName =
            responseData['PhysicalActivitiesListName'] ??
                AuthController.i.user?.physicalActivitiesListName;
        AuthController.i.user?.physicalActivitiesListIds =
            responseData['PhysicalActivitiesListIds'] ??
                AuthController.i.user?.physicalActivitiesListIds;
        AuthController.i.user?.diseasesListName =
            responseData['DiseasesListName'] ??
                AuthController.i.user?.diseasesListName;
        AuthController.i.user?.diseasesListIds =
            responseData['DiseasesListIds'] ??
                AuthController.i.user?.diseasesListIds;
        AuthController.i.user?.branchId =
            responseData['BranchId'] ?? AuthController.i.user?.branchId;
        AuthController.i.user?.accessToken =
            responseData['AccessToken'] ?? AuthController.i.user?.accessToken;
        var status = responseData['Status'];

        log(' get Updated Response ${responseData.toString()}');
        // print(responseData);
        // print('API Response: $responseData');
        if (status == 1) {
          // return status;
        } else {
          return true;
        }
      }
    } catch (e) {
      // ToastManager.showToast('someerrorOccured'.tr,
      //     bgColor: ColorManager.kRedColor);
      return false;
    }
    return false;
  }

  profiledetail() async {
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.get(
        Uri.parse(AppConstants.getprofiledetail),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        UserDataModel userResponseData = UserDataModel.fromJson(result);
        if (userResponseData.status == 1) {
          AuthController.i.updateisLoading(false);
          AuthController.i.updateUserData(userResponseData);
          log(userResponseData.toJson().toString());
          return userResponseData;
        } else {
          // Utils.toastMessage(
          //     userResponseData.status.toString(), Colors.grey, Colors.white);
          AuthController.i.updateisLoading(false);
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
      AuthController.i.updateisLoading(false);
    }
  }

  Future<String> uploadPicture(XFile file) async {
    String? accessToken = await LocalDb().getAccessToken();

    if (accessToken == null || accessToken.isEmpty) {
      log('Access token is null or empty');
      return '';
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    var url = '$baseURL/api/Longivity/AttachFile';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('image', file.path));

    log('Sending request to $url with headers $headers');

    final res = await request.send();

    if (res.statusCode == 200) {
      dynamic data = jsonDecode(await res.stream.bytesToString());
      String r = data["Path"];
      AuthController.i.picturePath = r;
      log('Upload success: $r');
      return r;
    } else if (res.statusCode == 401) {
      log('Upload failed with status 401: Unauthorized');
      // Check token validity, scope, etc.
    } else {
      log('Upload failed with status ${res.statusCode}');
    }

    return '';
  }

  // void log(String message) {
  //   var logger = log();
  //   logger.i(message); // Adjust log level as needed
  // }

  final api = LoginRepository();
  updateprofile() async {
    String? Manufacturer = "";
    String? Model = "";
    String? AppVersion = "";
    String? DeviceVersionIos;
    String? DeviceVersion;
    String? deviceToken = await LocalDb().getDeviceToken();

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      Model = androidInfo.model;
      Manufacturer = androidInfo.manufacturer;
      AppVersion = androidInfo.version.release;
      DeviceVersion = androidInfo.version.baseOS;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      Model = iosInfo.model;
      Manufacturer = iosInfo.identifierForVendor;
      AppVersion = iosInfo.systemVersion;
      DeviceVersionIos = iosInfo.systemVersion;
    }
    String? accessToken = await LocalDb().getAccessToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    // var edit = EditProfileController.i;
    String? picturePath;
    AuthController.i.picturePath != null
        ? picturePath = AuthController.i.picturePath
        : picturePath = AuthController.i.user?.picturePath;
    var body = {
      "DeviceToken": deviceToken,
      "Manufacturer": Manufacturer,
      "Model": Model,
      "AppVersion": AppVersion,
      "DeviceVersion": Platform.isAndroid ? DeviceVersion : DeviceVersionIos,
      "FirstName": AuthController.i.fullnamecont.text,
      "CellNumber": AuthController.i.phonecont.text,
      "Email": AuthController.i.emailcont.text,
      "CellNumberCountryCode": AuthController.i.countryCode,
      "GenderId": AuthController.i.user?.genderId,
      "DateOfBirth": AuthController.i.user?.dateOfBirth,
      "Height": AuthController.i.heightcont.text,
      "HeightMeasurementCategoryId":
          AuthController.i.user?.heightMeasurementCategoryId,
      "Weight": AuthController.i.weightcont.text,
      "WeightMeasurementCategoryId":
          AuthController.i.user?.weightMeasurementCategoryId,
      "PhysicalActivityLevelId": AuthController.i.selectedActivityLevelId,
      "InterestedActivities": AuthController.i.user?.physicalActivitiesListName,
      "Diseases": AuthController.i.selectedDiseaseIds.toList(),
      "PicturePath": picturePath,

      // "FileAttachment": file,
    };
    log(body.toString());

    try {
      var response = await http.post(Uri.parse(AppConstants.updateprofile),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        // var accesstoken = responseData['AccessToken'];
        var errormessage = responseData['ErrorMessage'];

        log('API Response: $responseData');
        if (status == 2) {
          var accesstoken = responseData['AccessToken'];
          profiledetail();
          Get.to(() => const Userprofile());

          LocalDb().saveAccessToken(accesstoken);

          return true;
        } else {
          CustomPopup.showError(errormessage.toString());
          return false;
        }
      }
    } catch (e) {
      // Utils.toastMessage(e.toString(), Colors.grey, Colors.white);

      return false;
    }
    return false;
  }

  forgetemailverification() async {
    AuthController.i.updateisforgetLoading(true);
    var body = {
      "Email": AuthController.i.forgetemailController.text.trim(),
    };

    var headers = {
      'Content-Type': 'application/json',
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.forgetemailverify),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        AuthController.i.updateisforgetLoading(true);
        var result = jsonDecode(response.body);
        ForgetEmailVerificationResponse responseData =
            ForgetEmailVerificationResponse.fromJson(result);

        if (responseData.status == 2) {
          AuthController.i.updateisforgetLoading(false);
          Get.offAll(() => const OtpScreen());
          // Utils.toastMessage(responseData.errorMessage.toString(),
          //     ColorManager.kPrimaryColor, Colors.white);

          log(responseData.toJson().toString());
          return responseData;
        } else {
          CustomPopup.showError(responseData.errorMessage.toString());
          // Utils.toastMessage(
          //     responseData.errorMessage.toString(), Colors.grey, Colors.white);
          AuthController.i.updateisforgetLoading(false);
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
      AuthController.i.updateisforgetLoading(false);
    }
  }

  resendforgetemailverification() async {
    var body = {
      "Email": AuthController.i.forgetemailController.text.trim(),
    };

    var headers = {
      'Content-Type': 'application/json',
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.forgetemailverify),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        ForgetEmailVerificationResponse responseData =
            ForgetEmailVerificationResponse.fromJson(result);
        AuthController.i.updateisLoading(true);
        if (responseData.status == 2) {
          AuthController.i.updateisLoading(false);
          // Utils.toastMessage(responseData.errorMessage.toString(),
          //     ColorManager.kPrimaryColor, Colors.white);

          // StepsController.i.updatediseaseresponse(genderResponseData);
          log(responseData.toJson().toString());
          return responseData;
        } else {
          CustomPopup.showError(responseData.errorMessage.toString());
          AuthController.i.updateisLoading(false);
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
      AuthController.i.updateisLoading(false);
    }
  }

  otpVerification() async {
    var body = {
      "OTPCode": AuthController.i.code,
      "email": AuthController.i.forgetemailController.text.trim()
    };

    var headers = {
      'Content-Type': 'application/json',
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.otpverification),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        OtpVerificationModel responseData =
            OtpVerificationModel.fromJson(result);
        AuthController.i.updateisOtpLoading(true);
        if (responseData.status == 2) {
          AuthController.i.updateisOtpLoading(false);
          // Utils.toastMessage(responseData.errorMessage.toString(),
          //     ColorManager.kPrimaryColor, Colors.white);
          Get.offAll(const CreateNewPasswordScreen());
          // StepsController.i.updatediseaseresponse(genderResponseData);
          log(responseData.toJson().toString());
          return responseData;
        } else {
          CustomPopup.showError(responseData.errorMessage.toString());
          // Utils.toastMessage(
          //     responseData.errorMessage.toString(), Colors.grey, Colors.white);
          AuthController.i.updateisOtpLoading(false);
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
      AuthController.i.updateisLoading(false);
    }
  }

  resetForgetPassword() async {
    var body = {
      "Email": AuthController.i.forgetemailController.text.trim(),
      "Password": AuthController.i.newpasscontroller.text,
      "OTPCode": AuthController.i.code,
      "ConfirmPassword": AuthController.i.confirmnewpasscontroller.text,
    };

    var headers = {
      'Content-Type': 'application/json',
    };
    try {
      var response = await http.post(
          Uri.parse(AppConstants.resetforgetpassword),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        ResetForgetPasswordModel responseData =
            ResetForgetPasswordModel.fromJson(result);
        if (responseData.status == 2) {
          AuthController.i.updateisLoading(false);
          // Utils.toastMessage(responseData.errorMessage.toString(),
          //     ColorManager.kPrimaryColor, Colors.white);
          Get.offAll(const NewPasswordSucess());
          // StepsController.i.updatediseaseresponse(genderResponseData);
          log(responseData.toJson().toString());
          return responseData;
        } else {
          CustomPopup.showError(responseData.errorMessage.toString());
          AuthController.i.updateisLoading(false);
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
      AuthController.i.updateisLoading(false);
    }
  }

  changePassword() async {
    String? userId = await LocalDb().getUserid();
    var body = {
      "Id": userId,
      "BranchId": AuthController.i.branchId ?? "",
      "OldPassword": AuthController.i.oldpasscontroller.text,
      "Password": AuthController.i.changeNewpasscontroller.text,
    };

    var headers = {
      'Content-Type': 'application/json',
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.changePassword),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        ChangePasswordModel responseData = ChangePasswordModel.fromJson(result);
        if (responseData.status != null && responseData.status! >= 1) {
          AuthController.i.updateisLoading(false);

          logout();
          log(responseData.toJson().toString());
          return responseData;
        } else {
          CustomPopup.showError(responseData.error.toString());
          AuthController.i.updateisLoading(false);
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString());
      AuthController.i.updateisLoading(false);
    }
  }

  loginApi() async {
    AuthController.i.updateisLoading(true);
    try {
      String? Manufacturer = "";
      String? Model = "";
      String? AppVersion = "";
      String? DeviceVersionIos;
      String? DeviceVersion;
      String? deviceToken = await LocalDb().getDeviceToken();
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      String? model;
      String? manufacturer;
      String? appVersion;
      AndroidBuildVersion? deviceVersion;
      String? version;
      int sdkInt;
      String? release;
      String? iosDeviceVersion;
      AndroidBuildVersion? deviceVersions;
      if (Platform.isAndroid) {
        var androidInfo = await DeviceInfoPlugin().androidInfo;
        release = androidInfo.version.release;
        sdkInt = androidInfo.version.sdkInt;
        manufacturer = androidInfo.manufacturer;
        deviceVersion = androidInfo.version;
        model = androidInfo.brand;
        appVersion = androidInfo.version.release;
      }
      if (Platform.isIOS) {
        var iosInfo = await DeviceInfoPlugin().iosInfo;
        manufacturer = iosInfo.name;
        appVersion = iosInfo.systemVersion;
        model = iosInfo.model;
        iosDeviceVersion = iosInfo.utsname.machine.isNotEmpty
            ? iosInfo.utsname.machine.toString()
            : "12";
      }

      Map<String, dynamic> body = {
        "UserName": AuthController.i.email.text,
        "Password": AuthController.i.pass.text,
        "FaceBookAccessToken": AuthController.i.faceBookAccessToken ?? "",
        "GmailAccessToken": AuthController.i.gmailAccessToken ?? "",
        "AccountType": AuthController.i.accountType,
        "DeviceToken": deviceToken ??
            "laksdjflajsdlfjl8923urksdjf8923orweufsdkju2893uwerfokljlasjlsladllsllllsafsalkf8239847239847298758923",
        "Manufacturer": Manufacturer,
        "Model": Model,
        "AppVersion": AppVersion,
        "DeviceVersion": Platform.isAndroid
            ? "${deviceVersion?.release}"
            : "$iosDeviceVersion",
      };
      log("Sending login request with body: $body");
      var response = await api.loginApi(body);
      var status = response['Status'];
      var errorMsg = response['ErrorMessage'];
      var id = response['Id'];
      var uname = response['FirstName'];
      var accesstoken = response['AccessToken'];
      var token = response['Token'];
      var branchId = response['BranchId'];
      print("Login response status: $status");
      if (status < 1) {
        CustomPopup.showError(errorMsg.toString());
      } else if (status == 1) {
        LocalDb().saveLoginStatus(true);
        LocalDb().saveUserid(id);
        LocalDb().saveUsername(uname);
        LocalDb().saveAccessToken(accesstoken);
        AuthController.i.setBranchId(branchId);
        LocalDb().saveUserToken(accesstoken);
        await Get.offAll(() => const DrawerScreen());
      }
      print('Navigating to DrawerScreen');
    } catch (e) {
      print('Login API error: $e');
    } finally {
      AuthController.i.updateisLoading(false);
      print('Loading state updated to false');
    }
  }

  signupApi() async {
    AuthController.i.updateisLoading(true);
    String? Manufacturer = "";
    String? Model = "";
    String? AppVersion = "";
    String? DeviceVersionIos;
    String? DeviceVersion;
    String? deviceToken = await LocalDb().getDeviceToken();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    String? model;
    String? manufacturer;
    String? appVersion;
    AndroidBuildVersion? deviceVersion;
    String? version;
    int sdkInt;
    String? release;
    String? iosDeviceVersion;
    AndroidBuildVersion? deviceVersions;
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      release = androidInfo.version.release;
      sdkInt = androidInfo.version.sdkInt;
      manufacturer = androidInfo.manufacturer;
      deviceVersion = androidInfo.version;
      model = androidInfo.brand;
      appVersion = androidInfo.version.release;
    }
    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      manufacturer = iosInfo.name;
      appVersion = iosInfo.systemVersion;
      model = iosInfo.model;
      iosDeviceVersion = iosInfo.utsname.machine.toString();
    }

    Map<String, dynamic> body = {
      "FirstName": AuthController.i.name.text,
      "CellNumber": AuthController.i.countryCode + AuthController.i.phone.text,
      "Password": AuthController.i.pass.text.isNotEmpty
          ? AuthController.i.pass.text
          : "",
      "ConfirmPassword": AuthController.i.confirmpass.text.isNotEmpty
          ? AuthController.i.confirmpass.text
          : "",
      "FaceBookAccessToken":
          AuthController.i.faceBookAccessToken?.isNotEmpty ?? false
              ? AuthController.i.faceBookAccessToken
              : "",
      "GmailAccessToken": AuthController.i.gmailAccessToken?.isNotEmpty ?? false
          ? AuthController.i.gmailAccessToken
          : "",
      "AccountType": AuthController.i.accountType,
      "PatientTypeId": "BEB03D33-E8AA-E711-80C1-A0B3CCE147BA",
      "Email": AuthController.i.email.text,
      "PanelType": "1",
      "DependentStatus": "1",
      "Manufacturer": Manufacturer,
      "Model": Model,
      "AppVersion": AppVersion,
      "DeviceVersion": Platform.isAndroid
          ? "${deviceVersion?.release}"
          : "$iosDeviceVersion",
      "DeviceToken": deviceToken,
      "CellNumberCountryCode": AuthController.i.countryCode,
      "CNICNumber": "",
      "TelephoneNumber": "",
      "DateOfBirth": "",
      "PicturePath": "",
      'Address': "",
      "GenderId": "",
      "RelationshipTypeId": "",
      "CountryId": "",
      "StateOrProvinceId": "",
      "CityId": "",
      "BranchId": "",
      "MiddleName": "",
      "LastName": "user",
      "GuardianName": "",
      "OtherIdentity": "",
      "Passport": "",
      "IdentityRelation": "",
      "NOKFirstName": "",
      "NOKLastName": "",
      "NOKCNICNumber": "",
      "NOKCellNumber": "",
      "PanelEntitleLetter": "",
      "PanelEntitleLetterB": "",
      "OccupationId": "",
      "PanelOrganizationPackageId": "",
      "PersonTitleId": "",
      "MaritalStatusId": "",
      "BloodGroupId": "",
      "NOKRelationId": "",
      "Prefix": "",
      "IdentityTypeId": "",
      "OrganizationId": "",
      "ReferenceId": "",
      "PanelOrganizationId": "",
      "PanelValidDate": "",
      "PanelEmployeeCardNo": "",
      "PanelDepartment": "",
      "PanelDesignation": "",
      "PanelRelation": "",
      "PanelEmployeeCardNoDependent": "",
      "OnPanelValidDate": "",
      "OnPanelEmployeeNo": "",
      "OnPanelDepartment": "",
      "OnPanelDesignation": "",
      "OnPanelRelationId": "",
      "OnPanelOrganizationId": "",
      "OnPanelOrganizationPackageId": "",
      "OnPanelEmployeeCardNoDependent": "",
      "IsTakeRegistrationFee": "",
      "WorkingSessionId": "",
      "PatientAppointmentId": "",
      "DiscountType": "",
      "Discount": "",
      "Reference": "",
      "Remarks": "",
    };
    try {
      var response = await api.signupApi(body);
      log("Signup API Response: $response");
      var status = response['Status'];
      var errorMsg = response['ErrorMessage'];
      var accessToken = response['AccessToken'];
      var id = response['Id'];
      if (status < 1) {
        CustomPopup.showError(errorMsg.toString());
      } else if (status == 1) {
        LocalDb().saveUserid(id);
        LocalDb().saveAccessToken(accessToken);
        Get.offAll(() => const GenderScreen());
      }
    } catch (error) {
      log("Signup API Error: $error");
      AuthController.i.updateisLoading(false);
    }
  }

  deleteUserAccount() async {
    String? accessToken = await LocalDb().getAccessToken();
    String? userId = await LocalDb().getUserid();
    String? deviceToken = await LocalDb().getDeviceToken();
    String? token = await LocalDb().getUserToken();
    var body = {
      "UserId": userId,
    };
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.deleteUserAccount),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        DeleteUserModel responseData = DeleteUserModel.fromJson(result);
        if (responseData.status == 1) {
          AuthController.i.updateIsLoading(false);
          Get.offAll(() => const LoginScreen());

          log(responseData.toJson().toString());
          return responseData.status;
        } else {
          CustomPopup.showError(responseData.errorMessage.toString());
          AuthController.i.updateIsLoading(false);
        }
      } else {
        log('Error: Received status code ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('Exception: $e');
      log('StackTrace: $stackTrace');
      // ToastManager.showToast(e.toString());
      AuthController.i.updateIsLoading(false);
    }
  }

  logout() async {
    String? accessToken = await LocalDb().getAccessToken();
    String? userId = await LocalDb().getUserid();
    String? deviceToken = await LocalDb().getDeviceToken();
    String? token = await LocalDb().getUserToken();
    var body = {
      "UserId": userId,
      "DeviceToken": deviceToken ??
          "laksdjflajsdlfjl8923urksdjf8923orweufsdkju2893uwerfokljlasjlsladllsllllsafsalkf8239847239847298758923",
      "IsLogOffAllDevice": 0
    };
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await http.post(Uri.parse(AppConstants.logoff),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        LogoutUserModel responseData = LogoutUserModel.fromJson(result);
        if (responseData.status == 1) {
          AuthController.i.updateIsLoading(false);
          Get.offAll(() => const LoginScreen());

          log(responseData.toJson().toString());
          return responseData.status;
        } else {
          CustomPopup.showError(responseData.errorMessage.toString());
          AuthController.i.updateIsLoading(false);
        }
      } else {
        log('Error: Received status code ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log('Exception: $e');
      log('StackTrace: $stackTrace');
      // ToastManager.showToast(e.toString());
      AuthController.i.updateIsLoading(false);
    }
  }
}
