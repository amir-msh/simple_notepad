import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notepad/provider/notes_provider.dart';
import 'package:simple_notepad/ui/pages/home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Simple Notepad',
        home: const HomePage(),
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          backgroundColor: Colors.blueGrey[900],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blueGrey[700],
            titleTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.white.withOpacity(0.98),
              fontWeight: FontWeight.w500,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.blueGrey[500],
            size: 28,
          ),
          primaryIconTheme: IconThemeData(
            color: Colors.blueGrey[500],
            size: 28,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            extendedTextStyle: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          snackBarTheme: SnackBarThemeData(
            backgroundColor: Colors.blueGrey[700],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            hintStyle: TextStyle(
              fontSize: 20,
              color: Colors.grey[500],
            ),
            labelStyle: TextStyle(
              color: Colors.blueGrey[100]!,
            ),
            errorStyle: TextStyle(
              color: Colors.red[100]!,
              fontSize: 13.25,
            ),
            filled: true,
            fillColor: Colors.blueGrey[800],
            focusColor: Colors.blueGrey[700],
            hoverColor: Colors.blueGrey[700],
          ),
          textTheme: TextTheme(
            headline5: TextStyle(
              color: Colors.white.withOpacity(0.9),
            ),
            bodyText1: TextStyle(
              color: Colors.white.withOpacity(0.9),
            ),
            bodyText2: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 18.25,
            ),
            subtitle1: TextStyle(
              fontSize: 20,
              color: Colors.white.withOpacity(0.9),
            ),
            subtitle2: TextStyle(
              fontSize: 19,
              color: Colors.white.withOpacity(0.89),
            ),
          ),
        ),
      ),
    );
  }
}
