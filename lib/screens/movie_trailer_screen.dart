import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailerScreen extends StatefulWidget {
  final int movieId;
  final String accessToken;

  const MovieTrailerScreen({
    Key? key, 
    required this.movieId,
    required this.accessToken,
  }) : super(key: key);

  @override
  State<MovieTrailerScreen> createState() => _MovieTrailerScreenState();
}

class _MovieTrailerScreenState extends State<MovieTrailerScreen> {
  String? _trailerKey;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchTrailer();
  }

  Future<void> _fetchTrailer() async {
    try {
      final url = Uri.parse(
        'https://api.themoviedb.org/3/movie/${widget.movieId}/videos?language=en-US'
      );

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final videos = data['results'] as List;
        final trailers = videos.where(
          (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube'
        ).toList();

        if (trailers.isNotEmpty) {
          setState(() {
            _trailerKey = trailers.first['key'];
            _isLoading = false;
          });
        } else {
          setState(() {
            _error = 'No trailer available';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _error = 'Failed to load trailer';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Movie Trailer', style: TextStyle(color: Colors.white)),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!, style: TextStyle(color: Colors.white)))
              : Center(
                  child: YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId: _trailerKey!,
                      flags: YoutubePlayerFlags(
                        autoPlay: true,
                        mute: false,
                      ),
                    ),
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.red,
                  ),
                ),
    );
  }
}
