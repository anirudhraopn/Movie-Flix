import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_flix/state/get_details.dart';

import '../widgets/alert_the_user.dart';
import '../widgets/custom_appbar.dart';

class MovieInfoScreen extends StatefulWidget {
  const MovieInfoScreen({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  final int movieId;

  @override
  State<MovieInfoScreen> createState() => _MovieInfoScreenState();
}

class _MovieInfoScreenState extends State<MovieInfoScreen> {
  late dynamic movie;
  final ValueNotifier<double> offsetYNotifier = ValueNotifier(0);

  Future<void> fetchDetails(int id) async {
    try {
      final response = await http.get(Uri.parse(
          GetDetails.baseUrl + '/$id' + '?api_key=${GetDetails.apiKey}'));
      // print(response.body);
      movie = jsonDecode(response.body);
    } catch (error) {
      rethrow;
    }

    // print(movie);
  }

  @override
  Widget build(BuildContext context) {
    // fetchDetails(widget.movieId);
    return Scaffold(
      appBar: const CustomAppbar(),
      body: FutureBuilder(
          future: fetchDetails(widget.movieId),
          builder: (context, snapshot) {
            return snapshot.hasError
                ? const AlertTheUser()
                : snapshot.connectionState == ConnectionState.waiting
                    ? const CircularProgressIndicator()
                    : movie == null
                        ? const AlertTheUser()
                        : Container(
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                              image: movie['backdrop_path'] == null
                                  ? null
                                  : DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        GetDetails.backdropUrl +
                                            movie['backdrop_path'],
                                      ),
                                    ),
                            ),
                            child: Container(
                              color: Colors.black.withOpacity(0.7),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    movie['title'],
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 197, 195, 195),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    movie['release_date'] ?? 'releaseDate',
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 175, 174, 174),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MiniRow(
                                        text:
                                            '${movie['vote_average'] ?? 0}/10',
                                        icon: Icons.star,
                                      ),
                                      MiniRow(
                                        text: '${movie['runtime'] ?? 0} mins',
                                        icon: Icons.alarm,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    movie['overview'],
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 189, 189, 189),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
          }),
    );
  }
}

class MiniRow extends StatelessWidget {
  const MiniRow({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.grey,
        ),
        Text(
          text,
          style: const TextStyle(
            color: Color.fromARGB(255, 175, 174, 174),
          ),
        )
      ],
    );
  }
}
