import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'dart:async';

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

  void _fetchSpeakers() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await get(speakersUrl);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _speakers = data["data"]
            .map<Speaker>((json) => Speaker.fromJson(json))
            .toList();
        _isLoading = false;
        notifyListeners();
      } else {
        _isError = true;
        _errorMessage = "Something went wrong";
        notifyListeners();
      }
    } catch (e) {
      _isError = true;
      _errorMessage = "Something went wrong";
      notifyListeners();
    }
  }
}

class Speaker {
  String id = "";
  String fullName = "";
  String bio = "";
  String tagLine = "";
  String profilePicture = "";
  List<Link> links = [];
  List<Session> sessions = [];

  // from json
  Speaker({
    required this.id,
    required this.fullName,
    required this.bio,
    required this.tagLine,
    required this.profilePicture,
    required this.links,
    required this.sessions,
  });

  static fromJson(json) {
    return Speaker(
      id: json["id"],
      fullName: json["fullName"],
      bio: json["bio"],
      tagLine: json["tagLine"],
      profilePicture: json["profilePicture"],
      links: json["links"].map<Link>((json) => Link.fromJson(json)).toList(),
      sessions: json["sessions"]
          .map<Session>((json) => Session.fromJson(json))
          .toList(),
    );
  }
}

class Session {
  String id;
  String name;

  Session({
    required this.id,
    required this.name,
  });

  static fromJson(json) {
    return Session(
      id: json["id"],
      name: json["name"],
    );
  }
}

class Link {
  String title;
  String url;
  String linkType;

  Link({
    required this.title,
    required this.url,
    required this.linkType,
  });

  static fromJson(json) {
    return Link(
      title: json["title"],
      url: json["url"],
      linkType: json["linkType"],
    );
  }
}
