import 'package:flutter/material.dart';
import 'package:movie_app/views/movie/Movie_category.dart';
import 'package:movie_app/componant/bold_text.dart';
import 'package:movie_app/views/movie/Moviecarousel.dart';
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),
            FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<MovieModel> moviedata = snapshot.data ?? [];
                  return MovieCarousel(movieList: moviedata,);
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
              future: apiService.getMovieData(MovieType.nowPlaying),
            ),
        
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoldText(title: 'Popular Movie',),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 200,
                    child: MovieCategory(movieType: MovieType.popular),
                  ),
                  SizedBox(height: 13,),
                  BoldText(title: 'Top Rated Movie',),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 200,
                    child: MovieCategory(movieType: MovieType.topRated),
                  ),
                  SizedBox(height: 13,),
                  BoldText(title: 'Upcoming Movie',),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 200,
                    child: MovieCategory(movieType: MovieType.upcoming),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


