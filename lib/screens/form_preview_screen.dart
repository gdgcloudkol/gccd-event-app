import 'package:ccd2022app/blocs/ticket_status_bloc.dart';
import 'package:ccd2022app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormPreviewScreen extends StatefulWidget {
  const FormPreviewScreen({Key? key}) : super(key: key);

  @override
  State<FormPreviewScreen> createState() => _FormPreviewScreenState();
}

class _FormPreviewScreenState extends State<FormPreviewScreen> {
  bool? _day1 = false;
  bool? _day2 = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TicketStatusBloc tsb = Provider.of<TicketStatusBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "Your Application",
          style: TextStyle(
            fontFamily: "GoogleSans",
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: tsb.loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
          : SizedBox(
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
                    Text("Name: ${tsb.applicantData![Config.fsfName]}"),
                    Text("Phone: ${tsb.applicantData![Config.fsfContact]}"),
                    Text(
                      "Preferred Pronoun: ${tsb.applicantData![Config.fsfPronoun]}",
                    ),
                    Text(
                      "Enrolled UG: ${tsb.applicantData![Config.fsfEnrolled]}",
                    ),
                    Text(
                      "Organization/College: ${tsb.applicantData![Config.fsfOrganization]}",
                    ),
                    Text(
                      "City: ${tsb.applicantData![Config.fsfCity]}",
                    ),
                    Text(
                      "Role: ${tsb.applicantData![Config.fsfRole]}",
                    ),
                    Text(
                      "About: ${tsb.applicantData![Config.fsfAbout]}",
                    ),
                    Text(
                      "LinkedIn: ${tsb.applicantData![Config.fsfLinkedIn]}",
                    ),
                    Text(
                      "GitHub: ${tsb.applicantData![Config.fsfGithub]}",
                    ),
                    Text(
                      "Blog: ${tsb.applicantData![Config.fsfBlog]}",
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
                    Text(
                      "Diet: ${tsb.applicantData![Config.fsfDiet]}",
                    ),
                    Text(
                      "Tshirt: ${tsb.applicantData![Config.fsfTSize]}",
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
