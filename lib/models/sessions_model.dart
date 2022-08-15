class SessionsGrid {
  String id = "";
  String title = "";
  String? description;
  String startsAt = "";
  String endsAt = "";
  String room = "";
  String? liveUrl;
  String? recordingUrl;
  List<Speaker> speakers;
  List<Category> categories;

  // from json
  SessionsGrid({
    this.id = "",
    this.title = "",
    this.description,
    this.startsAt = "",
    this.endsAt = "",
    this.room = "",
    this.liveUrl,
    this.recordingUrl,
    this.speakers = const [],
    this.categories = const [],
  });

  static fromJson(json) {
    return SessionsGrid(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      startsAt: json["startsAt"],
      endsAt: json["endsAt"],
      room: json["room"],
      liveUrl: json["liveUrl"],
      recordingUrl: json["recordingUrl"],
      speakers: List<Speaker>.from(json["speakers"]
          .map(
            (json) => Speaker.fromJson(json),
          )
          .toList()),
      categories: List<Category>.from(json["categories"]
          .map(
            (json) => Category.fromJson(json),
          )
          .toList()),
    );
  }
}

class Speaker {
  String id;
  String name;

  Speaker({
    this.id = "",
    this.name = "",
  });

  static fromJson(json) {
    return Speaker(
      id: json["id"],
      name: json["name"],
    );
  }
}

class Category {
  int id;
  String name;
  List<CategoryItem> categoryItems;

  Category({
    this.id = 0,
    this.name = "",
    this.categoryItems = const [],
  });

  static fromJson(json) {
    return Category(
      id: json["id"],
      name: json["name"],
      categoryItems: List<CategoryItem>.from(json["categoryItems"]
          .map(
            (json) => CategoryItem.fromJson(json),
          )
          .toList()),
    );
  }
}

class CategoryItem {
  int id;
  String name;

  CategoryItem({
    this.id = 0,
    this.name = "",
  });

  static fromJson(json) {
    return CategoryItem(
      id: json["id"],
      name: json["name"],
    );
  }
}
