import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/constent/constent.dart';
import 'package:movie_app/model/tvModel.dart';
import 'package:movie_app/views/Tv/tv_details.dart';

class TvItemList extends StatelessWidget {
  final TvModel tvModel;
  const TvItemList({super.key, required this.tvModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>TvDetails(tvModel: tvModel)));
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
                imageUrl: kmoviedbImageURL + tvModel.posterPath.toString(),
              ),
            ),
            const SizedBox(height: 5),
            Flexible(
              child: Text(
                tvModel.originalName.toString(),
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
                  rating: (tvModel.voteAverage ?? 0) / 2, // Normalize to 0-5 scale
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
                  tvModel.voteAverage?.toStringAsFixed(1) ?? "",
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
