import 'package:flutter/material.dart';
import 'package:movie_app/model/tvModel.dart';
import 'package:movie_app/service/api-service.dart';
import 'package:movie_app/views/Tv/Tv_item_list.dart';


class TvCategory extends StatefulWidget {
  final TvType tvType;
  final int tvID;
  const TvCategory({super.key,required this.tvType,this.tvID = 0});

  @override
  State<TvCategory> createState() => _TvCategoryState();
}

class _TvCategoryState extends State<TvCategory> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<TvModel> tvModel = snapshot.data ?? [];

          return ListView.builder(
            itemBuilder: (context, index) {
              return TvItemList(tvModel: tvModel[index]);
            },
            itemCount: tvModel.length,
            scrollDirection: Axis.horizontal,
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      future: apiService.getTVData(widget.tvType,tvID: widget.tvID),
    );
  }
}