import 'package:flutter/material.dart';
import 'package:quill_html_editor_v3/src/utils/hex_color.dart';
import 'package:quill_html_editor_v3/src/widgets/webviewx/src/webviewx_plus.dart';

///[ColorPicker] a widget to pick colors from a color grid
class ColorPicker extends StatelessWidget {
  ///[ColorPicker] constructor of a widget to pick colors from a color grid
  const ColorPicker({super.key, required this.onColorPicked});

  /// [onColorPicked] callback when a color is picked
  final Function(String) onColorPicked;

  // Pre-computed colors for better performance
  static final List<Color> _computedColors = _colorList.map((hex) => HexColor.fromHex(hex)).toList();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 120,
        height: 120,
        color: Colors.white,
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: _colorList.length,
            padding: const EdgeInsets.all(2),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              return WebViewAware(
                child: GestureDetector(
                    onTap: () {
                      // Immediate callback without heavy computations
                      onColorPicked(_colorList[index]);
                    },
                    child: _colorPaletteItem(index)),
              );
            }));
  }

  Widget _colorPaletteItem(int index) {
    return Container(
      decoration: BoxDecoration(
          color: _computedColors[index],
          border: Border.all(width: 0.3, color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(2),
      ),
      width: 40,
      height: 40,
    );
  }
}

///// custom color list feature will coming in future release
const List<String> _colorList = [
  '#000000',
  '#FFFFFF',
  '#F44336',
  '#E91E63',
  '#9C27B0',
  '#673AB7',
  '#3F51B5',
  '#2196F3',
  '#03A9F4',
  '#00BCD4',
  '#009688',
  '#4CAF50',
  '#8BC34A',
  '#CDDC39',
  '#FFEB3B',
  '#FFC107',
  '#FF9800',
  '#FF5722',
  '#795548'
];
