import 'package:flutter/material.dart';
import 'package:movie_app/views/movie/Movie_item_list.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/service/api-service.dart';

class MovieCategory extends StatefulWidget {
  final MovieType movieType;
  const MovieCategory({super.key, required this.movieType});

  @override
  State<MovieCategory> createState() => _MovieCategoryState();
}

class _MovieCategoryState extends State<MovieCategory> {

  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: apiService.getMovieData(widget.movieType),
        builder: (context, snapshot){
          if(snapshot.hasData) {
           List<MovieModel> movieList = snapshot.data ?? [];
           return ListView.builder(
             itemCount: movieList.length,
               scrollDirection: Axis.horizontal,
               itemBuilder: (context, index){

               return MovieItemList(movieModel: movieList[index] );

           });
          }
          return const Center(child: CircularProgressIndicator(),);
        });
  }
}
