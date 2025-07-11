import 'package:flutter/material.dart';
import 'package:quill_html_editor_v3/quill_html_editor_v3.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ToolbarExample(),
  ));
}

class ToolbarExample extends StatefulWidget {
  const ToolbarExample({super.key});

  @override
  State<ToolbarExample> createState() => _ToolbarExampleState();
}

class _ToolbarExampleState extends State<ToolbarExample> {
  late QuillEditorController controller;

  // Custom toolbar configuration with only the 6 items in the exact order requested
  final customToolBarList = [
    ToolBarStyle.image, // 1st - image
    ToolBarStyle.bold, // 2nd - font style (bold)
    ToolBarStyle.color, // 3rd - color picker
    ToolBarStyle.size, // 4th - size
    ToolBarStyle.undo, // 5th - undo
    ToolBarStyle.redo, // 6th - redo
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Custom Toolbar Example'),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            // Custom toolbar with border styling
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: ToolBar(
                toolBarConfig: customToolBarList,
                controller: controller,
                toolBarColor: Colors.white,
                iconColor: Colors.black87,
                activeIconColor: Colors.blue,
                borderColor: const Color(0xFFE4E4E7),
                borderRadius: 12.0,
                iconSize: 30,
                padding: const EdgeInsets.all(4),
                customButtons: [
                  // Custom button example
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE4E4E7)),
                    ),
                    child: const Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE4E4E7)),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            // Editor
            Expanded(
              child: QuillHtmlEditor(
                text:
                    "<h1>Hello World!</h1>This is a custom toolbar example 😊",
                hintText: 'Start typing...',
                controller: controller,
                isEnabled: true,
                minHeight:
                    50, // Set to roughly one line height for compact initial size
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                hintTextStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.white,
                onTextChanged: (text) => debugPrint('Text changed: $text'),
                onEditorCreated: () => debugPrint('Editor created'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
