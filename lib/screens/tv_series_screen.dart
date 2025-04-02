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
    shuffledMovies = List.from(widget.movies ?? [])..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = MoodColors.getGradientColorForMood(widget.mood);

    final categories = {
      'Top Picks': shuffledMovies.take(6).toList(),
      'Recommended': shuffledMovies.skip(6).take(6).toList(),
      'Popular Now': shuffledMovies.skip(12).take(6).toList(),
      'Top Series': shuffledMovies.skip(18).toList(),
    };

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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieScreen(mood: widget.mood),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide.none,
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(horizontal: 18),
                      ),
                      child: Text('TV-Series', style: TextStyle(color: Colors.white)),
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
                        side: BorderSide.none,
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      child: Text(widget.mood ?? 'Mood',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, categoryIndex) {
                    final category = categories.keys.elementAt(categoryIndex);
                    final categoryMovies = categories[category]!;
                    
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            category,
                            style: TextStyle(
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
                            itemCount: categoryMovies.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailsScreen(
                                      movie: categoryMovies[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 140,
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(categoryMovies[index].fullPosterPath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
