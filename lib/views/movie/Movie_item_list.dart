import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/constent/constent.dart';
import 'package:movie_app/model/movie_model.dart';
import 'package:movie_app/views/movie/Movie_Details.dart';

class MovieItemList extends StatelessWidget {
  final MovieModel movieModel;
  const MovieItemList({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetails(movieModel: movieModel)));
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                height: 140,
                width: 120,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: kmoviedbImageURL + movieModel.posterPath.toString(),
              ),
            ),
            const SizedBox(height: 5),
            Flexible(
              child: Text(
                movieModel.title.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Row(
              children: [
                RatingBarIndicator(
                  rating: (movieModel.voteAverage ?? 0) / 2, // Normalize to 0-5 scale
                  itemSize: 15,
                  itemCount: 5,
                  direction: Axis.horizontal,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  movieModel.voteAverage?.toStringAsFixed(1) ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
