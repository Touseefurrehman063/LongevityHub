import 'dart:convert';
import 'dart:developer';
import 'package:longevity_hub/data/controller/health_a_z_controller/health_az_controller.dart';
import 'package:longevity_hub/models/health_model/health_detail_model.dart';
import 'package:longevity_hub/models/health_model/health_model.dart';
import 'package:longevity_hub/models/health_model/live_well_detail_model.dart';
import 'package:longevity_hub/models/health_model/live_well_model.dart';
import 'package:longevity_hub/utils/constants.dart';
import 'package:http/http.dart' as http;

class HealthAtoZRepository {
  Future<List<HealthAzModel>> getSignificantLinks(String category) async {
    var headers = {
      'Content-Type': 'application/json',
      'apikey': AppConstants().apikey
    };
    try {
      var response = await http.get(
        Uri.parse('${AppConstants.getcondition}?category=$category'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        if (result == null || result['significantLink'] == null) {
          return [];
        }
        List<HealthAzModel> significantLinks =
            (result['significantLink'] as List)
                .map((data) => HealthAzModel.fromJson(data))
                .toList();
        return significantLinks;
      } else {
        return []; // Return an empty list in case of HTTP error
      }
    } catch (e, stackTrace) {
      log('Exception: $e', stackTrace: stackTrace);
      return []; // Return an empty list in case of exception
    }
  }

  Future<List<HealthAzModel>> getDiseaseDiscritpion(String category) async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.get(
        Uri.parse('${AppConstants.getcondition}?category=$category'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        if (result == null || result['significantLink'] == null) {
          return [];
        }
        List<HealthAzModel> significantLinks =
            (result['significantLink'] as List)
                .map((data) => HealthAzModel.fromJson(data))
                .toList();
        return significantLinks;
      } else {
        log('Error: ${response.statusCode} ${response.reasonPhrase}');
        return []; // Return an empty list in case of HTTP error
      }
    } catch (e, stackTrace) {
      log('Exception: $e', stackTrace: stackTrace);
      return []; // Return an empty list in case of exception
    }
  }

  Future<List<HealthDetailModel>> getHealthDetails(
      {required String url}) async {
    var headers = {
      'Content-Type': 'application/json',
      'apikey': AppConstants().apikey
    };
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result == null || result['mainEntityOfPage'] == null) {
          return [];
        }
        List<HealthDetailModel> pageEntities =
            (result['mainEntityOfPage'] as List)
                .map((data) => HealthDetailModel.fromJson(data))
                .toList();
        HealthController.i.updateMainEntityOfPage(pageEntities);
        if (result['hasPart'] != null) {
          List<HealthDetailModel> hasPart = (result['hasPart'] as List)
              .map((data) => HealthDetailModel.fromJson(data))
              .toList();
          HealthController.i.updatehasPart(hasPart);
        }
        return pageEntities;
      } else {
        return []; // Return an empty list in case of HTTP error
      }
    } catch (e, stackTrace) {
      log('Exception: $e', stackTrace: stackTrace);
      return []; // Return an empty list in case of exception
    }
  }

  Future<List<LiveWellModel>> getLiveWellCategories() async {
    var headers = {
      'Content-Type': 'application/json',
      'apikey': AppConstants().apikey,
    };
    try {
      var response = await http.get(
        Uri.parse(AppConstants.getLiveWellCategories),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        log('API Response: $result');
        if (result == null || result['mainEntityOfPage'] == null) {
          return [];
        }
        List<LiveWellModel> mainEntityPage =
            (result['mainEntityOfPage'] as List)
                .map((data) => LiveWellModel.fromJson(data))
                .toList();
        return mainEntityPage;
      } else {
        return [];
      }
    } catch (e, stackTrace) {
      log('Exception: $e', stackTrace: stackTrace);
      return [];
    }
  }

  Future<List<LiveWellDetailModel>> getLiveWellDetail(
      {required String url}) async {
    var headers = {
      'Content-Type': 'application/json',
      'apikey': AppConstants().apikey,
    };

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        // Check if 'mainEntityOfPage' is present in the result
        if (result == null || result['mainEntityOfPage'] == null) {
          return [];
        }
        String? disc = result['description'];
        HealthController.i.updatedisc(disc);
        // Extract the list of items
        List<LiveWellDetailModel> mainActivityList =
            (result['mainEntityOfPage'] as List).map((data) {
          return LiveWellDetailModel.fromJson(data);
        }).toList();

        return mainActivityList;
      } else {
        return [];
      }
    } catch (e, stackTrace) {
      log('Exception: $e', stackTrace: stackTrace);
      return [];
    }
  }
}
