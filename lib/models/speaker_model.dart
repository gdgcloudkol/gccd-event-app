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
    this.id = "",
    this.fullName = "",
    this.bio = "",
    this.tagLine = "",
    this.profilePicture = "",
    this.links = const [],
    this.sessions = const [],
  });

  static fromJson(json) {
    return Speaker(
      id: json["id"],
      fullName: json["fullName"],
      bio: json["bio"],
      tagLine: json["tagLine"],
      profilePicture: json["profilePicture"],
      links: List<Link>.from(json["links"]
          .map(
            (json) => Link.fromJson(json),
          )
          .toList()),
      sessions: List<Session>.from(json["sessions"]
          .map(
            (json) => Session.fromJson(json),
          )
          .toList()),
    );
  }
}

class Session {
  int id;
  String name;

  Session({
    this.id = 0,
    this.name = "",
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
    this.title = "",
    this.url = "",
    this.linkType = "",
  });

  static fromJson(json) {
    return Link(
      title: json["title"],
      url: json["url"],
      linkType: json["linkType"],
    );
  }
}
