import 'package:flutter/material.dart';
import 'mood_screen.dart';
import 'movies_list_screen.dart';
import 'tv_series_screen.dart';
import 'package:vibeo/utils/mood_colors.dart';


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

  double page = 1.0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        page = _pageController.page ?? 0;
      });
    });
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
                      _buildNavButton('Movies', MoviesListScreen()),
                      SizedBox(width: 8),
                      _buildNavButton('TV-Series', TvSeriesScreen()),
                      SizedBox(width: 8),
                      _buildNavButton(widget.mood ?? 'Mood', MoodScreen(), isMood: true),
                    ],
                  ),
                ),
                _buildFeaturedMovies(),
                _buildActionButtons(),
                _buildSection('Recommended'),
                _buildHorizontalList(),
                _buildSection('Popular'),
                _buildHorizontalList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(String title, Widget screen, {bool isMood = false}) {
    return OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: isMood ? Colors.black : Colors.white),
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 15),
      ),
      child: Text(title, style: TextStyle(color: isMood ? Colors.black : Colors.white)),
    );
  }

  Widget _buildFeaturedMovies() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: PageView.builder(
        controller: _pageController,
        itemCount: 3,
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
          );
        },
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildActionButton('Play', Colors.white, Colors.black),
          SizedBox(width: 14),
          _buildActionButton('My List', Colors.grey.withOpacity(0.3), Colors.white, icon: Icons.add),
        ],
      ),
    );
  }

  Widget _buildActionButton(String title, Color bgColor, Color textColor, {IconData? icon}) {
    return SizedBox(
      width: 150,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          side: BorderSide(color: Colors.black, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        icon: icon != null ? Icon(icon, size: 24) : SizedBox.shrink(),
        label: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildHorizontalList() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          width: 140,
          margin: const EdgeInsets.all(8),
          color: Colors.grey[800],
        ),
      ),
    );
  }
}
