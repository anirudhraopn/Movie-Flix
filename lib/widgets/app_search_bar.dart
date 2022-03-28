import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flix/screens/movie_info_screen.dart';
import 'package:movie_flix/widgets/movie_item.dart';

import '../state/get_details.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetDetails>(
      builder: (controller) => InkWell(
        onTap: () {
          showSearch(
            context: context,
            delegate: MovieSearch(
              controller: controller,
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.search),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Search',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieSearch extends SearchDelegate {
  MovieSearch({
    required this.controller,
  });
  final GetDetails controller;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          Icons.clear,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const ListTile();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // return Container();
    final List<dynamic> suggestions = query.isEmpty
        ? controller.nowPlayingItems
        : ([...controller.nowPlayingItems, ...controller.topRatedItems])
            .where(
              (element) => (((element['title']) as String)
                  .toLowerCase()
                  .contains(query.toLowerCase())),
            )
            .toList();
    return ListView.builder(
      itemBuilder: ((context, index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => MovieInfoScreen(
                        movieId: suggestions[index]['id'],
                      ),
                    ));
              },
              child: MovieItem(
                image: suggestions[index]['poster_path'],
                movieName: suggestions[index]['title'],
                overView: suggestions[index]['overview'],
                height: 120,
              ),
            ),
            const Divider(),
          ],
        );
      }),
      itemCount: suggestions.length,
    );
  }
}
