import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final bool isNetworkImage;

  const FullScreenImage(
      {super.key, required this.imageUrl, required this.isNetworkImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: isNetworkImage
              ? Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                )
              : Image.asset(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
        ),
      ),
    );
  }
}
