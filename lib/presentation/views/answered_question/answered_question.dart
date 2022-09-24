import 'package:flutter/material.dart';
import 'package:k24_admin/presentation/elements/custom_app_bar.dart';
import 'package:k24_admin/presentation/views/answered_question/layout/answered_body.dart';

class AnsweredQuestionView extends StatelessWidget {
  const AnsweredQuestionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Answered Questions',showIcon: true),
      body: AnsweredBody(),
    );
  }
}
