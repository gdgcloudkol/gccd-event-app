import 'package:ccd2022app/blocs/auth_bloc.dart';
import 'package:ccd2022app/blocs/ticket_status_bloc.dart';
import 'package:ccd2022app/utils/config.dart';
import 'package:ccd2022app/widgets/multiborder_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    AuthBloc ab = Provider.of<AuthBloc>(context);
    TicketStatusBloc tsb = Provider.of<TicketStatusBloc>(context);

    return Container(
      constraints: const BoxConstraints.expand(),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/ccd_background.png'),
          fit: BoxFit.cover,
          opacity: 0.3,
        ),
      ),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          MultiBorderImage(
            imageUrl: ab.profilePicUrl,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              tsb.hasApplied ? tsb.applicantData['name'] : ab.name,
              style: const TextStyle(
                fontSize: 30,
                fontFamily: 'GoogleSans',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              tsb.applicantData['role'] ?? '',
              softWrap: true,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                fontFamily: 'GoogleSans',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Text(
              tsb.applicantData['organization'] ?? '',
              softWrap: true,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'GoogleSans',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: getSocialLinks(
              github: tsb.applicantData[Config.fsfGithub] ?? '',
              linkedIn: tsb.applicantData[Config.fsfLinkedIn] ?? '',
              blog: tsb.applicantData[Config.fsfBlog] ?? '',
              email: tsb.applicantData[Config.fsfEmail] ?? '',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "About Me",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'GoogleSans',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        ReadMoreText(
                          tsb.applicantData['about'] ?? '',
                          trimLines: 10,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: '...read more',
                          trimExpandedText: 'collapse ',
                          style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'GoogleSans',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: const Divider(
                        color: Colors.black12,
                      ),
                    ),
                    tsb.applicantData['city'] != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.location_pin,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  tsb.applicantData['city'] ?? '',
                                  softWrap: true,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'GoogleSans',
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                      child: const Divider(
                        color: Colors.black12,
                      ),
                    ),
                    tsb.applicantData['contact'] != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.call,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  tsb.applicantData['contact'] ?? '',
                                  softWrap: true,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'GoogleSans',
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                      child: const Divider(
                        color: Colors.black12,
                      ),
                    ),
                    tsb.applicantData['diet'] != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.food_bank_rounded,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  tsb.applicantData['diet'] ?? '',
                                  softWrap: true,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'GoogleSans',
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                      child: const Divider(
                        color: Colors.black12,
                      ),
                    ),
                    tsb.applicantData['tsize'] != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                FontAwesomeIcons.shirt,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  tsb.applicantData['tsize'] ?? '',
                                  softWrap: true,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'GoogleSans',
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSocialLinks({
    required String email,
    required String blog,
    required String linkedIn,
    required String github,
  }) {
    print(blog);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 12.0),
            child: InkWell(
              onTap: () {
                launchUrlString(
                  'mailto:$email',
                  mode: LaunchMode.externalApplication,
                );
              },
              child: getSocialLink('email'),
            ),
          ),
          github.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 12.0),
                  child: InkWell(
                    onTap: () {
                      launchUrlString(
                        github,
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: getSocialLink('github'),
                  ),
                )
              : Container(),
          linkedIn.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 12.0),
                  child: InkWell(
                    onTap: () {
                      launchUrlString(
                        linkedIn,
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: getSocialLink('linkedIn'),
                  ),
                )
              : Container(),
          blog.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: InkWell(
                    onTap: () {
                      launchUrlString(
                        blog,
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: getSocialLink('blog'),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Icon getSocialLink(String type) {
    switch (type) {
      case "email":
        return const Icon(FontAwesomeIcons.envelope,
            color: Color(0xFF1DA1F2), size: 30);
      case "github":
        return const Icon(FontAwesomeIcons.github,
            color: Color(0xFF333F4D), size: 30);
      case "linkedIn":
        return const Icon(FontAwesomeIcons.linkedin,
            color: Color(0xFF0077B5), size: 30);
      case "blog":
        return const Icon(FontAwesomeIcons.bloggerB,
            color: Color(0xFF0077B5), size: 30);
      default:
        return const Icon(Icons.link, size: 30);
    }
  }
}
