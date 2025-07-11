import 'dart:async';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quill_html_editor_v3/quill_html_editor_v3.dart';
import 'package:quill_html_editor_v3/src/utils/hex_color.dart';
import 'package:quill_html_editor_v3/src/widgets/color_picker.dart';
import 'package:quill_html_editor_v3/src/widgets/image_picker.dart';
import 'package:quill_html_editor_v3/src/widgets/webviewx/src/webviewx_plus.dart';

import 'widgets/el_tooltip/el_tooltip.dart';

///[ToolBar] widget to show the quill toolbar
class ToolBar extends StatefulWidget {
  ///[toolBarConfig] optional list which takes the toolbar button types,
  /// by default, toolbar will show all the buttons,
  /// we can show required buttons by passing them in the list
  final List<ToolBarStyle>? toolBarConfig;

  ///[controller] to access the editor and toolbar methods
  final QuillEditorController controller;

  ///[customButtons] to add custom buttons in the toolbar
  final List<Widget>? customButtons;

  ///[iconSize] to define the toolbar icon size
  final double? iconSize;

  ///[iconColor] to define the toolbar icon color
  final Color? iconColor;

  ///[toolBarColor] to define the toolbar icon color
  final Color? toolBarColor;

  ///[activeIconColor] to define the active toolbar icon color
  final Color? activeIconColor;

  /// [padding] The amount of space by which to inset the toolbar style widgets.
  final EdgeInsetsGeometry? padding;

  ///[borderColor] to define the border color of toolbar icons
  final Color? borderColor;

  ///[borderRadius] to define the border radius of toolbar icon containers
  final double? borderRadius;

  /// [customImageIcon] custom SVG widget for the image toolbar item
  final Widget? customImageIcon;

  /// [customUndoIcon] custom SVG widget for the undo toolbar item
  final Widget? customUndoIcon;

  /// [customRedoIcon] custom SVG widget for the redo toolbar item
  final Widget? customRedoIcon;

  /// [customBoldIcon] custom SVG widget for the bold toolbar item
  final Widget? customBoldIcon;

  /// The direction to use as the main axis.
  ///
  /// For example, if [direction] is [Axis.horizontal], the default, the
  /// children are placed adjacent to one another in a horizontal run until the
  /// available horizontal space is consumed, at which point a subsequent
  /// children are placed in a new run vertically adjacent to the previous run.
  final Axis direction;

  /// How the children within a run should be placed in the main axis.
  ///
  /// For example, if [alignment] is [WrapAlignment.center], the children in
  /// each run are grouped together in the center of their run in the main axis.
  ///
  /// Defaults to [WrapAlignment.start].
  ///
  /// See also:
  ///
  ///  * [runAlignment], which controls how the runs are placed relative to each
  ///    other in the cross axis.
  ///  * [crossAxisAlignment], which controls how the children within each run
  ///    are placed relative to each other in the cross axis.
  final WrapAlignment alignment;

  /// How much space to place between children in a run in the main axis.
  ///
  /// For example, if [spacing] is 10.0, the children will be spaced at least
  /// 10.0 logical pixels apart in the main axis.
  ///
  /// If there is additional free space in a run (e.g., because the wrap has a
  /// minimum size that is not filled or because some runs are longer than
  /// others), the additional free space will be allocated according to the
  /// [alignment].
  ///
  /// Defaults to 0.0.
  final double spacing;

  /// How the runs themselves should be placed in the cross axis.
  ///
  /// For example, if [runAlignment] is [WrapAlignment.center], the runs are
  /// grouped together in the center of the overall [Wrap] in the cross axis.
  ///
  /// Defaults to [WrapAlignment.start].
  ///
  /// See also:
  ///
  ///  * [alignment], which controls how the children within each run are placed
  ///    relative to each other in the main axis.
  ///  * [crossAxisAlignment], which controls how the children within each run
  ///    are placed relative to each other in the cross axis.
  final WrapAlignment runAlignment;

  /// How much space to place between the runs themselves in the cross axis.
  ///
  /// For example, if [runSpacing] is 10.0, the runs will be spaced at least
  /// 10.0 logical pixels apart in the cross axis.
  ///
  /// If there is additional free space in the overall [Wrap] (e.g., because
  /// the wrap has a minimum size that is not filled), the additional free space
  /// will be allocated according to the [runAlignment].
  ///
  /// Defaults to 0.0.
  final double runSpacing;

  /// How the children within a run should be aligned relative to each other in
  /// the cross axis.
  ///
  /// For example, if this is set to [WrapCrossAlignment.end], and the
  /// [direction] is [Axis.horizontal], then the children within each
  /// run will have their bottom edges aligned to the bottom edge of the run.
  ///
  /// Defaults to [WrapCrossAlignment.start].
  ///
  /// See also:
  ///
  ///  * [alignment], which controls how the children within each run are placed
  ///    relative to each other in the main axis.
  ///  * [runAlignment], which controls how the runs are placed relative to each
  ///    other in the cross axis.
  final dynamic crossAxisAlignment;

  /// Determines the order to lay children out horizontally and how to interpret
  /// `start` and `end` in the horizontal direction.
  ///
  /// Defaults to the ambient [Directionality].
  ///
  /// If the [direction] is [Axis.horizontal], this controls order in which the
  /// children are positioned (left-to-right or right-to-left), and the meaning
  /// of the [alignment] property's [WrapAlignment.start] and
  /// [WrapAlignment.end] values.
  ///
  /// If the [direction] is [Axis.horizontal], and either the
  /// [alignment] is either [WrapAlignment.start] or [WrapAlignment.end], or
  /// there's more than one child, then the [textDirection] (or the ambient
  /// [Directionality]) must not be null.
  ///
  /// If the [direction] is [Axis.vertical], this controls the order in which
  /// runs are positioned, the meaning of the [runAlignment] property's
  /// [WrapAlignment.start] and [WrapAlignment.end] values, as well as the
  /// [crossAxisAlignment] property's [WrapCrossAlignment.start] and
  /// [WrapCrossAlignment.end] values.
  ///
  /// If the [direction] is [Axis.vertical], and either the
  /// [runAlignment] is either [WrapAlignment.start] or [WrapAlignment.end], the
  /// [crossAxisAlignment] is either [WrapCrossAlignment.start] or
  /// [WrapCrossAlignment.end], or there's more than one child, then the
  /// [textDirection] (or the ambient [Directionality]) must not be null.
  final TextDirection? textDirection;

