import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'movie_details_screen.dart';
import 'package:vibeo/utils/mood_colors.dart';
import 'movies_list_screen.dart';
import 'movie_screen.dart';
import 'mood_screen.dart';

class TvSeriesScreen extends StatefulWidget {
  final String? mood;
  final List<Movie>? movies;

  const TvSeriesScreen({super.key, this.mood, this.movies});

  @override
  State<TvSeriesScreen> createState() => _TvSeriesScreenState();
}

class _TvSeriesScreenState extends State<TvSeriesScreen> {
  late List<Movie> shuffledMovies;

  @override
  void initState() {
    super.initState();
    // Create a shuffled copy of the movies list
    shuffledMovies = List.from(widget.movies ?? [])..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = MoodColors.getGradientColorForMood(widget.mood);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  backgroundColor.withOpacity(0.6),
                  Colors.black,
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50.0, left: 16.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MoviesListScreen(
                              mood: widget.mood,
                              movies: shuffledMovies,
                            ),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white),
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      child: Text('Movies', style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieScreen(mood: widget.mood),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.black),
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: 18),
                      ),
                      child: Text('TV-Series', style: TextStyle(color: Colors.black)),
                    ),
                    SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MoodScreen(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white),
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      child: Text(widget.mood ?? 'Mood',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2/3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: shuffledMovies.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailsScreen(
                              movie: shuffledMovies[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(shuffledMovies[index].fullPosterPath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
