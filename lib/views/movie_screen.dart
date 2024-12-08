import 'package:flutter/material.dart';
import 'package:movie_app/componant/carousel-slider.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/service/api-service.dart';

class MovieScreen extends StatefulWidget {

  final List<MovieModel> movieList;

  const MovieScreen({super.key, required this.movieList});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'All Movie',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<MovieModel> moviedata = snapshot.data ?? [];
                return MovieCarousel();
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            future: apiService.getMovieData(MovieType.nowPlaying),
          ),
        ],
      ),
    );
  }
}
