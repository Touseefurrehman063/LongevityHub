import 'package:longevity_hub/data/response/network/network_api_services.dart';
import 'package:longevity_hub/utils/constants.dart';

class LoginRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> loginApi(var data) async {
    dynamic response = await _apiService.postApi(data, AppConstants.login);
    return response;
  }

  Future<dynamic> signupApi(var data) async {
    dynamic response = await _apiService.postApi(data, AppConstants.signup);
    return response;
  }

  Future<dynamic> updateApi(var data) async {
    dynamic response =
        await _apiService.postApi(data, AppConstants.updateprofile);
    return response;
  }
}
