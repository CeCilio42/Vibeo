import 'package:flutter/material.dart';
import 'movies_list_screen.dart';
import '../utils/mood_colors.dart';

class TvSeriesScreen extends StatefulWidget {
  final String? mood;

  const TvSeriesScreen({
    Key? key,
    this.mood,
  }) : super(key: key);

  @override
  State<TvSeriesScreen> createState() => _TvSeriesScreenState();
}

class _TvSeriesScreenState extends State<TvSeriesScreen> {
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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50.0, left: 16.0, bottom: 8.0),
                  child: Text(
                    'TV-Series',
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MoviesListScreen(
                                mood: widget.mood,
                                movies: [], // This will be handled by MovieScreen when navigating from there
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.white),
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                        ),
                        child: Text('Movies',
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.black),
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal: 18),
                        ),
                        child: Text('TV-Series',
                            style: TextStyle(color: Colors.black)),
                      ),
                      SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.black),
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                        ),
                        child: Text(widget.mood ?? 'Mood',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                ),
                _buildSeriesCategory('Trending Series Today'),
                _buildSeriesCategory('Recommended'),
                _buildSeriesCategory('My List'),
                _buildSeriesCategory('Local Series'),
                _buildSeriesCategory('Documentary'),
              ], 
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeriesCategory(String title) {
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
            itemCount: 10,
            itemBuilder: (context, index) => Container(
              width: 130,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10),
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
