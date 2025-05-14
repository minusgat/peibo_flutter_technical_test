import 'package:flutter/material.dart';
import 'package:peibo_flutter_technical_test/chore/configuration/app_colors.dart';

class ColorPair {
  final Color baseColor;
  final Color contrastColor;

  ColorPair({required this.baseColor, required this.contrastColor});
}

ColorPair getManualPastelColorPairFromName(String nombreColor) {
  final pastelColorPairs = <String, ColorPair>{
    'black': ColorPair(
      baseColor: AppColors.blackBase,
      contrastColor: AppColors.blackContrast,
    ),
    'blue': ColorPair(
      baseColor: AppColors.blueBase,
      contrastColor: AppColors.blueContrast,
    ),
    'brown': ColorPair(
      baseColor: AppColors.brownBase,
      contrastColor: AppColors.brownContrast,
    ),
    'gray': ColorPair(
      baseColor: AppColors.grayBase,
      contrastColor: AppColors.grayContrast,
    ),
    'green': ColorPair(
      baseColor: AppColors.greenBase,
      contrastColor: AppColors.greenContrast,
    ),
    'pink': ColorPair(
      baseColor: AppColors.pinkBase,
      contrastColor: AppColors.pinkContrast,
    ),
    'purple': ColorPair(
      baseColor: AppColors.purpleBase,
      contrastColor: AppColors.purpleContrast,
    ),
    'red': ColorPair(
      baseColor: AppColors.redBase,
      contrastColor: AppColors.redContrast,
    ),
    'white': ColorPair(
      baseColor: AppColors.whiteBase,
      contrastColor: AppColors.whiteContrast,
    ),
    'yellow': ColorPair(
      baseColor: AppColors.yellowBase,
      contrastColor: AppColors.yellowContrast,
    ),
  };

  return pastelColorPairs[nombreColor.toLowerCase()] ??
      ColorPair(baseColor: Colors.grey, contrastColor: Colors.white);
}

extension ColorPairExtension on String {
  ColorPair get colorPair {
    final result = getManualPastelColorPairFromName(this);
    return result;
  }
}
