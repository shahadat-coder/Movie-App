
import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie_app/constent/constent.dart';
import 'package:movie_app/model/movie_model.dart';

enum MovieType { nowPlaying, popular, topRated, upcoming, similar }

enum TvType { popular, topRated, onTheAir, airingTody, similar }

class ApiService{

  Future<List<MovieModel>> getMovieData(MovieType type)async{
    String url = "";

    if(type == MovieType.nowPlaying){
      url = kmoviedbURL + knowPlaying;
    }else if(type == MovieType.popular){
      url = kmoviedbURL + kpopular;
    }else if(type == MovieType.topRated){
      url = kmoviedbURL + ktop_rated;
    }else if(type == MovieType.upcoming){
      url = kmoviedbURL + kupcoming;
    }
    try{

      Response response = await get(Uri.parse(url+"?api_key=7c42b5a7649145261b14083572cba71e"));

      if(response.statusCode==200){

        Map<String,dynamic> json = jsonDecode(response.body);
        List<dynamic> body = json["results"];
        List<MovieModel>movieList = body.map((item)=> MovieModel.fromJson(item)).toList();

        return movieList;

      }else{
        throw ('No movie found');
      }
      
    }catch(e){
      throw e.toString();
    }
  }
}