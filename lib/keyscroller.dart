// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// //
// // class KeyboardScrollView extends StatefulWidget {
// //   final Widget child;
// //   final double scrollStep;
// //   final ScrollController? scrollController;
// //
// //   const KeyboardScrollView({
// //     Key? key,
// //     required this.child,
// //     this.scrollStep = 50.0,
// //     this.scrollController,
// //   }) : super(key: key);
// //
// //   @override
// //   State<KeyboardScrollView> createState() => _KeyboardScrollViewState();
// // }
// //
// // class _KeyboardScrollViewState extends State<KeyboardScrollView> {
// //   late ScrollController _scrollController;
// //   final FocusNode _focusNode = FocusNode();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _scrollController = widget.scrollController ?? ScrollController();
// //   }
// //
// //   @override
// //   void dispose() {
// //     if (widget.scrollController == null) {
// //       _scrollController.dispose();
// //     }
// //     _focusNode.dispose();
// //     super.dispose();
// //   }
// //
// //   void _handleKeyEvent(RawKeyEvent event) {
// //     if (event is RawKeyDownEvent) {
// //       switch (event.logicalKey) {
// //         case LogicalKeyboardKey.arrowDown:
// //           _scroll(widget.scrollStep);
// //           break;
// //         case LogicalKeyboardKey.arrowUp:
// //           _scroll(-widget.scrollStep);
// //           break;
// //         case LogicalKeyboardKey.pageDown:
// //           _scroll(MediaQuery.of(context).size.height);
// //           break;
// //         case LogicalKeyboardKey.pageUp:
// //           _scroll(-MediaQuery.of(context).size.height);
// //           break;
// //         case LogicalKeyboardKey.home:
// //           _scrollToExtreme(ScrollPosition.start);
// //           break;
// //         case LogicalKeyboardKey.end:
// //           _scrollToExtreme(ScrollPosition.end);
// //           break;
// //         default:
// //           break;
// //       }
// //     }
// //   }
// //
// //   void _scroll(double delta) {
// //     final double newOffset = (_scrollController.offset + delta)
// //         .clamp(0.0, _scrollController.position.maxScrollExtent);
// //     _scrollController.animateTo(
// //       newOffset,
// //       duration: const Duration(milliseconds: 100),
// //       curve: Curves.easeInOut,
// //     );
// //   }
// //
// //   void _scrollToExtreme(ScrollPosition position) {
// //     _scrollController.animateTo(
// //       position == ScrollPosition.start ? 0.0 : _scrollController.position.maxScrollExtent,
// //       duration: const Duration(milliseconds: 300),
// //       curve: Curves.easeInOut,
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return RawKeyboardListener(
// //       focusNode: _focusNode,
// //       onKey: _handleKeyEvent,
// //       autofocus: true,
// //       child: SingleChildScrollView(
// //         controller: _scrollController,
// //         child: widget.child,
// //       ),
// //     );
// //   }
// // }
// //
// // enum ScrollPosition { start, end }
//
// import 'package:flutter/material.dart';
// import 'dart:html' as html;
//
// class BackButtonDetector extends StatefulWidget {
//   final Widget child;
//   final Future<bool> Function() onBackPressed;
//
//   const BackButtonDetector({
//     Key? key,
//     required this.child,
//     required this.onBackPressed,
//   }) : super(key: key);
//
//   @override
//   State<BackButtonDetector> createState() => _BackButtonDetectorState();
// }
//
// class _BackButtonDetectorState extends State<BackButtonDetector> {
//   @override
//   void initState() {
//     super.initState();
//     html.window.onPopState.listen((event) async {
//       if (await widget.onBackPressed()) {
//         // If onBackPressed returns true, allow the navigation
//         return;
//       }
//       // If onBackPressed returns false, prevent navigation
//       html.window.history.pushState(null, '', html.window.location.href);
//     });
//
//     // Add an initial entry to the history stack
//     html.window.history.pushState(null, '', html.window.location.href);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }
//
// // Example usage:
// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   Future<bool> _handleBackButton() async {
//     // Show a confirmation dialog
//     final shouldPop = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Are you sure?'),
//         content: const Text('Do you want to leave this page?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: const Text('No'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child: const Text('Yes'),
//           ),
//         ],
//       ),
//     );
//
//     return shouldPop ?? false;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BackButtonDetector(
//       onBackPressed: _handleBackButton,
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Back Button Detection Demo')),
//         body: const Center(
//           child: Text('Try pressing the browser back button'),
//         ),
//       ),
//     );
//   }
// }