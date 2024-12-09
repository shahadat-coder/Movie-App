import 'package:flutter/material.dart';
import 'package:movie_app/componant/bold_text.dart';
import 'package:movie_app/model/tvModel.dart';
import 'package:movie_app/service/api-service.dart';
import 'package:movie_app/views/Tv/Tv_Category.dart';
import 'package:movie_app/views/Tv/Tv_carousel.dart';

class TVScreen extends StatefulWidget {
  final List<TvModel> tvModel;
  const TVScreen({super.key, required this.tvModel});

  @override
  State<TVScreen> createState() => _TVScreenState();
}

class _TVScreenState extends State<TVScreen> {
  ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('TV Channel',style: TextStyle(
        color: Colors.white,
      ),),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15,),
            FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<TvModel> tvData = snapshot.data ?? [];
                  return TvCarousel(tvModel: tvData,);
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
              future: apiService.getTVData(TvType.airingTody),
            ),
        
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoldText(title: 'Popular TV',),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 200,
                    child: TvCategory(tvType: TvType.popular),
                  ),
                  SizedBox(height: 13,),
                  BoldText(title: 'Top Rated TV',),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 200,
                    child: TvCategory(tvType: TvType.topRated),
                  ),
                  SizedBox(height: 13,),
                  BoldText(title: 'On The Air',),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 200,
                    child: TvCategory(tvType: TvType.onTheAir),
                  ),
                ],
              ),
            )
          ],
        ),
      ),

    );;
  }
}
