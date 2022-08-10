import 'package:ccd2022app/utils/config.dart';

class TicketFormModel {
  String blog;
  String github;
  String linkedIn;
  String about;
  String conference;
  String confirm;
  String contact;
  String diet;
  String email;
  String enrolled;
  String name;
  String organization;
  String pronoun;
  String role;
  String tSize;
  String understand;
  String workshop;
  String city;
  String appRegistration;

  TicketFormModel(
    this.blog,
    this.github,
    this.linkedIn,
    this.about,
    this.conference,
    this.confirm,
    this.contact,
    this.diet,
    this.email,
    this.enrolled,
    this.name,
    this.organization,
    this.pronoun,
    this.role,
    this.tSize,
    this.understand,
    this.workshop,
    this.city, {
    this.appRegistration = "Yes",
  });

  Map<String, dynamic> toMap() {
    return {
      Config.fsfBlog: blog,
      Config.fsfGithub: github,
      Config.fsfLinkedIn: linkedIn,
      Config.fsfAbout: about,
      Config.fsfConference: conference,
      Config.fsfConfirm: confirm,
      Config.fsfContact: contact,
      Config.fsfDiet: diet,
      Config.fsfEmail: email,
      Config.fsfEnrolled: enrolled,
      Config.fsfName: name,
      Config.fsfOrganization: organization,
      Config.fsfOrganization: organization,
      Config.fsfPronoun: pronoun,
      Config.fsfRole: role,
      Config.fsfTSize: tSize,
      Config.fsfUnderstand: understand,
      Config.fsfWorkshop: workshop,
      Config.fsfAppRegistration : appRegistration,
      Config.fsfCity : city,
    };
  }
}
