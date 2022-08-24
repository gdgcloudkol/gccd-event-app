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
  static String fsfEligibleForReferral = "eligibleForReferral";

  ///End of fields for user ticket application form

  ///Start of fields for user ticket application form
  static String fsfBlog = "Blog";
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
  static String fsfCity = "city";
  static String fsfAppRegistration = "app_registration";
  static String fsfRejected = "rejected";

  ///End of fields for user ticket application form

  ///Start of fields for user referral
  static String fsfReferredBy = "referredBy";
  static String fsfOngoingReferrals = "ongoingReferrals";
  static String fsfCompleteReferrals = "completeReferrals";

  ///End of fields for user referral

  ///Start of fields for ticket
  static String fsfConferenceTicket = "conference";
  static String fsfWorkshopTicket = "workshop";
  static String fsfTicketID = "ticketId";

  ///End of fields for user referral

  ///Shared Preference Keys
  ///Var naming convention use guide : Start with pref
  static String prefEmail = "email";
  static String prefLoggedIn = "loggedIn";
  static String prefName = "name";
  static String prefUID = "uid";
  static String prefEligibleForReferral = "eligibleForReferral";
  static String prefReferralCode = "referralCode";
  static String prefProfilePicUrl = "profilePicUrl";
  static String prefHasTicket = "hasTicket";
  static String prefTicketRejected = "ticketRejected";
  static String prefConferenceTicketImageUrl = "conferenceTicketImageUrl";
  static String prefWorkshopTicketImageUrl = "workshopTicketImageUrl";
  static String prefProfile = "profile";


  static String fcmArgRedirect = "redirect";
  static String fcmArgScreen = "appScreen";

  ///Last date for call for speakers
  static DateTime cfsLastDate = DateTime(2022, 8, 4, 23, 59, 59);
  static DateTime referralContestLastDate = DateTime(2022, 8, 25, 23, 59, 59);
  static DateTime hackathonLastDate = DateTime(2022, 8, 19, 10, 00, 00);
  static DateTime ticketApplyLastDate = DateTime(2022, 8, 24, 01, 00, 00);
}
