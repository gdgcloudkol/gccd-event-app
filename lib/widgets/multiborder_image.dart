import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MultiBorderImage extends StatelessWidget {
  const MultiBorderImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.3,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.height * 0.12,
          child: const CircularProgressIndicator(
            value: 1,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff3d82f8)),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.height * 0.12,
          child: const CircularProgressIndicator(
            value: 0.75,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff2ea94f)),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.height * 0.12,
          child: const CircularProgressIndicator(
            value: 0.5,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xfff9b923)),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.height * 0.12,
          child: const CircularProgressIndicator(
            value: 0.25,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xffe54540)),
          ),
        ),
        CachedNetworkImage(
          imageUrl: imageUrl,
          height: MediaQuery.of(context).size.height * 0.12 - 4,
          width: MediaQuery.of(context).size.height * 0.12 - 5,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.red,
              ),
            ),
          ),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
