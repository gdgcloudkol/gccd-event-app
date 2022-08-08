import 'package:ccd2022app/models/community_partners_model.dart';

///Root Class that stores Configs used throughout the app
class Config {
  ///Firestore collection names
  ///Var naming convention use guide : Start with fsc
  static String fscUsers = "users";
  static String fscTicketFormRegistrations = "register";
  static String fscTickets = "tickets";

  ///Firestore field names
  ///Var naming convention use guide : Start with fsf
  static String fsfUid = "uid";

  ///Start of fields for user collection form
  static String fsfName = "name";
  static String fsfEmail = "email";
  static String fsfLoginProvider = "loginProvider";

  ///End of fields for user ticket application form

  static String fsfBlog = "Blog";

  ///Start of fields for user ticket application form
  static String fsfGithub = "GitHub";
  static String fsfLinkedIn = "LinkedIn";
  static String fsfAbout = "about";
  static String fsfConference = "conference";
  static String fsfConfirm = "confirm";
  static String fsfContact = "contact";
  static String fsfDiet = "diet";
  static String fsfEnrolled = "enrolled";
  static String fsfOrganization = "organization";
  static String fsfPronoun = "pronoun";
  static String fsfRole = "role";
  static String fsfTSize = "tsize";
  static String fsfUnderstand = "understand";
  static String fsfWorkshop = "workshop";

  ///End of fields for user ticket application form

  // static String fsfWorkshop = "workshop";     ///Start of fields for user tickets

  ///Shared Preference Keys
  ///Var naming convention use guide : Start with pref
  static String prefEmail = "email";
  static String prefLoggedIn = "loggedIn";
  static String prefName = "name";
  static String prefUID = "uid";
  static String prefProfilePicUrl = "profilePicUrl";
  static String prefHasTicket = "hasTicket";
  static String prefConferenceTicketImageUrl = "conferenceTicketImageUrl";

  static String fcmArgRedirect = "redirect";
  static String fcmArgScreen = "appScreen";

  static List<CommunityPartnersModel> communityPartners = [
    CommunityPartnersModel(
      "Google Developer Student Clubs",
      "https://dscnsec.com/",
      "NSEC",
      "assets/images/Logo.png",
    ),
    CommunityPartnersModel(
      "Google Developer Student Clubs",
      "https://dscciem.github.io/",
      "CIEM",
      "assets/images/Logo.png",
    ),
    CommunityPartnersModel(
      "Google Developer Student Clubs",
      "https://gdscsit2021.github.io/",
      "SIT",
      "assets/images/Logo.png",
    ),
    CommunityPartnersModel(
      "Google Developer Student Clubs",
      "https://twitter.com/DSC_GCE",
      "GCE",
      "assets/images/Logo.png",
    ),
    CommunityPartnersModel(
      "Google Developer Student Clubs",
      "https://gdsc.community.dev/government-engineering-college-bilaspur/",
      "GECBSP",
      "assets/images/Logo.png",
    ),
    CommunityPartnersModel(
      "Google Developer Student Clubs",
      "https://dschit.com/",
      "HIT",
      "assets/images/Logo.png",
    ),
    CommunityPartnersModel(
      "Google Developer Student Clubs",
      "https://www.linkedin.com/in/gdsc-jisce/?trk=public_profile_browsemap&originalSubdomain=in",
      "JISCE",
      "assets/images/Logo.png",
    ),
    CommunityPartnersModel(
      "Google Developer Student Clubs",
      "https://gdsc.community.dev/dr-sudhir-chandra-sur-institute-of-technology-sports-complex-kolkata/",
      "DSCSIT",
      "assets/images/Logo.png",
    ),
    CommunityPartnersModel(
      "Google Developer Student Clubs",
      "https://dscmsit.github.io/",
      "MSIT",
      "assets/images/Logo.png",
    ),
  ];
}
