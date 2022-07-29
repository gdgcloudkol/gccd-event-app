
///Root Class that stores Configs used throughout the app
class Config {
  ///Firestore collection names
  ///Var naming convention use guide : Start with fsc
  static String fscUsers = "users";
  static String fscTicketFormRegistrations = "register";
  static String fscTickets = "tickets";

  ///Firestore field names
  ///Var naming convention use guide : Start with fsf
  static String fsfUid = "uid";       ///Start of fields for user collection form
  static String fsfName = "name";
  static String fsfEmail = "email";
  static String fsfLoginProvider = "loginProvider";       ///End of fields for user ticket application form

  static String fsfBlog = "Blog";     ///Start of fields for user ticket application form
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
  static String fsfWorkshop = "workshop";     ///End of fields for user ticket application form

  // static String fsfWorkshop = "workshop";     ///Start of fields for user tickets


  ///Shared Preference Keys
  ///Var naming convention use guide : Start with pref
  static String prefEmail = "email";
  static String prefLoggedIn = "loggedIn";
  static String prefName = "name";
  static String prefUID = "uid";
  static String prefProfilePicUrl = "profilePicUrl";
  static String prefHasTicket = "hasTicket";
}
