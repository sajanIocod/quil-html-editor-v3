// Responsive Toolbar Demo for Quill HTML Editor v3
// This example demonstrates how the toolbar adapts to different screen sizes

import 'package:flutter/material.dart';
import 'package:quill_html_editor_v3/quill_html_editor_v3.dart';

void main() {
  runApp(const ResponsiveToolbarDemo());
}

class ResponsiveToolbarDemo extends StatelessWidget {
  const ResponsiveToolbarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Toolbar Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ResponsiveEditorPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ResponsiveEditorPage extends StatefulWidget {
  const ResponsiveEditorPage({super.key});

  @override
  _ResponsiveEditorPageState createState() => _ResponsiveEditorPageState();
}

class _ResponsiveEditorPageState extends State<ResponsiveEditorPage> {
  late QuillEditorController controller;

  // All available toolbar styles for comprehensive testing
  final fullToolBarList = [
    ToolBarStyle.image,
    ToolBarStyle.bold,
    ToolBarStyle.italic,
    ToolBarStyle.underline,
    ToolBarStyle.color,
    ToolBarStyle.size,
    ToolBarStyle.undo,
    ToolBarStyle.redo,
  ];

  @override
  void initState() {
    super.initState();
    controller = QuillEditorController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text('Responsive Toolbar Demo'),
            Text(
              'Screen width: ${screenWidth.toInt()}px',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Screen size indicator
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: _getScreenSizeColor(screenWidth),
            child: Text(
              _getScreenSizeDescription(screenWidth),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Responsive Toolbar
          ToolBar(
            controller: controller,
            toolBarConfig: fullToolBarList,
            toolBarColor: Colors.white,
            iconColor: Colors.black87,
            activeIconColor: Colors.blue,
            iconSize: 25,
            borderColor: Colors.grey.shade300,
            borderRadius: 12,
            // The toolbar will automatically adapt to screen size
          ),

          // Editor
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: QuillHtmlEditor(
                controller: controller,
                minHeight: 200,
                hintText:
                    'Test the responsive toolbar by resizing your screen or rotating your device...',
                textStyle: const TextStyle(fontSize: 16),
                backgroundColor: Colors.grey.shade50,
                padding: const EdgeInsets.all(16),
              ),
            ),
          ),

          // Instructions
          Container(
            padding: const EdgeInsets.all(16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Responsive Behavior:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                    '📱 Small screens (<400px): Icons wrap to new lines with compact spacing'),
                Text(
                    '📲 Tablets (600-1024px): Comfortable wrapping with better spacing'),
                Text(
                    '💻 Large screens (>1024px): Horizontal scrolling if needed'),
                SizedBox(height: 8),
                Text(
                  'Try resizing your browser window or rotating your device to see the toolbar adapt!',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getScreenSizeColor(double width) {
    if (width < 400) return Colors.red;
    if (width < 600) return Colors.orange;
    if (width < 1024) return Colors.green;
    return Colors.blue;
  }

  String _getScreenSizeDescription(double width) {
    if (width < 400) {
      return '📱 Small Mobile (${width.toInt()}px) - Toolbar wraps with compact spacing';
    }
    if (width < 600) {
      return '📱 Mobile (${width.toInt()}px) - Toolbar wraps normally';
    }
    if (width < 1024) {
      return '📲 Tablet (${width.toInt()}px) - Toolbar wraps with comfortable spacing';
    }
    return '💻 Desktop (${width.toInt()}px) - Toolbar uses horizontal scrolling';
  }
}