  /// Determines the order to lay children out vertically and how to interpret
  /// `start` and `end` in the vertical direction.
  ///
  /// If the [direction] is [Axis.vertical], this controls which order children
  /// are painted in (down or up), the meaning of the [alignment] property's
  /// [WrapAlignment.start] and [WrapAlignment.end] values.
  ///
  /// If the [direction] is [Axis.vertical], and either the [alignment]
  /// is either [WrapAlignment.start] or [WrapAlignment.end], or there's
  /// more than one child, then the [verticalDirection] must not be null.
  ///
  /// If the [direction] is [Axis.horizontal], this controls the order in which
  /// runs are positioned, the meaning of the [runAlignment] property's
  /// [WrapAlignment.start] and [WrapAlignment.end] values, as well as the
  /// [crossAxisAlignment] property's [WrapCrossAlignment.start] and
  /// [WrapCrossAlignment.end] values.
  ///
  /// If the [direction] is [Axis.horizontal], and either the
  /// [runAlignment] is either [WrapAlignment.start] or [WrapAlignment.end], the
  /// [crossAxisAlignment] is either [WrapCrossAlignment.start] or
  /// [WrapCrossAlignment.end], or there's more than one child, then the
  /// [verticalDirection] must not be null.
  final VerticalDirection verticalDirection;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  /// How the children should be placed along the main axis.
  ///
  /// For example, [MainAxisAlignment.start], the default, places the children
  /// at the start (i.e., the left for a [Row] or the top for a [Column]) of the
  /// main axis.
  final MainAxisAlignment? mainAxisAlignment;

  /// How much space should be occupied in the main axis.
  ///
  /// After allocating space to children, there might be some remaining free
  /// space. This value controls whether to maximize or minimize the amount of
  /// free space, subject to the incoming layout constraints.
  ///
  /// If some children have a non-zero flex factors (and none have a fit of
  /// [FlexFit.loose]), they will expand to consume all the available space and
  /// there will be no remaining free space to maximize or minimize, making this
  /// value irrelevant to the final layout.
  final MainAxisSize? mainAxisSize;

  /// Determines the order to lay children out horizontally and how to interpret
  /// `start` and `end` in the horizontal direction.
  ///
  /// Defaults to the ambient [Directionality].
  ///
  /// If [textDirection] is [TextDirection.rtl], then the direction in which
  /// text flows starts from right to left. Otherwise, if [textDirection] is
  /// [TextDirection.ltr], then the direction in which text flows starts from
  /// left to right.
  ///
  /// If the [direction] is [Axis.horizontal], this controls the order in which
  /// the children are positioned (left-to-right or right-to-left), and the
  /// meaning of the [mainAxisAlignment] property's [MainAxisAlignment.start] and
  /// [MainAxisAlignment.end] values.
  ///
  /// If the [direction] is [Axis.horizontal], and either the
  /// [mainAxisAlignment] is either [MainAxisAlignment.start] or
  /// [MainAxisAlignment.end], or there's more than one child, then the
  /// [textDirection] (or the ambient [`Directionality]) must not be null.
  ///
  /// If the [direction] is [Axis.vertical], this controls the meaning of the
  /// [crossAxisAlignment] property's [CrossAxisAlignment.start] and
  /// [CrossAxisAlignment.end] values.
  ///
  /// Determines the order to lay children out vertically and how to interpret
  /// `start` and `end` in the vertical direction.
  ///
  /// Defaults to [VerticalDirection.down].
  ///
  /// If the [direction] is [Axis.vertical], this controls which order children
  /// are painted in (down or up), the meaning of the [mainAxisAlignment]
  /// property's [MainAxisAlignment.start] and [MainAxisAlignment.end] values.
  ///
  /// If the [direction] is [Axis.vertical], and either the [mainAxisAlignment]
  /// is either [MainAxisAlignment.start] or [MainAxisAlignment.end], or there's
  /// more than one child, then the [verticalDirection] must not be null.
  ///
  /// If the [direction] is [Axis.horizontal], this controls the meaning of the
  /// [crossAxisAlignment] property's [CrossAxisAlignment.start] and
  /// [CrossAxisAlignment.end] values.
  ///
  /// If aligning items according to their baseline, which baseline to use.
  ///
  /// This must be set if using baseline alignment. There is no default because there is no
  /// way for the framework to know the correct baseline _a priori_.
  final TextBaseline? textBaseline;

  ///[ToolBar] widget to show the quill
  /// The toolbar items will be auto aligned based on the screen's width or height
  /// The behaviour of the widget's alignment is similar to [Wrap] widget

  ToolBar({
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.spacing = 0.0,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0.0,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
    this.toolBarConfig,
    required this.controller,
    this.customButtons,
    this.padding,
    this.iconSize = 25,
    this.iconColor = Colors.black,
    this.activeIconColor = Colors.blue,
    this.toolBarColor = Colors.white,
    this.borderColor = const Color(0xFFE4E4E7),
    this.borderRadius = 8.0,
    this.customImageIcon,
    this.customUndoIcon,
    this.customRedoIcon,
    this.customBoldIcon,
    this.mainAxisSize,
  })  : assert(crossAxisAlignment is WrapCrossAlignment,
            "Please pass WrapCrossAlignment, instead of CrossAxisAlignment"),
        mainAxisAlignment = MainAxisAlignment.start,
        textBaseline = TextBaseline.alphabetic,
        super(
          key: controller.toolBarKey,
        );

  ///[ToolBar.scroll] shows the widget in a single row/column
  ///Please define the [direction], to make it a row or a column
  ///the direction defaults to [Axis.horizontal]

  ToolBar.scroll({
    this.direction = Axis.horizontal,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
    this.toolBarConfig,
    required this.controller,
    this.customButtons,
    this.padding,
    this.iconSize = 25,
    this.iconColor = Colors.black,
    this.activeIconColor = Colors.blue,
    this.toolBarColor = Colors.white,
    this.borderColor = const Color(0xFFE4E4E7),
    this.borderRadius = 8.0,
    this.customImageIcon,
    this.customUndoIcon,
    this.customRedoIcon,
    this.customBoldIcon,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.textBaseline = TextBaseline.alphabetic,
  })  : assert(crossAxisAlignment is CrossAxisAlignment,
            "Please pass CrossAxisAlignment, instead of WrapCrossAlignment"),
        spacing = 0.0,
        runSpacing = 0.0,
        alignment = WrapAlignment.start,
        runAlignment = WrapAlignment.start,
        super(
          key: controller.toolBarKey,
        );
  @override
  State<ToolBar> createState() => ToolBarState();
}

///[ToolBarState] state object to access the apis of toolbar
class ToolBarState extends State<ToolBar> {
  List<ToolBarItem> _toolbarList = [];
  Map<String, dynamic> _formatMap = {};
  late GlobalKey<ElTooltipState> _fontColorKey;
  EdgeInsetsGeometry _buttonPadding = const EdgeInsets.all(3);

  // Text format state: 0 = normal, 1 = bold, 2 = italic
  int _textFormatState = 0;

  // Cached color to avoid repeated hex conversions for better performance
  Color? _cachedColor;

  // Timer for debouncing color updates to prevent excessive controller calls
  Timer? _colorUpdateTimer;

