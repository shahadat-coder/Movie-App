import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/constent/constent.dart';
import 'package:movie_app/model/cast_model.dart';

class CastListItem extends StatefulWidget {
  final CastModel castModel;
  const CastListItem({super.key, required this.castModel});

  @override
  State<CastListItem> createState() => _CastListItemState();
}

class _CastListItemState extends State<CastListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageBuilder: (context,imageProvider) => CircleAvatar(
              radius: 50,
              backgroundImage: imageProvider,

            ),
            height: 80,
            width: 80,
            fit: BoxFit.none,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageUrl: kmoviedbImageURL + widget.castModel.profilePath.toString(),
          ),
          SizedBox(height: 5,),
          Text(
            widget.castModel.name.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5,),
          Text(
            widget.castModel.knownForDepartment.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
