class Sponsor {
  String color, url, logo, description;

  Sponsor({
    required this.color,
    required this.url,
    required this.logo,
    required this.description,
  });

  factory Sponsor.fromJson(Map<String, dynamic> json) {
    return Sponsor(
        color: json['color'],
        url: json['url'],
        logo: json['logo'],
        description: json['description']);
  }
}
