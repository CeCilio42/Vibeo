import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/movie.dart';
import 'mood_screen.dart';
import 'movies_list_screen.dart';
import 'tv_series_screen.dart';
import 'package:vibeo/utils/mood_colors.dart';
import '../utils/mood_genres.dart';

class MovieScreen extends StatefulWidget {
  final String? mood;
  const MovieScreen({super.key, this.mood});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final PageController _pageController = PageController(
    viewportFraction: 0.65,
    initialPage: 1,
  );

  final String apiKey = '8a969ffeea8a30f2e1848a292986d6cc';
  final String accessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4YTk2OWZmZWVhOGEzMGYyZTE4NDhhMjkyOTg2ZDZjYyIsIm5iZiI6MTc0MzUwODIyNy45ODMsInN1YiI6IjY3ZWJkMzAzNjc5NjY1MGRmZThiZjZhOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2sfIdqW7dIDMqXkgDd6nLHsQHKbrtdKJgahXfNMJgwg';
  List<Movie> featuredMovies = [];
  List<Movie> recommendedMovies = [];
  List<Movie> popularMovies = [];

  double page = 1.0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        page = _pageController.page ?? 0;
      });
    });
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    try {
      final movies1 = await _fetchMoviesPage(1);
      final movies2 = await _fetchMoviesPage(2);
      
      final allMovies = [...movies1, ...movies2];
      
      setState(() {
        featuredMovies = allMovies.take(5).toList();
        recommendedMovies = allMovies.skip(5).take(10).toList();
        popularMovies = allMovies.skip(15).take(10).toList();
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<Movie>> _fetchMoviesPage(int page) async {
    final moodGenres = MoodGenres.getGenresForMood(widget.mood);
    final baseUrl = 'https://api.themoviedb.org/3/';
    final endpoint = moodGenres['genres'].isEmpty ? 'movie/popular' : 'discover/movie';
    
    final url = Uri.parse(
      '$baseUrl$endpoint?'
      'language=en-US'
      '&sort_by=popularity.desc'
      '&include_adult=false'
      '&include_video=false'
      '&page=$page'
      '&vote_count.gte=100'
      '${moodGenres['genres'].isEmpty ? '' : '&with_genres=${moodGenres['genres']}'}'
    );

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .where((movie) => movie['poster_path'] != null)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    }
    return [];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayText = 'Welcome John';
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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50.0, left: 16.0, bottom: 8.0),
                  child: Text(
                    displayText,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MoviesListScreen(
                                mood: widget.mood,
                                movies: featuredMovies + recommendedMovies + popularMovies,
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.white),
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal: 15), // added padding
                        ),
                        child: Text('Movies',
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 8), // small gap between buttons
                      OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TvSeriesScreen(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.white),
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal: 18), // added padding
                        ),
                        child: Text('TV-Series',
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 8), // small gap between buttons
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
                          side: BorderSide(color: Colors.black),
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal: 12), // added padding
                        ),
                        child: Text(widget.mood ?? 'Mood',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ),
                // Featured movies section
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: featuredMovies.length,
                    itemBuilder: (context, index) {
                      double difference = (page - index).abs();
                      double scale = 1 - (difference * 0.15);
                      return Transform.scale(
                        scale: scale,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: AspectRatio(
                            aspectRatio: 2 / 3,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(featuredMovies[index].fullPosterPath),
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
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150, // increased width
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            side: BorderSide(color: Colors.black, width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12), // reduced horizontal padding
                          ),
                          child: const Text(
                            'Play',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 14),
                      SizedBox(
                        width: 150, // increased width
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.withOpacity(0.3),
                            foregroundColor: Colors.white,
                            side: BorderSide(color: Colors.black, width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12), // reduced horizontal padding
                          ),
                          icon: const Icon(Icons.add, size: 24), // reduced icon size
                          label: const Text(
                            'My List',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Recommended',
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
                    itemCount: recommendedMovies.length,
                    itemBuilder: (context, index) => Container(
                      width: 140,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(recommendedMovies[index].fullPosterPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Popular',
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
                    itemCount: popularMovies.length,
                    itemBuilder: (context, index) => Container(
                      width: 140,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(popularMovies[index].fullPosterPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
