import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../models/speaker_model.dart';

class SpeakersBloc extends ChangeNotifier {
  // create a api call to get the speakers list
  // http call to get the speakers list
  final Uri speakersUrl =
      Uri.parse("https://sessionize.com/api/v2/kirmfltc/view/Speakers");

  List<Speaker> _speakers = [];

  List<Speaker> get speakers => _speakers;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _isError = false;

  bool get isError => _isError;

  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  SpeakersBloc() {
    _fetchSpeakers();
  }

  Future _fetchSpeakers() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await get(speakersUrl);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        _speakers = List<Speaker>.from(
            data.map((json) => Speaker.fromJson(json)).toList());
        _isLoading = false;
        notifyListeners();
      } else {
        _isError = true;
        _errorMessage = "Something went wrong";
        notifyListeners();
      }
    } catch (e) {
      _isError = true;
      if (kDebugMode) {
        print(e.toString());
      }
      _errorMessage = "Something went wrong";
      notifyListeners();
    }
  }

  String getSpeakerImageUrl(String id) {
    for (Speaker sp in speakers) {
      if (sp.id == id) {
        return sp.profilePicture;
      }
    }

    return "";
  }

  Speaker? getSpeaker(String id) {
    for (Speaker sp in speakers) {
      if (sp.id == id) {
        return sp;
      }
    }
    return null;
  }
}
