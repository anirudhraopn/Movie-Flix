import 'package:flutter/material.dart';
import 'package:movie_flix/state/get_details.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({
    Key? key,
    required this.image,
    required this.movieName,
    required this.overView,
    this.height = 150,
  }) : super(key: key);
  final String image;
  final String movieName, overView;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Image.network(GetDetails.imageUrl + image),
          ),
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      movieName,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Text(
                    overView,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
