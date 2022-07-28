import 'dart:convert';

import 'package:covid_tracker_app/models/world_states.dart';
import 'package:covid_tracker_app/services/utitiles/app_url.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<WorldStates> fetchWorldStats() async {
    var response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStates.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> fetchCountryStats() async {
    var data;
    var response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
