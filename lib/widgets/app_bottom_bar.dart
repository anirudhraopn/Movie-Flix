import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_flix/screens/movies_list_screen.dart';

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({Key? key}) : super(key: key);

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // final GlobalKey navigator = GlobalKey();
  int _currentIndex = 0;

  static const _pageList = [
    MoviesListScreen(),
    MoviesListScreen(isTopRated: true),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Theme.of(context).scaffoldBackgroundColor),
      child: SafeArea(
        child: Scaffold(
          // key: _scaffoldKey,
          body: IndexedStack(index: _currentIndex, children: _pageList),
          bottomNavigationBar: BottomNavigationBar(
            // key: navigator,
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            selectedItemColor:
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
            unselectedItemColor:
                Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
            selectedIconTheme: Theme.of(context).iconTheme.copyWith(size: 40),
            type: BottomNavigationBarType.fixed,
            onTap: (val) {
              setState(() {
                _currentIndex = val;
              });
            },
            currentIndex: _currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.play_circle_outlined),
                label: 'Now Playing',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star_border),
                label: 'Top Rated',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
