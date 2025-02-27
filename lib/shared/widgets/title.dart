import 'package:flutter/material.dart';
import 'package:glish_note_app/shared/consts/colors.dart';
import 'package:glish_note_app/shared/widgets/text_title.dart';

class TitleWidget extends StatelessWidget {
  final String tema;
  const TitleWidget({super.key, required this.tema});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: 0.85,
      child: Container(
          padding:
              const EdgeInsets.only(left: 40, right: 20, top: 50, bottom: 50),
          child: TextTitle(
              color: ColorsConsts.primarybackground,
              size: 30,
              fontw: FontWeight.w500,
              titulo: tema)),
    );
  }
}
