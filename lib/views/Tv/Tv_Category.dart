import 'package:flutter/material.dart';
import 'package:movie_app/model/tvModel.dart';
import 'package:movie_app/views/Tv/Tv_item_list.dart';
import 'package:movie_app/service/api-service.dart';

class TvCategory extends StatefulWidget {
  final TvType tvType;
  const TvCategory({super.key, required this.tvType});

  @override
  State<TvCategory> createState() => _TvCategoryState();
}

class _TvCategoryState extends State<TvCategory> {

  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: apiService.getTVData(widget.tvType),
        builder: (context, snapshot){
          if(snapshot.hasData) {
            List<TvModel> tvData = snapshot.data ?? [];
            return ListView.builder(
                itemCount: tvData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){

                  return TvItemList(tvModel: tvData[index] );

                });
          }
          return const Center(child: CircularProgressIndicator(),);
        });
  }
}