  @override
  void initState() {
    _fontColorKey = GlobalKey<ElTooltipState>(
        debugLabel: 'fontColorKey${widget.controller.hashCode.toString()}');

    if (widget.padding != null) {
      _buttonPadding = widget.padding!;
    }
    if (widget.toolBarConfig == null || widget.toolBarConfig!.isEmpty) {
      for (var style in ToolBarStyle.values) {
        _toolbarList.add(ToolBarItem(
          activeIconColor: widget.activeIconColor!,
          iconColor: widget.iconColor!,
          iconSize: widget.iconSize!,
          style: style,
          isActive: false,
          padding: _buttonPadding,
          borderColor: widget.borderColor,
          borderRadius: widget.borderRadius,
          customIcon: _getCustomIconForStyle(style),
          textFormatState: style == ToolBarStyle.bold ? _textFormatState : null,
        ));
      }
    } else {
      for (var style in widget.toolBarConfig!) {
        _toolbarList.add(ToolBarItem(
            activeIconColor: widget.activeIconColor!,
            iconColor: widget.iconColor!,
            iconSize: widget.iconSize!,
            style: style,
            isActive: false,
            padding: _buttonPadding,
            borderColor: widget.borderColor,
            borderRadius: widget.borderRadius,
            customIcon: _getCustomIconForStyle(style),
            textFormatState:
                style == ToolBarStyle.bold ? _textFormatState : null));
      }
    }
    super.initState();
  }

