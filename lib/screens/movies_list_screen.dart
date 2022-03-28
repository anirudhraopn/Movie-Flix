import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flix/screens/movie_info_screen.dart';
import 'package:movie_flix/state/get_details.dart';
import 'package:movie_flix/widgets/movie_item.dart';

import '../widgets/app_search_bar.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({
    Key? key,
    this.isTopRated = false,
  }) : super(key: key);
  final bool isTopRated;

  @override
  State<MoviesListScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<MoviesListScreen> {
  final GetDetails getDetails = Get.put(GetDetails());

  Future<void> fetchData() async {
    widget.isTopRated
        ? await getDetails.getDetailsTopRated()
        : await getDetails.getDetailsNowPlaying();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const AppSearchBar(),
          // SizedBox(),
          Expanded(
            child: FutureBuilder(
              future: widget.isTopRated
                  ? getDetails.getDetailsTopRated()
                  : getDetails.getDetailsNowPlaying(),
              builder: (context, snapshot) {
                // print(controller)
                // print(controller.nowPlayingItems);
                return (snapshot.connectionState == ConnectionState.active)
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).textTheme.headline6?.color,
                        ),
                      )
                    : GetBuilder<GetDetails>(
                        builder: (controller) => RefreshIndicator(
                          color: Colors.amber,
                          onRefresh: widget.isTopRated
                              ? controller.getDetailsTopRated
                              : controller.getDetailsNowPlaying,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: ((widget.isTopRated
                                    ? controller.topRatedItems
                                    : controller.nowPlayingItems))
                                .length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                direction: DismissDirection.endToStart,
                                background: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      'Delete',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                    ),
                                  ),
                                ),
                                key: ValueKey(
                                  widget.isTopRated
                                      ? controller.topRatedItems[index]['id']
                                      : controller.nowPlayingItems[index]['id'],
                                ),
                                onDismissed: (val) {
                                  controller.deleteMovie(
                                    widget.isTopRated
                                        ? controller.topRatedItems[index]['id']
                                        : controller.nowPlayingItems[index]
                                            ['id'],
                                  );
                                },
                                child: InkWell(
                                  splashColor: Colors.white,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => MovieInfoScreen(
                                          movieId: widget.isTopRated
                                              ? controller.topRatedItems[index]
                                                  ['id']
                                              : controller
                                                  .nowPlayingItems[index]['id'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: MovieItem(
                                    image: widget.isTopRated
                                        ? controller.topRatedItems[index]
                                                ['poster_path'] ??
                                            ''
                                        : controller.nowPlayingItems[index]
                                                ['poster_path'] ??
                                            '',
                                    movieName: widget.isTopRated
                                        ? controller.topRatedItems[index]
                                            ['title']
                                        : controller.nowPlayingItems[index]
                                            ['title'],
                                    overView: widget.isTopRated
                                        ? controller.topRatedItems[index]
                                            ['overview']
                                        : controller.nowPlayingItems[index]
                                            ['overview'],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, i) => const Divider(),
                          ),
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
