import 'dart:convert';

import 'package:ccd2022app/models/time_slot_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

/// {@category Blocs}
class SessionsGridBloc extends ChangeNotifier {
  // create a api call to get the sessions list
  // http call to get the sessions list
  final Uri sessionsUrl =
      Uri.parse("https://sessionize.com/api/v2/kirmfltc/view/GridSmart");

  List<Timeslot> _day1Slots = [];

  List<Timeslot> _day2Slots = [];

  List<Timeslot> get day1Slots => _day1Slots;

  List<Timeslot> get day2Slots => _day2Slots;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _hasError = false;

  bool get hasError => _hasError;

  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  SessionsGridBloc() {
    _fetchSessions();
  }

  void _fetchSessions() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await get(sessionsUrl);
      if (response.statusCode == 200) {
        _day1Slots = [];
        _day2Slots = [];
        final data = json.decode(response.body);
        final day1TimeslotsData = data[0]["timeSlots"];
        final day2TimeslotsData = data[1]["timeSlots"];

        _day1Slots = List<Timeslot>.from(
            day1TimeslotsData.map((json) => Timeslot.fromJson(json)).toList());
        _day2Slots = List<Timeslot>.from(
            day2TimeslotsData.map((json) => Timeslot.fromJson(json)).toList());

        _isLoading = false;
        notifyListeners();
      } else {
        _hasError = true;
        _errorMessage = "Something went wrong";
        notifyListeners();
      }
    } catch (e) {
      _hasError = true;
      if (kDebugMode) {
        print(e.toString());
      }
      _errorMessage = "Something went wrong";
      notifyListeners();
    }
  }
}
