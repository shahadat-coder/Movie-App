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
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'TV Channel',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            FutureBuilder<List<TvModel>>(
              future: apiService.getTVData(TvType.airingTody),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                  List<TvModel> tvData = snapshot.data!;
                  return TvCarousel(tvModel: tvData);
                } else {
                  return const Center(
                    child: Text(
                      'No data available',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BoldText(title: 'Popular TV'),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: TvCategory(tvType: TvType.popular),
                  ),
                  const SizedBox(height: 13),
                  const BoldText(title: 'Top Rated TV'),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: TvCategory(tvType: TvType.topRated),
                  ),
                  const SizedBox(height: 13),
                  const BoldText(title: 'On The Air'),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: TvCategory(tvType: TvType.onTheAir),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
