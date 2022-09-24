import 'package:flutter/material.dart';
import 'package:k24_admin/presentation/views/answered_question/layout/widgets/answered_tile.dart';

class AnsweredBody extends StatelessWidget {
  const AnsweredBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context,i){
        return const AnsweredTile();
      }),
    );
  }
}
