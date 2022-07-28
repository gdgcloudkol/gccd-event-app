import 'package:ccd2022app/widgets/custom_inputfields.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _organizationController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _linkedinController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _blogController = TextEditingController();

  final FocusNode _nameNode = FocusNode();
  final FocusNode _phoneNode = FocusNode();
  final FocusNode _organizationNode = FocusNode();
  final FocusNode _cityNode = FocusNode();
  final FocusNode _aboutNode = FocusNode();
  final FocusNode _linkedinNode = FocusNode();
  final FocusNode _githubNode = FocusNode();
  final FocusNode _blogNode = FocusNode();

  bool? _enrolledUG = false;
  bool? _day1 = false;
  bool? _day2 = false;
  bool? _agree = false;
  bool? _agreeTicket = false;

  String? _currentPreferredPronoun;
  String? _currentRole;
  String? _currentTSize;
  String? _currentDiet;

  final List<String> _preferredPronouns = [
    "he/him",
    "she/her",
    "they/them",
    "Decline to specify",
  ];

  final List<String> _roles = [
    "Architect",
    "Data Analyst",
    "Data Engineer",
    "Data Scientist",
    "Database Admin",
    "Designer",
    "Developer",
    "DevOps Engineer",
    "Machine Learning Engineer",
    "Network Engineer",
    "Other Role Not Listed",
    "Security Professional",
    "Speaker/hosting",
    "Student",
    "SysAdmin",
    "Technical Writer",
    "Decline to specify",
  ];
  final List<String> _diet = [
    "None",
    "Vegetarian",
    "Non-vegetarian",
    "Eggetarian",
    "Vegan",
    "Other",
  ];

  final List<String> _tShirtSizes = [
    "S",
    "M",
    "L",
    "XL",
    "2XL",
    "3XL",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "Application Form",
          style: TextStyle(
            fontFamily: "GoogleSans",
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 35,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Complete your participant application here and wait for us to get back to you on your application status!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: "GoogleSans",
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              buildInputField(
                "Full Name",
                "John Doe",
                TextInputType.name,
                _nameController,
                context,
                false,
                _nameNode,
                _phoneNode,
              ),
              buildInputField(
                "Phone number",
                "9000000000",
                const TextInputType.numberWithOptions(
                    signed: false, decimal: false),
                _phoneController,
                context,
                false,
                _phoneNode,
                _organizationNode,
              ),
              buildDropdown(
                "Preferred Pronoun",
                _currentPreferredPronoun,
                _preferredPronouns,
                size.width,
                (p0) {
                  setState(() {
                    _currentPreferredPronoun = p0;
                  });
                },
                (p0) => null,
                context,
              ),
              buildCheckbox(
                _enrolledUG,
                "Are you currently enrolled in a full-time undergraduate academic course?",
                (bool? newValue) {
                  setState(() {
                    _enrolledUG = newValue;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              buildInputField(
                "Organization/College",
                "Dunder Mifflin Paper Company, Inc.",
                TextInputType.text,
                _organizationController,
                context,
                false,
                _organizationNode,
                _cityNode,
              ),
              buildInputField(
                "Current City",
                "Kolkata",
                TextInputType.text,
                _cityController,
                context,
                false,
                _cityNode,
                _aboutNode,
              ),
              buildDropdown(
                "Role",
                _currentRole,
                _roles,
                size.width,
                (p0) {
                  setState(() {
                    _currentRole = p0;
                  });
                },
                (p0) => null,
                context,
              ),
              buildDescInputField(
                "About You",
                "I own a light saber...",
                TextInputType.multiline,
                _aboutController,
                context,
                false,
                _aboutNode,
                _linkedinNode,
              ),
              buildInputField(
                "LinkedIn Profile URL",
                "https://www.linkedin.com/in/johndoe/",
                TextInputType.text,
                _linkedinController,
                context,
                false,
                _linkedinNode,
                _githubNode,
              ),
              buildInputField(
                "GitHub Profile URL",
                "https://www.github.com/johndoe/",
                TextInputType.text,
                _githubController,
                context,
                false,
                _githubNode,
                _blogNode,
              ),
              buildInputField(
                "Blog/Website URL",
                "https://johndoe.com/",
                TextInputType.text,
                _blogController,
                context,
                true,
                _blogNode,
                null,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "What parts of the event are you interested in?",
                style: TextStyle(
                  fontFamily: "GoogleSans",
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black,
                    width: .2,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Column(
                  children: [
                    buildCheckbox(
                      _day1,
                      "Workshop - Day 1",
                      (bool? newValue) {
                        setState(() {
                          _day1 = newValue;
                        });
                      },
                      heightSpace: 10,
                    ),
                    const Divider(color: Colors.black),
                    buildCheckbox(
                      _day2,
                      "Conference - Day 2",
                      (bool? newValue) {
                        setState(() {
                          _day2 = newValue;
                        });
                      },
                      heightSpace: 0,
                    ),
                  ],
                ),
              ),
              buildDropdown(
                "Dietary Restrictions",
                _currentDiet,
                _diet,
                size.width,
                (p0) {
                  setState(() {
                    _currentDiet = p0;
                  });
                },
                (p0) => null,
                context,
              ),
              buildDropdown(
                "T-shirt Size",
                _currentTSize,
                _tShirtSizes,
                size.width,
                (p0) {
                  setState(() {
                    _currentTSize = p0;
                  });
                },
                (p0) => null,
                context,
              ),
              buildCheckbox(
                _agree,
                "Agree to Terms and Conditions?",
                (bool? newValue) {
                  setState(() {
                    _agree = newValue;
                  });
                },
                subtitle:
                    "I have read and agree to the GDG Event Participation Terms and acknowledge that "
                    "Google will use any information I provide in connection with the Google Developer Group "
                    "program and events in accordance with Google’s Privacy Policy. I also agree to adhere "
                    "to the GDG event code of conduct for my attendance at any GDG event, both in-person and online.",
              ),
              buildCheckbox(
                _agreeTicket,
                "Agree to ticketing terms?",
                (bool? newValue) {
                  setState(() {
                    _agreeTicket = newValue;
                  });
                },
                subtitle:
                    "Filling this form does not guarentee access to the event. The details of my "
                    "submission will be reviewed in all fairness complying with the Code of Conduct of the event."
                    " On availability of seats I shall be sent a Ticket Claim email which I must claim within 72 hours from "
                    "receiving the email, failing which my ticket will be transferred to those on the waitlist and"
                    " I can no longer make any claim on it nor will show up to the event without a confirmation ticket.",
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCheckbox(
      bool? value, String title, void Function(bool?)? onChanged,
      {double heightSpace = 30, String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: heightSpace,
        ),
        CheckboxListTile(
          value: value,
          onChanged: onChanged,
          checkboxShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          title: Text(
            title,
            style: const TextStyle(
              fontFamily: "GoogleSans",
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: subtitle == null
              ? null
              : Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: "GoogleSans",
                    fontSize: 14,
                  ),
                ),
        ),
      ],
    );
  }

  buildDropdown(
    String label,
    String? currentValue,
    List<String> items,
    double size,
    void Function(String?)? onChanged,
    String? Function(String?)? validator,
    BuildContext context,
  ) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 30,
      ),
      Text(
        label,
        style: const TextStyle(
          fontFamily: "GoogleSans",
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField<String>(
          isDense: false,
          isExpanded: true,
          menuMaxHeight: 350,
          borderRadius: BorderRadius.circular(10),
          decoration: InputDecoration(
            labelText: "",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.black45,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
          style: const TextStyle(
            fontFamily: "GoogleSans",
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
          value: currentValue,
          validator: validator,
          selectedItemBuilder: (context) {
            return items.map<Widget>((String item) {
              return SizedBox(
                width: size,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontFamily: "GoogleSans",
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              );
            }).toList();
          },
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20),
                    width: size,
                    child: Text(
                      value,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "GoogleSans",
                        color: Colors.black,
                        fontWeight: value == currentValue
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    ]);
  }
}
