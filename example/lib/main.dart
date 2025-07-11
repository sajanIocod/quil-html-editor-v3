import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quill_html_editor_v3/quill_html_editor_v3.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ///[controller] create a QuillEditorController to access the editor methods
  late QuillEditorController controller;

  ///[customToolBarList] pass the custom toolbarList to show only selected styles in the editor
  /// Only 6 items in the exact order: 1st image, 2nd font style, 3rd color picker, 4th size, 5th undo, 6th redo
  final customToolBarList = [
    ToolBarStyle.image, // 1st - image
    ToolBarStyle.bold, // 2nd - font style (bold)
    ToolBarStyle.color, // 3rd - color picker
    ToolBarStyle.size, // 4th - size
    ToolBarStyle.undo, // 5th - undo
    ToolBarStyle.redo, // 6th - redo
  ];

  final _toolbarColor = Colors.grey.shade200;
  final _backgroundColor = Colors.white70;
  final _toolbarIconColor = Colors.black87;
  final _editorTextStyle = const TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto');
  final _hintTextStyle = const TextStyle(
      fontSize: 18, color: Colors.black38, fontWeight: FontWeight.normal);

  @override
  void initState() {
    controller = QuillEditorController();
    controller.onTextChanged((text) {
      debugPrint('listening to $text');
    });
    controller.onEditorLoaded(() {
      debugPrint('Editor Loaded :)');
    });
    super.initState();
  }

  @override
  void dispose() {
    /// please do not forget to dispose the controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            ToolBar(
              toolBarColor: _toolbarColor,
              padding: const EdgeInsets.all(8),
              // iconSize: 25,
              iconColor: _toolbarIconColor,
              activeIconColor: Colors.greenAccent.shade400,
              controller: controller,
              toolBarConfig: customToolBarList,
              borderColor: const Color(0xFFE4E4E7),
              borderRadius: 8.0,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              customButtons: const [],
              // Custom SVG icons for image, undo, and redo
              customImageIcon: SvgPicture.string(
                '''<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" viewBox="0 0 25 25" fill="none">
                     <path d="M6.45687 20.4006C6.0067 20.4006 5.6262 20.2423 5.31537 19.9256C5.00454 19.6089 4.84912 19.2313 4.84912 18.7928V6.20834C4.84912 5.76984 5.00454 5.39225 5.31537 5.07559C5.6262 4.75892 6.0067 4.60059 6.45687 4.60059H19.0414C19.4915 4.60059 19.872 4.75892 20.1829 5.07559C20.4937 5.39225 20.6491 5.76984 20.6491 6.20834V18.7928C20.6491 19.2313 20.4937 19.6089 20.1829 19.9256C19.872 20.2423 19.4915 20.4006 19.0414 20.4006H6.45687ZM6.45687 19.1006H19.0414C19.1184 19.1006 19.1889 19.0685 19.2529 19.0043C19.317 18.9403 19.3491 18.8698 19.3491 18.7928V6.20834C19.3491 6.13134 19.317 6.06084 19.2529 5.99684C19.1889 5.93267 19.1184 5.90059 19.0414 5.90059H6.45687C6.37987 5.90059 6.30937 5.93267 6.24537 5.99684C6.1812 6.06084 6.14912 6.13134 6.14912 6.20834V18.7928C6.14912 18.8698 6.1812 18.9403 6.24537 19.0043C6.30937 19.0685 6.37987 19.1006 6.45687 19.1006ZM8.90312 17.0506H16.6771C16.838 17.0506 16.9536 16.9768 17.0241 16.8293C17.0946 16.682 17.0811 16.5398 16.9836 16.4026L14.6491 13.2833C14.568 13.1628 14.4641 13.1026 14.3376 13.1026C14.211 13.1026 14.1071 13.1628 14.0261 13.2833L11.8299 16.1198L10.5914 14.5698C10.5104 14.4557 10.4081 14.3986 10.2846 14.3986C10.1613 14.3986 10.059 14.4589 9.97787 14.5796L8.60562 16.4031C8.49879 16.5399 8.4827 16.682 8.55737 16.8293C8.63204 16.9768 8.74729 17.0506 8.90312 17.0506Z" fill="#162D3A" fill-opacity="0.5"/>
                   </svg>''',
                colorFilter:
                    ColorFilter.mode(_toolbarIconColor, BlendMode.srcIn),
                width: 20,
                height: 20,
              ),
              customUndoIcon: SvgPicture.string(
                '''<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" viewBox="0 0 25 25" fill="none">
                     <path d="M8.70195 18.9998C8.48912 18.9998 8.31087 18.928 8.1672 18.7843C8.0237 18.6408 7.95195 18.4627 7.95195 18.2498C7.95195 18.037 8.0237 17.8588 8.1672 17.7153C8.31087 17.5717 8.48912 17.4998 8.70195 17.4998H15.1287C16.1724 17.4998 17.0705 17.1552 17.823 16.4661C18.5756 15.7771 18.952 14.9262 18.952 13.9133C18.952 12.9005 18.5756 12.0511 17.823 11.3651C17.0705 10.6792 16.1724 10.3363 15.1287 10.3363H8.1077L10.3635 12.5921C10.5083 12.7371 10.5807 12.9127 10.5807 13.1191C10.5807 13.3254 10.5083 13.5011 10.3635 13.6461C10.2186 13.7909 10.0414 13.8617 9.8317 13.8586C9.62204 13.8552 9.44804 13.7844 9.3097 13.6461L5.8827 10.2191C5.78904 10.1254 5.72304 10.0267 5.6847 9.92282C5.6462 9.81899 5.62695 9.70682 5.62695 9.58632C5.62695 9.46582 5.6462 9.35365 5.6847 9.24982C5.72304 9.14599 5.78904 9.04724 5.8827 8.95357L9.3097 5.52682C9.45454 5.38199 9.63012 5.30957 9.83645 5.30957C10.043 5.30957 10.2186 5.38199 10.3635 5.52682C10.5083 5.67165 10.5791 5.8489 10.576 6.05857C10.5728 6.26807 10.502 6.44207 10.3635 6.58057L8.1077 8.83632H15.1287C16.5915 8.83632 17.8445 9.32449 18.8875 10.3008C19.9305 11.2772 20.452 12.4813 20.452 13.9133C20.452 15.3453 19.9305 16.5511 18.8875 17.5306C17.8445 18.5101 16.5915 18.9998 15.1287 18.9998H8.70195Z" fill="#162D3A" fill-opacity="0.5"/>
                   </svg>''',
                colorFilter:
                    ColorFilter.mode(_toolbarIconColor, BlendMode.srcIn),
                width: 20,
                height: 20,
              ),
              customRedoIcon: SvgPicture.string(
                '''<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" viewBox="0 0 25 25" fill="none">
                     <path d="M16.8923 10.3363H9.87135C8.82768 10.3363 7.9296 10.6792 7.1771 11.3651C6.42443 12.0511 6.0481 12.9005 6.0481 13.9133C6.0481 14.9262 6.42443 15.7771 7.1771 16.4661C7.9296 17.1552 8.82768 17.4998 9.87135 17.4998H16.2981C16.5109 17.4998 16.6892 17.5717 16.8328 17.7153C16.9763 17.8588 17.0481 18.037 17.0481 18.2498C17.0481 18.4627 16.9763 18.6408 16.8328 18.7843C16.6892 18.928 16.5109 18.9998 16.2981 18.9998H9.87135C8.40851 18.9998 7.1556 18.5101 6.1126 17.5306C5.0696 16.5511 4.5481 15.3453 4.5481 13.9133C4.5481 12.4813 5.0696 11.2772 6.1126 10.3008C7.1556 9.32449 8.40851 8.83632 9.87135 8.83632H16.8923L14.6366 6.58057C14.4981 6.44207 14.4273 6.26807 14.4241 6.05857C14.4209 5.8489 14.4918 5.67165 14.6366 5.52682C14.7814 5.38199 14.9571 5.30957 15.1636 5.30957C15.3699 5.30957 15.5455 5.38199 15.6903 5.52682L19.1173 8.95357C19.211 9.04724 19.277 9.14599 19.3153 9.24982C19.3538 9.35365 19.3731 9.46582 19.3731 9.58632C19.3731 9.70682 19.3538 9.81899 19.3153 9.92282C19.277 10.0267 19.211 10.1254 19.1173 10.2191L15.6903 13.6461C15.552 13.7844 15.378 13.8552 15.1683 13.8586C14.9587 13.8617 14.7814 13.7909 14.6366 13.6461C14.4918 13.5011 14.4193 13.3254 14.4193 13.1191C14.4193 12.9127 14.4918 12.7371 14.6366 12.5921L16.8923 10.3363Z" fill="#162D3A" fill-opacity="0.5"/>
                   </svg>''',
                colorFilter:
                    ColorFilter.mode(_toolbarIconColor, BlendMode.srcIn),
                width: 20,
                height: 20,
              ),
            ),
            Expanded(
              child: QuillHtmlEditor(
                text: "<h1>Hello</h1>This is a quill html editor example 😊",
                hintText: 'Hint text goes here',
                controller: controller,
                isEnabled: true,
                ensureVisible: false,
                minHeight: 50, // Set to roughly one line height
                autoFocus: false,
                textStyle: _editorTextStyle,
                hintTextStyle: _hintTextStyle,
                hintTextAlign: TextAlign.start,
                padding: const EdgeInsets.only(left: 10, top: 10),
                hintTextPadding: const EdgeInsets.only(left: 20),
                backgroundColor: _backgroundColor,
                inputAction: InputAction.newline,
                onEditingComplete: (s) => debugPrint('Editing completed $s'),
                loadingBuilder: (context) {
                  return const Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 1,
                    color: Colors.red,
                  ));
                },
                onFocusChanged: (focus) {
                  debugPrint('has focus $focus');
                },
                onTextChanged: (text) => debugPrint('widget text change $text'),
                onEditorCreated: () {
                  debugPrint('Editor has been loaded');
                  setHtmlText('Testing text on load');
                },
                onEditorResized: (height) =>
                    debugPrint('Editor resized $height'),
                onSelectionChanged: (sel) =>
                    debugPrint('index ${sel.index}, range ${sel.length}'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textButton({required String text, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: _toolbarIconColor,
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: _toolbarColor),
          )),
    );
  }

  ///[getHtmlText] to get the html text from editor
  void getHtmlText() async {
    String? htmlText = await controller.getText();
    debugPrint(htmlText);
  }

  ///[setHtmlText] to set the html text to editor
  void setHtmlText(String text) async {
    await controller.setText(text);
  }

  ///[insertNetworkImage] to set the html text to editor
  void insertNetworkImage(String url) async {
    await controller.embedImage(url);
  }

  ///[insertVideoURL] to set the video url to editor
  ///this method recognises the inserted url and sanitize to make it embeddable url
  ///eg: converts youtube video to embed video, same for vimeo
  void insertVideoURL(String url) async {
    await controller.embedVideo(url);
  }

  /// to set the html text to editor
  /// if index is not set, it will be inserted at the cursor postion
  void insertHtmlText(String text, {int? index}) async {
    await controller.insertText(text, index: index);
  }

  /// to clear the editor
  void clearEditor() => controller.clear();

  /// to enable/disable the editor
  void enableEditor(bool enable) => controller.enableEditor(enable);

  /// method to un focus editor
  void unFocusEditor() => controller.unFocus();
}
