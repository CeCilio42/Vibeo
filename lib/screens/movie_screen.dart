import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final PageController _pageController = PageController(
    viewportFraction: 0.65, // adjusted to show more of side items
    initialPage: 1,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  Colors.blue.withOpacity(0.6),
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
                // Welcome message
                Padding(
                  padding: EdgeInsets.only(top: 50.0, left: 16.0, bottom: 8.0),
                  child: Text(
                    'Welcome John',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0, left: 16.0), // added left padding
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start, // changed from center
                    children: [
                      OutlinedButton(
                        onPressed: () {},
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
                        onPressed: () {},
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
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.black),
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(horizontal: 12), // added padding
                        ),
                        child: Text('Mood',
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
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      double scale = index == 1 ? 1.0 : 0.85;
                      return TweenAnimationBuilder(
                        tween: Tween<double>(begin: scale, end: scale),
                        duration: const Duration(milliseconds: 350),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: AspectRatio(
                                aspectRatio: 2 / 3, // movie poster ratio
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: index == 0
                                        ? Colors.red[800]
                                        : index == 1
                                            ? Colors.blue[800]
                                            : Colors.green[800],
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
                    itemCount: 10,
                    itemBuilder: (context, index) => Container(
                      width: 140,
                      margin: const EdgeInsets.all(8),
                      color: Colors.grey[800],
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
                    itemCount: 10,
                    itemBuilder: (context, index) => Container(
                      width: 140,
                      margin: const EdgeInsets.all(8),
                      color: Colors.grey[800],
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
