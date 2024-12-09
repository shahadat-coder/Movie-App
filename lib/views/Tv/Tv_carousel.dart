import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constent/constent.dart';
import 'package:movie_app/model/tvModel.dart';

class TvCarousel extends StatefulWidget {
  final List<TvModel> tvModel;
  const TvCarousel({super.key, required this.tvModel});

  @override
  State<TvCarousel> createState() => _TvCarouselState();
}

class _TvCarouselState extends State<TvCarousel> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: widget.tvModel.length,
        itemBuilder: (context, index,pageViewIndex){

          return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
                width: double.infinity,
                fit: BoxFit.fill,
                placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: kmoviedbImageURL + widget.tvModel[index].posterPath.toString()
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