  Widget? _getCustomIconForStyle(ToolBarStyle style) {
    switch (style) {
      case ToolBarStyle.image:
        return widget.customImageIcon;
      case ToolBarStyle.undo:
        return widget.customUndoIcon;
      case ToolBarStyle.redo:
        return widget.customRedoIcon;
      case ToolBarStyle.bold:
        // For bold, we don't use customBoldIcon since we cycle through states
        return null;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (widget._isScrollable!) {
    //   return IgnorePointer(
    //     ignoring: !widget.controller.isEnable,
    //     child: Container(
    //         width: double.maxFinite,

    //         /// margin for the container
    //         margin: const EdgeInsets.only(left: 16, right: 16, bottom: 30),

    //         /// padding for the container
    //         padding: const EdgeInsets.all(8),

    //         /// container decoration
    //         decoration: BoxDecoration(
    //           /// container color
    //           color: Colors.white,
    //           boxShadow: [
    //             BoxShadow(
    //               color: Colors.black.withAlpha(100), // very subtle dark shadow
    //               spreadRadius: 1,
    //               blurRadius: 12,
    //               offset: const Offset(0, 4),
    //             ),
    //             BoxShadow(
    //               color: Colors.white.withAlpha(80), // soft highlight
    //               spreadRadius: -4,
    //               blurRadius: 20,
    //               offset: const Offset(0, -2),
    //             ),
    //           ],
    //           borderRadius: BorderRadius.circular(16),
    //         ),
    //         child: Row(
    //           children: _generateToolBar(context),
    //         )
    //         // Flex(
    //         //   direction: widget.direction,
    //         //   crossAxisAlignment: CrossAxisAlignment.start,
    //         //   textDirection: widget.textDirection,
    //         //   verticalDirection: widget.verticalDirection,
    //         //   clipBehavior: widget.clipBehavior,
    //         //   children: ,
    //         // ),
    //         ),
    //   );
    // }
    return IgnorePointer(
      ignoring: !widget.controller.isEnable,
      child: Container(
          width: double.maxFinite,

          /// margin for the container
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 30),

          /// padding for the container
          padding: const EdgeInsets.all(8),

          /// container decoration
          decoration: BoxDecoration(
            /// container color
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(100), // very subtle dark shadow
                spreadRadius: 1,
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: Colors.white.withAlpha(80), // soft highlight
                spreadRadius: -4,
                blurRadius: 20,
                offset: const Offset(0, -2),
              ),
            ],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: _generateToolBar(context),
          )
          // Flex(
          //   direction: widget.direction,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   textDirection: widget.textDirection,
          //   verticalDirection: widget.verticalDirection,
          //   clipBehavior: widget.clipBehavior,
          //   children: ,
          // ),
          ),
    );
  }

  @override
  void dispose() {
    _colorUpdateTimer?.cancel();
    super.dispose();
  }

  ///[updateToolBarFormat] method to update the toolbar state in sync with editor formats
  void updateToolBarFormat(Map<String, dynamic> formatMap) {
    _formatMap = formatMap;
    for (int i = 0; i < _toolbarList.length; i++) {
      switch (_toolbarList[i].style) {
        case ToolBarStyle.bold:
          _toolbarList[i] =
              _toolbarList[i].copyWith(isActive: formatMap['bold'] == true);
          break;
        // case ToolBarStyle.italic:
        //   _toolbarList[i] =
        //       _toolbarList[i].copyWith(isActive: formatMap['italic'] == true);
        //   break;
        // case ToolBarStyle.underline:
        //   _toolbarList[i] = _toolbarList[i]
        //       .copyWith(isActive: formatMap['underline'] == true);
        //   break;
        // case ToolBarStyle.strike:
        //   _toolbarList[i] =
        //       _toolbarList[i].copyWith(isActive: formatMap['strike'] == true);
        //   break;
        // case ToolBarStyle.blockQuote:
        //   _toolbarList[i] = _toolbarList[i]
        //       .copyWith(isActive: formatMap['blockquote'] == true);
        //   break;
        // case ToolBarStyle.codeBlock:
        //   _toolbarList[i] = _toolbarList[i]
        //       .copyWith(isActive: formatMap['code-block'] == true);
        //   break;
        // case ToolBarStyle.indentMinus:
        //   _toolbarList[i] =
        //       _toolbarList[i].copyWith(isActive: formatMap['indent'] != null);
        //   break;
        // case ToolBarStyle.indentAdd:
        //   _toolbarList[i] =
        //       _toolbarList[i].copyWith(isActive: formatMap['indent'] != null);
        //   break;
        // case ToolBarStyle.directionRtl:
        //   _toolbarList[i] = _toolbarList[i]
        //       .copyWith(isActive: formatMap['direction'] == 'rtl');
        //   break;
        // case ToolBarStyle.directionLtr:
        //   _toolbarList[i] = _toolbarList[i]
        //       .copyWith(isActive: formatMap['direction'] != 'rtl');
        //   break;
        case ToolBarStyle.size:
          _toolbarList[i] =
              _toolbarList[i].copyWith(isActive: formatMap['size'] != null);
          break;
        // case ToolBarStyle.headerOne:
        //   _toolbarList[i] =
        //       _toolbarList[i].copyWith(isActive: formatMap['header'] == 1);
        //   break;
        // case ToolBarStyle.headerTwo:
        //   _toolbarList[i] =
        //       _toolbarList[i].copyWith(isActive: formatMap['header'] == 2);
        //   break;
        case ToolBarStyle.color:
          _toolbarList[i] =
              _toolbarList[i].copyWith(isActive: formatMap['color'] != null);
          try {
            if (formatMap['color'] != null) {
              if (formatMap['color'].runtimeType.toString() ==
                  'List<dynamic>') {
                _formatMap['color'] = formatMap['color'][0];
              } else {
                _formatMap['color'] = formatMap['color'];
              }
              // Cache the color for better performance
              _cachedColor = HexColor.fromHex(_formatMap['color']);
            } else {
              _cachedColor = null;
            }
          } catch (e) {
            if (!kReleaseMode) {
              debugPrint(e.toString());
            }
            _cachedColor = null;
          }
          break;
        // case ToolBarStyle.align:
        //   formatMap['align'] ??= '';
        //   _toolbarList[i] =
        //       _toolbarList[i].copyWith(isActive: formatMap['align'] != null);
        //   break;
        // case ToolBarStyle.listOrdered:
        //   _toolbarList[i] = _toolbarList[i]
        //       .copyWith(isActive: formatMap['list'] == 'ordered');
        //   break;
        // case ToolBarStyle.listBullet:
        //   _toolbarList[i] =
        //       _toolbarList[i].copyWith(isActive: formatMap['list'] == 'bullet');
        //   break;
        case ToolBarStyle.image:
          _toolbarList[i] =
              _toolbarList[i].copyWith(isActive: formatMap['image'] != null);
          break;
        // case ToolBarStyle.video:
        //   _toolbarList[i] =
        //       _toolbarList[i].copyWith(isActive: formatMap['video'] != null);
        //   break;
        // case ToolBarStyle.clean:
        //   _toolbarList[i] =
        //       _toolbarList[i].copyWith(isActive: formatMap['clean'] != null);
        //   break;
        // case ToolBarStyle.background:
        //   _toolbarList[i] = _toolbarList[i]
        //       .copyWith(isActive: formatMap['background'] != null);
        //   try {
        //     if (formatMap['background'] != null) {
        //       if (formatMap['background'].runtimeType.toString() ==
        //           'List<dynamic>') {
        //         _formatMap['background'] = formatMap['background'][0];
        //       } else {
        //         _formatMap['background'] = formatMap['background'];
        //       }
        //     }
        //   } catch (e) {
        //     if (!kReleaseMode) {
        //       debugPrint(e.toString());
        //     }
        //   }
        //   break;
        // case ToolBarStyle.link:
        //   _formatMap['link'] = formatMap['link'];
        //   break;
        case ToolBarStyle.undo:
        case ToolBarStyle.redo:
          // case ToolBarStyle.editTable:
          // case ToolBarStyle.addTable:
          // case ToolBarStyle.clearHistory:
          // case ToolBarStyle.separator:
          break;
        default:
          // Handle all other toolbar styles that are not explicitly handled
          break;
      }
    }
    setState(() {});
  }

  List<Widget> _generateToolBar(BuildContext context) {
    List<Widget> tempToolBarList = [];

    for (int i = 0; i < _toolbarList.length; i++) {
      var toolbarItem = _toolbarList[i];
      if (toolbarItem.style == ToolBarStyle.size) {
        tempToolBarList.add(Tooltip(
            waitDuration: const Duration(milliseconds: 800),
            message: toolbarItem.style.name,
            child: SizedBox(height: 44, child: _fontSizeDD())));
      }
      // else if (toolbarItem.style == ToolBarStyle.align) {
      //   tempToolBarList.add(Tooltip(
      //       waitDuration: const Duration(milliseconds: 800),
      //       message: toolbarItem.style.name,
      //       child: Padding(
      //         padding: _buttonPadding,
      //         child: SizedBox(
      //             width: widget.iconSize,
      //             height: widget.iconSize,
      //             child: _alignDD()),
      //       )));
      // }
      else if (toolbarItem.style == ToolBarStyle.color) {
        tempToolBarList.add(Tooltip(
            waitDuration: const Duration(milliseconds: 800),
            message: toolbarItem.style.name,
            child: _getFontColorWidget(i)));
      }
      // else if (toolbarItem.style == ToolBarStyle.video) {
      //   tempToolBarList.add(Tooltip(
      //       waitDuration: const Duration(milliseconds: 800),
      //       message: toolbarItem.style.name,
      //       child: Padding(
      //         padding: _buttonPadding,
      //         child: InputUrlWidget(
      //           iconWidget: SizedBox(
      //             width: widget.iconSize! - 2,
      //             height: widget.iconSize! - 2,
      //             child: Image.asset(
      //               ImageConstant.kiCameraRollPng,
      //               color: widget.iconColor,
      //             ),
      //           ),
      //           isActive: _formatMap['video'] != null,
      //           controller: widget.controller,
      //           type: UrlInputType.video,
      //           onSubmit: (v) {
      //             widget.controller.embedVideo(v);
      //           },
      //         ),
      //       )));
      // }
      //  else if (toolbarItem.style == ToolBarStyle.link) {
      //   tempToolBarList.add(Tooltip(
      //       waitDuration: const Duration(milliseconds: 800),
      //       message: toolbarItem.style.name,
      //       child: Padding(
      //         padding: _buttonPadding,
      //         child: InputUrlWidget(
      //           iconWidget: Icon(
      //             Icons.link,
      //             color: widget.iconColor,
      //             size: widget.iconSize,
      //           ),
      //           isActive: _formatMap['link'] != null,
      //           controller: widget.controller,
      //           type: UrlInputType.hyperlink,
      //           onSubmit: (v) {
      //             widget.controller.setFormat(format: 'link', value: v);
      //           },
      //         ),
      //       )));
      // }
      // else if (toolbarItem.style == ToolBarStyle.background) {
      //   tempToolBarList.add(Tooltip(
      //       waitDuration: const Duration(milliseconds: 800),
      //       message: toolbarItem.style.name,
      //       child: Padding(
      //         padding: _buttonPadding,
      //         child: SizedBox(
      //             width: widget.iconSize,
      //             height: widget.iconSize,
      //             child: _getFontBackgroundColorWidget(i)),
      //       )));
      // }
      // else if (toolbarItem.style == ToolBarStyle.addTable) {
      //   tempToolBarList.add(Tooltip(
      //       waitDuration: const Duration(milliseconds: 800),
      //       message: toolbarItem.style.name,
      //       child: Padding(
      //         padding: _buttonPadding,
      //         child: SizedBox(
      //             width: widget.iconSize,
      //             height: widget.iconSize,
      //             child: _getTablePickerWidget(i, context)),
      //       )));
      // }
      // else if (toolbarItem.style == ToolBarStyle.editTable) {
      //   tempToolBarList.add(Tooltip(
      //       waitDuration: const Duration(milliseconds: 800),
      //       message: toolbarItem.style.name,
      //       child: EditTableDropDown(
      //         padding: _buttonPadding,
      //         iconColor: widget.iconColor!,
      //         iconSize: widget.iconSize!,
      //         dropDownColor: widget.toolBarColor!,
      //         onOptionSelected: (type) => widget.controller.modifyTable(type),
      //       )));
      // }
      // else if (toolbarItem.style == ToolBarStyle.separator) {
      //   if (widget.direction == Axis.horizontal) {
      //     tempToolBarList.add(Tooltip(
      //         waitDuration: const Duration(milliseconds: 800),
      //         message: toolbarItem.style.name,
      //         child: Padding(
      //           padding: _buttonPadding,
      //           child: Container(
      //             height: widget.iconSize,
      //             width: 0.8,
      //             color: widget.iconColor,
      //           ),
      //         )));
      //   } else {
      //     tempToolBarList.add(Tooltip(
      //         waitDuration: const Duration(milliseconds: 800),
      //         message: toolbarItem.style.name,
      //         child: Padding(
      //           padding: _buttonPadding,
      //           child: Container(
      //             width: widget.iconSize,
      //             height: 0.8,
      //             color: widget.iconColor,
      //           ),
      //         )));
      //   }
      // }
      else {
        tempToolBarList.add(ToolBarItem(
          activeIconColor: widget.activeIconColor!,
          iconColor: widget.iconColor!,
          iconSize: widget.iconSize!,
          padding: _buttonPadding,
          style: toolbarItem.style,
          isActive: toolbarItem.isActive,
          borderColor: widget.borderColor,
          borderRadius: widget.borderRadius,
          customIcon: _getCustomIconForStyle(toolbarItem.style),
          textFormatState:
              toolbarItem.style == ToolBarStyle.bold ? _textFormatState : null,
          onTap: () async {
            // if (toolbarItem.style == ToolBarStyle.clearHistory) {
            //   widget.controller.clearHistory();
            // }
            // else
            if (toolbarItem.style == ToolBarStyle.undo) {
              widget.controller.undo();
            } else if (toolbarItem.style == ToolBarStyle.redo) {
              widget.controller.redo();
            } else if (toolbarItem.style == ToolBarStyle.image) {
              await ImageSelector(onImagePicked: (value) async {
                _formatMap['image'] = value;
                await widget.controller.embedImage(value);
                // Ensure cursor moves to next line after image insertion
                await widget.controller.insertText('\n');
              }).pickFiles();
            } else if (toolbarItem.style == ToolBarStyle.bold) {
              // Handle cycling text format: normal -> bold -> italic -> normal
              _textFormatState = (_textFormatState + 1) % 3;

              // Clear all text formatting first
              widget.controller.setFormat(format: 'bold', value: false);
              widget.controller.setFormat(format: 'italic', value: false);

              // Apply the new format based on state
              switch (_textFormatState) {
                case 0: // normal
                  // Already cleared above
                  break;
                case 1: // bold
                  widget.controller.setFormat(format: 'bold', value: true);
                  break;
                case 2: // italic
                  widget.controller.setFormat(format: 'italic', value: true);
                  break;
              }

              // Update the toolbar item with new state
              for (int j = 0; j < _toolbarList.length; j++) {
                if (_toolbarList[j].style == ToolBarStyle.bold) {
                  _toolbarList[j] = _toolbarList[j].copyWith(
                    isActive: _textFormatState != 0,
                    textFormatState: _textFormatState,
                  );
                  break;
                }
              }

              setState(() {});
              return; // Early return to avoid the general format logic below
            } else if (toolbarItem.style == ToolBarStyle.clean) {
              List<ToolBarItem> tempList = [];
              for (var value in _toolbarList) {
                value = value.copyWith(isActive: false);
                tempList.add(value);
              }
              _toolbarList = tempList;
              // } else if (toolbarItem.style == ToolBarStyle.headerOne) {
              //   for (var element in _toolbarList) {
              //     if (element.style == ToolBarStyle.headerTwo) {
              //       element = element.copyWith(isActive: false);
              //     }
              //   }
              //   toolbarItem =
              //       toolbarItem.copyWith(isActive: !toolbarItem.isActive);
              // } else if (toolbarItem.style == ToolBarStyle.headerTwo) {
              //   for (var element in _toolbarList) {
              //     if (element.style == ToolBarStyle.headerOne) {
              //       element = element.copyWith(isActive: false);
              //     }
              //   }
              //   toolbarItem =
              //       toolbarItem.copyWith(isActive: !toolbarItem.isActive);
            } else {
              toolbarItem =
                  toolbarItem.copyWith(isActive: !toolbarItem.isActive);
            }
            Map<String, dynamic> getFormat =
                _getFormatByStyle(toolbarItem.style, toolbarItem.isActive);
            widget.controller.setFormat(
                format: getFormat['format'], value: getFormat['value']);

            if (_formatMap['direction'] == 'rtl') {
              widget.controller.setFormat(format: 'align', value: 'right');
            }
            setState(() {});
          },
        ));
      }
    }
    if (widget.customButtons != null && widget.customButtons!.isNotEmpty) {
      for (var element in widget.customButtons!) {
        tempToolBarList.add(Padding(
          padding: _buttonPadding,
          child: element,
        ));
      }
    }
    return tempToolBarList;
  }

  Map<String, dynamic> _getFormatByStyle(ToolBarStyle style, bool isActive) {
    switch (style) {
      case ToolBarStyle.bold:
        return {'format': 'bold', 'value': isActive};
      case ToolBarStyle.italic:
        return {'format': 'italic', 'value': isActive};
      case ToolBarStyle.underline:
        return {'format': 'underline', 'value': isActive};
      case ToolBarStyle.strike:
        return {'format': 'strike', 'value': isActive};
      case ToolBarStyle.blockQuote:
        return {'format': 'blockquote', 'value': isActive};
      case ToolBarStyle.codeBlock:
        return {'format': 'code-block', 'value': isActive};
      case ToolBarStyle.indentAdd:
        return {'format': 'indent', 'value': '+1'};
      case ToolBarStyle.indentMinus:
        return {'format': 'indent', 'value': '-1'};
      case ToolBarStyle.directionRtl:
        return {'format': 'direction', 'value': 'rtl'};
      case ToolBarStyle.directionLtr:
        return {'format': 'direction', 'value': ''};
      case ToolBarStyle.size:
        return {'format': 'size', 'value': 'small'};
      case ToolBarStyle.color:
        return {'format': 'color', 'value': 'red'};
      case ToolBarStyle.align:
        return {'format': 'align', 'value': 'right'};
      case ToolBarStyle.listOrdered:
        return {'format': 'list', 'value': isActive ? 'ordered' : ''};
      case ToolBarStyle.listBullet:
        return {'format': 'list', 'value': isActive ? 'bullet' : ''};
      case ToolBarStyle.image:
        return {'format': 'image', 'value': ''};
      case ToolBarStyle.video:
        return {'format': 'video', 'value': ''};
      case ToolBarStyle.clean:
        return {'format': 'clean', 'value': ''};
      case ToolBarStyle.headerOne:
        return {'format': 'header', 'value': isActive ? 1 : 4};
      case ToolBarStyle.headerTwo:
        return {'format': 'header', 'value': isActive ? 2 : 4};
      case ToolBarStyle.background:
        return {'format': 'background', 'value': 'red'};
      case ToolBarStyle.link:
        return {'format': 'link', 'value': ''};
      case ToolBarStyle.undo:
      case ToolBarStyle.redo:
      case ToolBarStyle.clearHistory:
      case ToolBarStyle.editTable:
      case ToolBarStyle.addTable:
      case ToolBarStyle.separator:
        return {'format': 'undo', 'value': ''};
    }
  }

  Widget _fontSizeDD() {
    return Container(
      margin: const EdgeInsets.only(left: 4, right: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border:
            Border.all(color: widget.borderColor ?? const Color(0xFFE4E4E7)),
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: widget.toolBarColor,
          alignment: Alignment.centerLeft,
          selectedItemBuilder: (context) {
            return [
              _fontSizeDisplayItem(size: '10'),
              _fontSizeDisplayItem(size: '12'),
              _fontSizeDisplayItem(size: '14'),
              _fontSizeDisplayItem(size: '16'),
              _fontSizeDisplayItem(size: '18'),
              _fontSizeDisplayItem(size: '20'),
              _fontSizeDisplayItem(size: '24'),
            ];
          },
          isDense: true,
          value: _getSizeValue(),
          style: TextStyle(fontSize: 12, color: widget.iconColor!),
          items: [
            _fontSizeNumberItem(size: '10', value: 'small'),
            _fontSizeNumberItem(size: '12', value: 'normal'),
            _fontSizeNumberItem(size: '14', value: 'medium'),
            _fontSizeNumberItem(size: '16', value: 'large'),
            _fontSizeNumberItem(size: '18', value: 'x-large'),
            _fontSizeNumberItem(size: '20', value: 'xx-large'),
            _fontSizeNumberItem(size: '24', value: 'huge'),
          ],
          onChanged: (value) {
            _formatMap['size'] = value;
            widget.controller.setFormat(
                format: 'size', value: value == 'normal' ? '' : value);
            setState(() {});
          },
        ),
      ),
    );
  }

  // Helper method to get the current size value for dropdown
  String _getSizeValue() {
    String? currentSize = _formatMap['size'];
    if (currentSize == null || currentSize == '') return 'normal';

    // Map format values to our dropdown values
    switch (currentSize) {
      case 'small':
        return 'small';
      case 'medium':
        return 'medium';
      case 'large':
        return 'large';
      case 'x-large':
        return 'x-large';
      case 'xx-large':
        return 'xx-large';
      case 'huge':
        return 'huge';
      default:
        return 'normal';
    }
  }

  // Helper method to create dropdown items that display font size numbers
  DropdownMenuItem<String> _fontSizeNumberItem(
      {required String size, required String value}) {
    return DropdownMenuItem<String>(
      value: value,
      child: WebViewAware(
        child: Text(
          size,
          style: TextStyle(
            fontSize: double.parse(size),
            color: _formatMap['size'] == value
                ? widget.activeIconColor
                : widget.iconColor!,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Helper method to create display items for selected value
  Widget _fontSizeDisplayItem({required String size}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        size,
        style: TextStyle(
          fontSize: 14,
          color: widget.iconColor!,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _getFontColorWidget(int i) {
    return ElTooltip(
      onTap: () {
        if (_fontColorKey.currentState != null) {
          _fontColorKey.currentState!.showOverlayOnTap();
        }
      },
      key: _fontColorKey,
      content: ColorPicker(
        onColorPicked: (color) {
          // Optimize by batching operations and reducing async gaps
          _formatMap['color'] = color;
          _cachedColor = HexColor.fromHex(color); // Cache the converted color
          _toolbarList[i] = _toolbarList[i].copyWith(isActive: true);

          // Hide overlay first for immediate visual feedback
          if (_fontColorKey.currentState != null) {
            _fontColorKey.currentState!.hideOverlay();
          }

          // Cancel previous timer if still running
          _colorUpdateTimer?.cancel();

          // Debounce the controller update to avoid excessive calls
          _colorUpdateTimer = Timer(const Duration(milliseconds: 50), () {
            widget.controller.setFormat(format: 'color', value: color);
          });

          // Update UI immediately
          if (mounted) setState(() {});
        },
      ),
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            // border: Border.all(width: 0.1),
            border: Border.all(color: widget.borderColor!),
            color:
                //  _formatMap['color'] != null
                //     ? HexColor.fromHex(_formatMap['color'])
                //     :
                Colors.transparent,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'A',
                maxLines: 1,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 14),
              ),
              Container(
                color: _cachedColor ??
                    (_formatMap['color'] != null
                        ? HexColor.fromHex(_formatMap['color'])
                        : Colors.black),
                height: 3,
                width: widget.iconSize! - 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///[ToolBarItem] toolbaritem widget to show buttons based on style
@immutable
class ToolBarItem extends StatelessWidget {
  ///[style] to set the toolbar buttons by styles
  final ToolBarStyle style;

  ///[isActive] to highlight the toolbar buttons when active
  final bool isActive;

  ///[onTap] callback to set format on tap
  final GestureTapCallback? onTap;

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry padding;

  ///[iconSize] to define the toolbar icon size
  final double iconSize;

  ///[iconColor] to define the toolbar icon color
  final Color iconColor;

  ///[activeIconColor] to define the active toolbar icon color
  final Color? activeIconColor;

  ///[borderColor] to define the border color of toolbar icons
  final Color? borderColor;

  ///[borderRadius] to define the border radius of toolbar icon containers
  final double? borderRadius;

  ///[customIcon] custom widget (like SVG) to use instead of default icon
  final Widget? customIcon;

  ///[textFormatState] current text format state for bold button (0=normal, 1=bold, 2=italic)
  final int? textFormatState;

  ///[ToolBarItem] toolbaritem widget to show buttons based on style
  const ToolBarItem({
    super.key,
    required this.style,
    required this.isActive,
    this.padding = const EdgeInsets.all(10),
    required this.iconSize,
    required this.iconColor,
    required this.activeIconColor,
    this.borderColor = const Color(0xFFE4E4E7),
    this.borderRadius = 8.0,
    this.customIcon,
    this.textFormatState,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 6,
        ),
        child: SizedBox(height: 44, width: 43.5, child: _getIconByStyle(style)),
      ),
    );
  }

  Widget _getIconByStyle(ToolBarStyle style) {
    switch (style) {
      case ToolBarStyle.bold:
        // Show different icons based on text format state
        if (textFormatState != null) {
          switch (textFormatState!) {
            case 0: // normal - show custom SVG
              return _getCustomIconWidget(_buildNormalTextSvg());
            case 1: // bold
              return _getIconDataWidget(Icons.format_bold_sharp);
            case 2: // italic
              return _getIconDataWidget(Icons.format_italic_sharp);
            default:
              return _getCustomIconWidget(_buildNormalTextSvg());
          }
        }
        // If no textFormatState, show normal icon
        return _getCustomIconWidget(_buildNormalTextSvg());
      case ToolBarStyle.italic:
        return _getIconDataWidget(Icons.format_italic_sharp);
      case ToolBarStyle.underline:
        return _getIconDataWidget(Icons.format_underline_sharp);
      case ToolBarStyle.strike:
        return _getIconDataWidget(Icons.format_strikethrough_sharp);
      case ToolBarStyle.blockQuote:
        return _getIconDataWidget(Icons.format_quote_sharp);
      case ToolBarStyle.codeBlock:
        return _getIconDataWidget(Icons.code_sharp);
      case ToolBarStyle.indentAdd:
        return _getIconDataWidget(Icons.format_indent_increase_sharp);
      case ToolBarStyle.indentMinus:
        return _getIconDataWidget(Icons.format_indent_decrease_sharp);
      case ToolBarStyle.directionRtl:
        return _getIconDataWidget(Icons.format_textdirection_r_to_l_sharp);
      case ToolBarStyle.directionLtr:
        return _getIconDataWidget(Icons.format_textdirection_l_to_r_sharp);
      case ToolBarStyle.color:
        return _getIconDataWidget(Icons.palette_outlined);
      case ToolBarStyle.image:
        // If a custom icon is provided, use it instead of the default
        if (customIcon != null) {
          return _getCustomIconWidget(customIcon!);
        }
        return _getIconDataWidget(Icons.image);
      case ToolBarStyle.undo:
        // If a custom icon is provided, use it instead of the default
        if (customIcon != null) {
          return _getCustomIconWidget(customIcon!);
        }
        return _getIconDataWidget(Icons.undo_sharp);
      case ToolBarStyle.redo:
        // If a custom icon is provided, use it instead of the default
        if (customIcon != null) {
          return _getCustomIconWidget(customIcon!);
        }
        return _getIconDataWidget(Icons.redo_sharp);
      case ToolBarStyle.headerOne:
        return _getIconDataWidget(Icons.looks_one_sharp);
      case ToolBarStyle.headerTwo:
        return _getIconDataWidget(Icons.looks_two_sharp);
      case ToolBarStyle.background:
        return _getIconDataWidget(Icons.format_color_fill_sharp);
      case ToolBarStyle.align:
        return _getIconDataWidget(Icons.format_align_left_sharp);
      case ToolBarStyle.listOrdered:
        return _getIconDataWidget(Icons.format_list_numbered_sharp);
      case ToolBarStyle.listBullet:
        return _getIconDataWidget(Icons.format_list_bulleted_sharp);
      case ToolBarStyle.size:
        return _getIconDataWidget(Icons.format_size_sharp);
      case ToolBarStyle.link:
        return _getIconDataWidget(Icons.link_sharp);
      case ToolBarStyle.video:
        return _getIconDataWidget(Icons.video_library_sharp);
      case ToolBarStyle.clean:
        return _getIconDataWidget(Icons.format_clear_sharp);
      case ToolBarStyle.clearHistory:
        return _getIconDataWidget(Icons.clear_all_sharp);
      case ToolBarStyle.addTable:
        return _getIconDataWidget(Icons.table_chart_sharp);
      case ToolBarStyle.editTable:
        return _getIconDataWidget(Icons.edit_sharp);
      case ToolBarStyle.separator:
        return Container(
          height: 30,
          width: 1,
          color: Colors.grey.shade300,
        );
      default:
        return _getIconDataWidget(Icons.help);
    }
  }

  Widget _getIconDataWidget(IconData iconData) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? const Color(0xFFE4E4E7)),
          borderRadius: _getBorderRadius(),
        ),
        child: Icon(
          iconData,
          color: style == ToolBarStyle.bold
              ? Colors.black
              : (isActive ? activeIconColor : iconColor),
        ),
      );

  Widget _getCustomIconWidget(Widget customIcon) => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor ?? const Color(0xFFE4E4E7)),
          borderRadius: _getBorderRadius(),
        ),
        child: customIcon,
      );

  BorderRadius _getBorderRadius() {
    // Special icons with different border radius values
    if (style == ToolBarStyle.image) {
      return const BorderRadius.only(
        topLeft: Radius.circular(12.0),
        bottomLeft: Radius.circular(12.0),
        topRight: Radius.circular(4.0),
        bottomRight: Radius.circular(4.0),
      );
    } else if (style == ToolBarStyle.redo) {
      return const BorderRadius.only(
        topLeft: Radius.circular(4.0),
        bottomLeft: Radius.circular(4.0),
        topRight: Radius.circular(12.0),
        bottomRight: Radius.circular(12.0),
      );
    } else if (style == ToolBarStyle.undo) {
      return BorderRadius.circular(4.0);
    }
    // All other icons use borderRadius 2
    return BorderRadius.circular(2.0);
  }

  ///toolbar item copyWith function
  ToolBarItem copyWith({
    bool? isActive,
    Widget? customIcon,
    int? textFormatState,
  }) {
    return ToolBarItem(
        style: style,
        isActive: isActive ?? this.isActive,
        padding: padding,
        iconSize: iconSize,
        iconColor: iconColor,
        activeIconColor: activeIconColor,
        borderColor: borderColor,
        borderRadius: borderRadius,
        customIcon: customIcon ?? this.customIcon,
        textFormatState: textFormatState ?? this.textFormatState);
  }

  Widget _buildNormalTextSvg() {
    // For bold button with textFormatState, always use black color
    Color iconColorToUse;
    if (style == ToolBarStyle.bold && textFormatState != null) {
      // Bold button: always use black color regardless of state
      iconColorToUse = Colors.black;
    } else {
      // For other buttons, use the standard active/inactive logic
      iconColorToUse = isActive ? activeIconColor! : Colors.black;
    }

    return SvgPicture.string(
      '<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" viewBox="0 0 25 25" fill="none"><path d="M6.41561 15.0537L5.55786 17.4807C5.50402 17.6255 5.41969 17.7368 5.30486 17.8144C5.19019 17.8919 5.06044 17.9307 4.91561 17.9307C4.66944 17.9307 4.47802 17.8303 4.34136 17.6297C4.20486 17.429 4.18211 17.2159 4.27311 16.9904L7.68486 7.78068C7.73869 7.63585 7.82711 7.5221 7.95011 7.43943C8.07327 7.35676 8.20727 7.31543 8.35211 7.31543H8.88861C9.03344 7.31543 9.16994 7.35676 9.29811 7.43943C9.42627 7.5221 9.51736 7.63585 9.57136 7.78068L13.0116 16.9962C13.1026 17.2217 13.0757 17.4338 12.9309 17.6327C12.786 17.8313 12.5956 17.9307 12.3596 17.9307C12.2148 17.9307 12.0818 17.8878 11.9606 17.8019C11.8394 17.7159 11.7519 17.6005 11.6981 17.4557L10.8559 15.0537H6.41561ZM6.87511 13.7999H10.3906L8.66561 8.91343H8.58461L6.87511 13.7999ZM16.6346 18.1712C15.8231 18.1712 15.1754 17.9483 14.6914 17.5027C14.2074 17.0572 13.9654 16.4851 13.9654 15.7864C13.9654 15.0659 14.2481 14.481 14.8136 14.0317C15.3789 13.5823 16.1052 13.3577 16.9924 13.3577C17.3629 13.3577 17.7314 13.3926 18.0981 13.4624C18.4648 13.5323 18.7847 13.6288 19.0579 13.7519V13.3077C19.0579 12.741 18.8902 12.298 18.5549 11.9787C18.2197 11.6595 17.7527 11.4999 17.1539 11.4999C16.891 11.4999 16.6324 11.5406 16.3779 11.6219C16.1235 11.7034 15.8899 11.8192 15.6771 11.9692C15.5116 12.0973 15.3539 12.1396 15.2039 12.0959C15.0539 12.0524 14.9334 11.9736 14.8424 11.8594C14.7514 11.7454 14.7091 11.616 14.7156 11.4712C14.7219 11.3262 14.8008 11.1998 14.9521 11.0922C15.2661 10.8575 15.6154 10.6841 16.0001 10.5719C16.3848 10.4598 16.7745 10.4037 17.1694 10.4037C18.2232 10.4037 19.0078 10.6617 19.5231 11.1777C20.0384 11.6938 20.2961 12.4679 20.2961 13.4999V17.3192C20.2961 17.491 20.2346 17.6358 20.1116 17.7537C19.9886 17.8717 19.8412 17.9307 19.6694 17.9307C19.4975 17.9307 19.3526 17.8692 19.2346 17.7462C19.1168 17.623 19.0579 17.4755 19.0579 17.3037V16.9577H18.9579C18.6989 17.3602 18.3742 17.663 17.9839 17.8662C17.5934 18.0695 17.1436 18.1712 16.6346 18.1712ZM16.8194 17.0904C17.454 17.0904 17.9883 16.8679 18.4221 16.4229C18.8561 15.9781 19.0731 15.4378 19.0731 14.8019C18.8398 14.6686 18.5526 14.5644 18.2116 14.4894C17.8706 14.4144 17.5354 14.3769 17.2059 14.3769C16.6084 14.3769 16.1372 14.5016 15.7924 14.7509C15.4475 15.0003 15.2751 15.3454 15.2751 15.7864C15.2751 16.1583 15.4196 16.4685 15.7086 16.7172C15.9978 16.966 16.368 17.0904 16.8194 17.0904Z" fill="#162D3A" fill-opacity="0.5"/></svg>',
      width: iconSize,
      height: iconSize,
      colorFilter: ColorFilter.mode(
        iconColorToUse,
        BlendMode.srcIn,
      ),
    );
  }
}

