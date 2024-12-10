import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/constent/constent.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/model/video_model.dart';
import 'package:movie_app/service/api-service.dart';
import 'package:url_launcher/url_launcher.dart';


class MovieDetails extends StatefulWidget {
  final MovieModel movieModel;

   MovieDetails({super.key, required this.movieModel});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {

  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.movieModel.title ?? 'Unknown Title',
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      height: 240,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[800],
                        child: const Icon(Icons.broken_image, color: Colors.white, size: 50),
                      ),
                      imageUrl: kmoviedbImageURL + (widget.movieModel.backdropPath ?? ''),
                    ),
                  ),

                  FutureBuilder(future: apiService.getVideo(widget.movieModel.id ?? 0,ProgramType.movie ),
                      builder: (context,snapshot){

                        if(snapshot.hasData){
                          List<VideoModel>videos = snapshot.data ?? [];

                          if(videos.isNotEmpty){
                            return CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.redAccent,
                                child: IconButton(onPressed: ()async{

                                  if(!await launchUrl(Uri.parse(
                                      'https://www.youtube.com/embed/${videos[0].key}'
                                  ))){
                                    throw Exception('Could not found');
                                  }

                                }, icon: const Icon(Icons.play_arrow,size: 30,)));
                          }
                        }
                        return const SizedBox();
                  })
                ],
              ),
              const SizedBox(height: 10),
              Text(
                widget.movieModel.title ?? 'Unknown Title',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: (widget.movieModel.voteAverage ?? 0) / 2, // Normalize to 0-5 scale
                    itemSize: 18,
                    itemCount: 5,
                    direction: Axis.horizontal,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                  Text(
                    widget.movieModel.voteAverage.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 170),
                  Chip(
                    elevation: 5,
                     side: BorderSide(color: Colors.grey),
                     backgroundColor: Colors.grey,
                    label: Text(
                    widget.movieModel.releaseDate.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                widget.movieModel.overview.toString(),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
