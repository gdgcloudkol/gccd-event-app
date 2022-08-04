import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

Widget buildSocialMediaIconButton(String launchUrl, Color color, IconData icon,
    {double size = 30}) {
  return IconButton(
    onPressed: () {
      launchUrlString(
        launchUrl,
        mode: LaunchMode.externalApplication,
      );
    },
    icon: Icon(
      icon,
      color: color,
      size: size,
    ),
  );
}
