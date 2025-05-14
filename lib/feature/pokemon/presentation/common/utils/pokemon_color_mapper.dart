//black-> primary,
import 'package:flutter/material.dart';

class ColorPair {
  final Color baseColor;
  final Color contrastColor;

  ColorPair({required this.baseColor, required this.contrastColor});
}

ColorPair getManualPastelColorPairFromName(String nombreColor) {
  final pastelColorPairs = <String, List<String>>{
    'black': ['#686B72', '#A9A9A9'],
    'blue': ['#7CB0FF', '#DAF4FF'],
    'brown': ['#D1784E', '#FFDEB1'],
    'gray': ['#B7B7B7', '#F2F2F2'],
    'green': ['#7FE69E', '#DFFFE5'],
    'pink': ['#FF98CC', '#FFDDEC'],
    'purple': ['#BC6FFF', '#EFD6FF'],
    'red': ['#FF8400', '#FEDFB6'],
    'white': ['#FFFFFF', '#DADADA'],
    'yellow': ['#FFE958', '#FFF4D0'],
  };

  final colorsHex = pastelColorPairs[nombreColor.toLowerCase()];
  if (colorsHex != null && colorsHex.length == 2) {
    final baseColor = _colorFromHex(colorsHex[0]);
    final contrastColor = _colorFromHex(colorsHex[1]);
    return ColorPair(baseColor: baseColor, contrastColor: contrastColor);
  }
  return ColorPair(baseColor: Colors.grey, contrastColor: Colors.white);
}

Color _colorFromHex(String hexColor) {
  final buffer = StringBuffer();
  if (hexColor.length == 6 || hexColor.length == 7) buffer.write('ff');
  buffer.write(hexColor.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

extension ColorPairExtension on String {
  ColorPair get colorPair {
    final result = getManualPastelColorPairFromName(this);
    return result;
  }
}
