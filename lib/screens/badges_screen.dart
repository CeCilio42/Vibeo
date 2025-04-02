import 'package:flutter/material.dart';
import 'package:vibeo/utils/mood_colors.dart';

class BadgesScreen extends StatelessWidget {
  final String? mood;
  const BadgesScreen({super.key, this.mood});

  void _showBadgeDetails(BuildContext context, Map<String, dynamic> badge, bool isEarned) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(
            badge['name'] as String,
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            isEarned ? 
              'Congratulations! You earned this badge by ${badge['description']}' :
              'To earn this badge: ${badge['description']}',
            style: TextStyle(color: Colors.white.withOpacity(0.9)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBadge(Map<String, dynamic> badge, bool isEarned, BuildContext context) {
    return GestureDetector(
      onTap: () => _showBadgeDetails(context, badge, isEarned),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isEarned ? [
              (badge['colors'] as List<Color>)[0],
              (badge['colors'] as List<Color>)[0].withOpacity(0.8),
              (badge['colors'] as List<Color>)[1],
            ] : [
              Colors.grey.shade800,
              Colors.grey.shade900,
              Colors.grey.shade800,
            ],
            stops: [0.0, 0.5, 1.0],
          ),
          boxShadow: [
            BoxShadow(
              color: isEarned 
                ? (badge['colors'] as List<Color>)[0].withOpacity(0.5)
                : Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isEarned
                ? Colors.white.withOpacity(0.9)
                : Colors.grey.shade600,
            width: 2,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Metallic effect overlay
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.0),
                  Colors.white.withOpacity(0.2),
                ],
                stops: [0.0, 0.3, 0.7, 1.0],
              ).createShader(bounds),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
            // Badge content
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.1),
                    border: Border.all(
                      color: isEarned 
                          ? Colors.white.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    badge['icon'] as IconData,
                    size: 28,
                    color: isEarned ? Colors.white : Colors.grey.shade400,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black.withOpacity(0.4),
                    border: Border.all(
                      color: isEarned 
                          ? Colors.white.withOpacity(0.2)
                          : Colors.transparent,
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    badge['name'] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isEarned ? Colors.white : Colors.grey.shade400,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
            // Achievement indicator
            if (isEarned)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.check,
                    size: 10,
                    color: (badge['colors'] as List<Color>)[0],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = MoodColors.getGradientColorForMood(mood);

    final earnedBadges = [
      {
        'icon': Icons.local_movies,
        'name': 'Movie Master',
        'colors': [Colors.purple.shade400, Colors.deepPurple.shade600],
        'description': 'watching 50 different movies'
      },
      {
        'icon': Icons.star_border,
        'name': 'First Review',
        'colors': [Colors.amber.shade400, Colors.orange.shade600],
        'description': 'writing your first movie review'
      },
      {
        'icon': Icons.favorite,
        'name': 'Super Fan',
        'colors': [Colors.red.shade400, Colors.redAccent.shade700],
        'description': 'watching the same movie 5 times'
      },
      {
        'icon': Icons.notifications,
        'name': 'Early Bird',
        'colors': [Colors.blue.shade400, Colors.indigo.shade600],
        'description': 'watching a movie on release day'
      },
    ];

    final availableBadges = [
      {
        'icon': Icons.movie_filter,
        'name': 'Hidden Gem',
        'colors': [Colors.teal.shade700, Colors.teal.shade900],
        'description': 'discover and rate a movie with less than 1000 reviews'
      },
      {
        'icon': Icons.timer,
        'name': 'Binge Master',
        'colors': [Colors.pink.shade700, Colors.pink.shade900],
        'description': 'watching 10 movies in a single day'
      },
      {
        'icon': Icons.group,
        'name': 'Gooner Mind',
        'colors': [Colors.cyan.shade700, Colors.cyan.shade900],
        'description': 'watching 10 sexual movies in 3 days!'
      },
      {
        'icon': Icons.grade,
        'name': 'Critics Choice',
        'colors': [Colors.amber.shade700, Colors.amber.shade900],
        'description': 'rating 100 movies'
      },
      {
        'icon': Icons.panorama,
        'name': 'Genre Explorer',
        'colors': [Colors.deepPurple.shade700, Colors.deepPurple.shade900],
        'description': 'watching movies from 10 different genres'
      },
      {
        'icon': Icons.lightbulb,
        'name': 'Mood Master',
        'colors': [Colors.green.shade700, Colors.green.shade900],
        'description': 'watch movies in all different moods'
      },
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Your Badges', style: TextStyle(color: Colors.white)),
      ),
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
                SizedBox(height: 100),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Earned Badges',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
                  itemCount: earnedBadges.length,
                  itemBuilder: (context, index) => 
                    _buildBadge(earnedBadges[index], true, context),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Available Badges',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
                  itemCount: availableBadges.length,
                  itemBuilder: (context, index) => 
                    _buildBadge(availableBadges[index], false, context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
