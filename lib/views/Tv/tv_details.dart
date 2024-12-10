import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/componant/bold_text.dart';
import 'package:movie_app/componant/cast_page.dart';
import 'package:movie_app/constent/constent.dart';
import 'package:movie_app/model/tvModel.dart';
import 'package:movie_app/model/video_model.dart';
import 'package:movie_app/service/api-service.dart';
import 'package:movie_app/views/Tv/Tv_Category.dart';
import 'package:url_launcher/url_launcher.dart';


class TvDetails extends StatefulWidget {
  final TvModel tvModel;

  TvDetails({super.key, required this.tvModel});

  @override
  State<TvDetails> createState() => _TvDetailsState();
}

class _TvDetailsState extends State<TvDetails> {

  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.tvModel.name ?? 'Unknown Title',
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
                      imageUrl: kmoviedbImageURL + (widget.tvModel.backdropPath ?? ''),
                    ),
                  ),

                  FutureBuilder(future: apiService.getVideo(widget.tvModel.id ?? 0,ProgramType.tv ),
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

                                }, icon: const Icon(Icons.play_arrow,size: 30,color: Colors.white,)));
                          }
                        }
                        return const SizedBox();
                      })
                ],
              ),
              const SizedBox(height: 10),
              Text(
                widget.tvModel.name ?? 'Unknown Title',
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
                    rating: (widget.tvModel.voteAverage ?? 0) / 2, // Normalize to 0-5 scale
                    itemSize: 18,
                    itemCount: 5,
                    direction: Axis.horizontal,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                  Text(
                    widget.tvModel.voteAverage.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 150),
                  Chip(
                    elevation: 5,
                    backgroundColor: Colors.redAccent,
                    label: Text(
                      widget.tvModel.firstAirDate.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                widget.tvModel.overview.toString(),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              const BoldText(title: 'Cast'),
              const SizedBox(height: 10),

              SizedBox(
                  height: 140,
                  child: CastPage(id: widget.tvModel.id!, type: ProgramType.tv)),

              const SizedBox(height: 10),
              const BoldText(title: 'Similar Tv Program',),
              const SizedBox(height: 10,),
              SizedBox(
                height: 200,
                child: TvCategory(
                  tvType: TvType.similar,
                  tvID: widget.tvModel.id ?? 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
