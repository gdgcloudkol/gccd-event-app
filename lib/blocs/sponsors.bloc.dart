import 'dart:convert';

import 'package:ccd2022app/models/sponsor_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SponsorsBloc extends ChangeNotifier {
  Future<List<Sponsor>?> fetchSponsors(
      http.Client client, BuildContext context) async {
    final response = await client.get(Uri.parse(
        'https://raw.githubusercontent.com/gdgcloudkol/ccd2022-app/main/data/sponsors.json'));
    return compute(parseSponsors, response.body);
  }
}

///Warning : Don't put inside class, needs to be a top level function
/// to work with compute method
/// Top level function that converts a response body into a List<Sponsor>.
List<Sponsor> parseSponsors(responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Sponsor>((json) => Sponsor.fromJson(json)).toList();
}
