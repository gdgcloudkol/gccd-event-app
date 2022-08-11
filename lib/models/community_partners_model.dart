class CommunityPartners {
  String communityName;
  String url;
  String logo;
  String chapter;

  CommunityPartners({
    required this.communityName,
    required this.url,
    required this.chapter,
    required this.logo,
  });

  factory CommunityPartners.fromJson(Map<String, dynamic> json) {
    return CommunityPartners(
      communityName: json['community'],
      url: json['url'],
      logo: json['logo'],
      chapter: json['chapter'],
    );
  }
}