///[ToolBarStyle] an enum with multiple toolbar styles, to define required toolbar styles in custom config

enum ToolBarStyle {
  ///[bold] sets bold format
  bold("Bold"),

  /// [italic] sets italic format

  italic("Italic"),

  /// [underline] sets underline to text

  underline("Underline"),

  /// [strike] makes the selected text strikethrough

  strike("Strikethrough"),

  /// [blockQuote] converts text to quote

  blockQuote("Block Quote"),

  /// [codeBlock] makes selected text code block

  codeBlock("Code Block"),

  /// [indentMinus] decreases the indent by given value

  indentMinus("Decrease the indent"),

  /// [indentAdd] increases the indent by given value

  indentAdd("Increase the indent"),

  /// [directionRtl] sets the direction of text from Right to Left

  directionRtl("Right to Left"),

  /// [directionLtr] sets the direction of text from Left to Right

  directionLtr("Left to Right"),

  /// [headerOne] makes the text H1

  headerOne("Header H1"),

  /// [headerTwo] makes the text H2

  headerTwo("Header H2"),

  /// [color] sets font color

  color("Font color"),

  /// [background] sets background color to text

  background("Background color"),

  /// [align] adds alignment to text, left, right, center, justify

  align("Alignment"),

  /// [listOrdered] adds numbered/alphabets list to the text

