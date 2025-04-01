class MoodGenres {
  static Map<String, Map<String, dynamic>> moodToGenre = {
    'Happy': {
      'genres': '35,10402,16', // Comedy, Music, Animation
      'keywords': '',
    },
    'Sad': {
      'genres': '18,10749', // Drama, Romance
      'keywords': '',
    },
    'Angry': {
      'genres': '28,53', // Action, Thriller
      'keywords': '',
    },
    'Relaxed': {
      'genres': '99,36', // Documentary, History, Adventure
      'keywords': '',
    },
    'Romantic': {
      'genres': '10749,35,18', // Romance, Comedy, Drama
      'keywords': '',
    },
  };

  static Map<String, dynamic> getGenresForMood(String? mood) {
    if (mood == null) {
      return {'genres': '', 'keywords': ''};
    }
    
    if (!moodToGenre.containsKey(mood) || 
        mood == 'Horny' || 
        mood == 'Horse') {
      return {'genres': '', 'keywords': ''};
    }
    
    return moodToGenre[mood]!;
  }
}
