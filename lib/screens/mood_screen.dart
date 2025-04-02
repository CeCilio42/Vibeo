import 'package:flutter/material.dart';
import 'movie_screen.dart';
import '../utils/mood_colors.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  final List<Map<String, dynamic>> moods = [
    {
      'name': 'Happy',
      'icon': Icons.sentiment_very_satisfied,
      'colors': [Colors.amber[400]!, Colors.orange[600]!],
    },
    {
      'name': 'Sad',
      'icon': Icons.sentiment_very_dissatisfied,
      'colors': [Colors.indigo[400]!, Colors.blue[600]!],
    },
    {
      'name': 'Angry',
      'icon': Icons.mood_bad,
      'colors': [Colors.red[400]!, Colors.redAccent[700]!],
    },
    {
      'name': 'Relaxed',
      'icon': Icons.spa,
      'colors': [Colors.teal[400]!, Colors.green[600]!],
    },
    {
      'name': 'Romantic',
      'icon': Icons.favorite,
      'colors': [Colors.pink[400]!, Colors.purple[600]!],
    },
    {
      'name': 'Horny',
      'icon': Icons.whatshot,
      'colors': [Colors.deepPurple[400]!, Colors.indigo[600]!],
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Select Your Mood', style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blueGrey.withOpacity(0.6),
                  Colors.black,
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: moods.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieScreen(mood: moods[index]['name']),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: moods[index]['colors'],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.1),
                              ),
                              child: Icon(
                                moods[index]['icon'],
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              moods[index]['name'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
