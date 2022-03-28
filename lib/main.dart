import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_flix/widgets/app_bottom_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: 'Movie Flix',
        debugShowCheckedModeBanner: false,

        //Dark Theme
        darkTheme: ThemeData(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color.fromARGB(255, 39, 39, 39),
            selectedItemColor: Colors.amber,
          ),
          scaffoldBackgroundColor: Colors.black,
          iconTheme: const IconThemeData(),
          textTheme: const TextTheme(
            headline6: TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
            ),
          ),
          colorScheme: const ColorScheme.dark(
              primary: Colors.black,
              onPrimary: Colors.amber,
              primaryContainer: Color.fromARGB(255, 41, 41, 41),
              background: Colors.black),
        ),

        //Light Theme
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 203, 46),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.amber,
            selectedItemColor: Colors.black,
          ),
          primarySwatch: Colors.amber,
          iconTheme: const IconThemeData(),
          textTheme: const TextTheme(
            headline6:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          colorScheme: const ColorScheme.light(
            background: Colors.amber,
            primary: Colors.amber,
            onPrimary: Colors.black,
          ),
        ),
        home: const AppBottomBar(),
      ),
    );
  }
}