  listOrdered("Bullet numbers"),

  /// [listBullet] makes text as bullet points

  listBullet("Bullet points"),

  /// [size] sets fontSize of the text

  size("Font Size"),

  /// [link] sets hyperlink to selected text

  link("Hyperlink"),

  /// [image] embeds image to the editor

  image("Insert image"),

  /// [video] embeds Youtube, Vimeo or other network videos to editor

  video("Insert Youtube/Url"),

  /// [clean] clears all formats of editor, (for internal use case)
  clean("Clears all formats"),

  /// [undo] to undo the editor change
  undo("Undo"),

  /// [redo] to redo the editor change
  redo("Redo"),

  /// [clearHistory] to undo the editor change
  clearHistory("Clear History"),

  /// [addTable] to add table to the editor
  addTable("Add a table"),

  /// [editTable] to edit rows, columns or delete table
  editTable("Edit table"),

  ///[separator] to add divider between toolbar items
  separator("separator");

  ///font - later releases

  /// Represents the style of a toolbar in the editor.
  const ToolBarStyle(this.name);

  /// The `name` property specifies the name of the toolbar.
  final String name;
}

/***
    ['bold', 'italic', 'underline', 'strike'],        // toggled buttons
    ['blockquote', 'code-block'],

    [{ 'header': 1 }, { 'header': 2 }],               // custom button values
    [{ 'list': 'ordered'}, { 'list': 'bullet' }],
    [{ 'script': 'sub'}, { 'script': 'super' }],      // superscript/subscript
    [{ 'indent': '-1'}, { 'indent': '+1' }],          // outdent/indent
    [{ 'direction': 'rtl' }],                         // text direction

    [{ 'size': ['small', false, 'large', 'huge'] }],  // custom dropdown
    [{ 'header': [1, 2, 3, 4, 5, 6, false] }],

    [{ 'color': [] }, { 'background': [] }],          // dropdown with defaults from theme
    [{ 'font': [] }],
    [{ 'align': [] }],

    ['clean']
 ***/
