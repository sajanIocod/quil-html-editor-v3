# Custom SVG Icons for Toolbar

The Quill HTML Editor now supports custom SVG icons for the image, undo, and redo toolbar items. This allows you to replace the default Material Icons with your own custom SVG graphics.

## Usage

To use custom SVG icons, pass `Widget` objects to the `ToolBar` constructor using the following parameters:

- `customImageIcon`: Custom SVG widget for the image toolbar item
- `customUndoIcon`: Custom SVG widget for the undo toolbar item  
- `customRedoIcon`: Custom SVG widget for the redo toolbar item

## Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quill_html_editor_v3/quill_html_editor_v3.dart';

ToolBar(
  controller: controller,
  toolBarConfig: [
    ToolBarStyle.image,
    ToolBarStyle.undo,
    ToolBarStyle.redo,
  ],
  // Custom SVG icons
  customImageIcon: SvgPicture.string(
    '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 11l2.5 3.01L15 10l4 5H5l4-4z" fill="currentColor"/>
    </svg>''',
    colorFilter: ColorFilter.mode(Colors.black87, BlendMode.srcIn),
    width: 20,
    height: 20,
  ),
  customUndoIcon: SvgPicture.string(
    '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M12.5 8c-2.65 0-5.05.99-6.9 2.6L2 7v9h9l-3.62-3.62c1.39-1.16 3.16-1.88 5.12-1.88 3.54 0 6.55 2.31 7.6 5.5l2.37-.78C21.08 11.03 17.15 8 12.5 8z" fill="currentColor"/>
    </svg>''',
    colorFilter: ColorFilter.mode(Colors.black87, BlendMode.srcIn),
    width: 20,
    height: 20,
  ),
  customRedoIcon: SvgPicture.string(
    '''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M18.4 10.6C16.55 8.99 14.15 8 11.5 8c-4.65 0-8.58 3.03-9.96 7.22L3.9 16c1.05-3.19 4.05-5.5 7.6-5.5 1.95 0 3.73.72 5.12 1.88L13 16h9V7l-3.6 3.6z" fill="currentColor"/>
    </svg>''',
    colorFilter: ColorFilter.mode(Colors.black87, BlendMode.srcIn),
    width: 20,
    height: 20,
  ),
)
```

## Using SVG Assets

You can also use SVG files from your assets:

```dart
customImageIcon: SvgPicture.asset(
  'assets/icons/custom_image_icon.svg',
  colorFilter: ColorFilter.mode(Colors.black87, BlendMode.srcIn),
  width: 20,
  height: 20,
),
```

## Requirements

To use SVG icons, you need to add the `flutter_svg` package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_svg: ^2.2.0
```

## Notes

- Custom icons only apply to the image, undo, and redo toolbar items
- If no custom icon is provided, the default Material Icon will be used
- The `colorFilter` property allows you to apply the current toolbar icon color to the SVG
- Size the SVG appropriately for your toolbar (typically 16-24px)
