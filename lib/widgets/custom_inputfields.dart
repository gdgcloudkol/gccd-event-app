import 'package:flutter/material.dart';

buildInputField(
  String label,
  String hint,
  TextInputType type,
  TextEditingController controller,
  BuildContext context,
  bool isLast,
  FocusNode node,
  FocusNode? nextNode,
) {
  const Color THEME_COLOR = Color(0xfff9fafb);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: 20,
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
      Material(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextFormField(
          controller: controller,
          textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
          focusNode: node,
          onFieldSubmitted: (s) {
            if (nextNode != null) {
              nextNode.requestFocus();
            } else if (isLast) {
              FocusScope.of(context).unfocus();
            } else {
              FocusScope.of(context).nextFocus();
            }
          },
          autofocus: false,
          style: const TextStyle(
            color: Colors.black,
          ),
          keyboardType: type,
          decoration: InputDecoration(
            labelText: "",
            hintText: hint,
            hintStyle: const TextStyle(
              fontFamily: "GoogleSans",
            ),
            labelStyle: const TextStyle(color: THEME_COLOR),
            filled: true,
            fillColor: THEME_COLOR,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 0.2,
                color: Colors.black,
                style: BorderStyle.solid,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 2,
                color: Colors.black,
                style: BorderStyle.solid,
              ),
            ),
          ),
        ),
      )
    ],
  );
}

buildDescInputField(
  String label,
  String hint,
  TextInputType type,
  TextEditingController controller,
  BuildContext context,
  bool isLast,
  FocusNode node,
  FocusNode? nextNode,
) {
  const Color THEME_COLOR = Color(0xfff9fafb);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: 20,
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
      Material(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextFormField(
          controller: controller,
          textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
          focusNode: node,
          minLines: 3,
          autofocus: false,
          maxLines: null,
          onFieldSubmitted: (s) {
            if (nextNode != null) {
              nextNode.requestFocus();
            } else if (isLast) {
              FocusScope.of(context).unfocus();
            } else {
              FocusScope.of(context).nextFocus();
            }
          },
          style: const TextStyle(
            color: Colors.black,
          ),
          keyboardType: type,
          decoration: InputDecoration(
            labelText: "",
            hintText: hint,
            hintStyle: const TextStyle(
              fontFamily: "GoogleSans",
            ),
            labelStyle: const TextStyle(color: THEME_COLOR),
            filled: true,
            fillColor: THEME_COLOR,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 0.2,
                color: Colors.black,
                style: BorderStyle.solid,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 2,
                color: Colors.black,
                style: BorderStyle.solid,
              ),
            ),
          ),
        ),
      )
    ],
  );
}
