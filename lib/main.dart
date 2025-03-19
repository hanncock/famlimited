import 'package:famlimited/controller.dart';
import 'package:famlimited/desktop/desktop_body.dart';
import 'package:famlimited/mobile/mobile_body.dart';
import 'package:famlimited/responsive/responsivelayout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html';
import 'dart:html' as html;

void main() {

 /* window.onPopState.listen((event) {
    // Code to handle the back button press
    print('Back button pressed');

    TapController().changeView();
  });*/

  html.window.onPopState.listen((event) {
    TapController().getView();
    // Prevent browser back button behavior
    html.window.history.pushState(TapController().getView(), '', html.window.location.href);
  });
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      // Intercept back button press
      // html.window.onPopState = (event) {
      //   // Prevent browser back button behavior
      //   html.window.history.pushState(null, '', html.window.location.href);
      // };

      window.onPopState.listen((event) {
        // Code to handle the back button press
        print('Back button pressed');

        TapController().changeView();
      });

      return MaterialApp(
      title: 'FAM Limited',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        /*textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),*/

        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme, // This will apply Manrope globally to all text styles
        ),

          /*textTheme: GoogleFonts.manjariTextTheme(
          Theme.of(context).textTheme,
        ),*/
      ),
      home: MyHomePage(),
      // home: StickyHeaderWithSpacePage(),
    );
  }
}




class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
          desktopBody: DesktopBody(),
          mobileBody: MobileBody()),

    );
  }
}


