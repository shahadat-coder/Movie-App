import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constent/constent.dart';
import 'package:movie_app/model/movie_model.dart';

class MovieCarousel extends StatefulWidget {
  final List<MovieModel> movieList;
  const MovieCarousel({super.key, required this.movieList});

  @override
  State<MovieCarousel> createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: widget.movieList.length,
        itemBuilder: (context, index,pageViewIndex){
         
          return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
                 width: double.infinity,
                 fit: BoxFit.fill,
                placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: kmoviedbImageURL + widget.movieList[index].posterPath.toString()
            ),
          );
          
        },
        options: CarouselOptions(
          height: 180,
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 16/9

        ));
  }
}
