// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:longevity_hub/utils/AppImages.dart';

class BackgroundLogoimage extends StatelessWidget {
  const BackgroundLogoimage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        AppImages.background,
        fit: BoxFit.cover,
      ),
    );
  }
}
