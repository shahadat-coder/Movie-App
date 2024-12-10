import 'package:flutter/material.dart';
import 'package:movie_app/componant/cast_list_item.dart';
import 'package:movie_app/model/cast_model.dart';
import 'package:movie_app/service/api-service.dart';

class CastPage extends StatefulWidget {
  final int id;
  final ProgramType type;
  const CastPage({super.key, required this.id, required this.type});

  @override
  State<CastPage> createState() => _CastPageState();
}

class _CastPageState extends State<CastPage> {

  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: apiService.getCastlist(widget.id, widget.type),
        builder: (context, snapshot){
          if(snapshot.hasData){
            List<CastModel> castList = snapshot.data ?? [];
            return ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: castList.length,
                itemBuilder: (context,index){
                  return CastListItem(castModel: castList[index]);
                });
          }
          return const Center(child: CircularProgressIndicator(),);

    });
  }


}
