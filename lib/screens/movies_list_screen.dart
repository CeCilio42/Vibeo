import 'package:flutter/material.dart';
import 'tv_series_screen.dart';
import '../utils/mood_colors.dart';
import '../models/movie.dart';

class MoviesListScreen extends StatefulWidget {
  final String? mood;
  final List<Movie> movies;
  const MoviesListScreen({super.key, this.mood, required this.movies});

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  @override
  Widget build(BuildContext context) {
    final moodColor = MoodColors.getGradientColorForMood(widget.mood);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Full screen gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  moodColor.withOpacity(0.6),
                  Colors.black,
                ],
              ),
            ),
          ),
          // Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50.0, left: 16.0, bottom: 8.0),
                  child: Text(
                    'Movies',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0, left: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.black),
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                        ),
                        child: Text('Movies',
                            style: TextStyle(color: Colors.black)),
                      ),
                      SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TvSeriesScreen(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.white),
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal: 18),
                        ),
                        child: Text('TV-Series',
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.black),
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        child: Text('Mood',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ),
                // Movie categories
                _buildMovieCategory('Trending Now', widget.movies.take(10).toList()),
                _buildMovieCategory('Popular Movies', widget.movies.skip(10).take(10).toList()),
                _buildMovieCategory('Recommended', widget.movies.skip(20).take(10).toList()),
                _buildMovieCategory('My List', widget.movies.skip(5).take(10).toList()),
                _buildMovieCategory('Local Movies', widget.movies.skip(15).take(10).toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieCategory(String title, List<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) => Container(
              width: 130,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(movies[index].fullPosterPath),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
