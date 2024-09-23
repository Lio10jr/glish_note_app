import 'package:flutter/material.dart';
import 'package:glish_note_app/shared/consts/colors.dart';
import 'package:glish_note_app/shared/widgets/text_title.dart';

class TitleIcon extends StatelessWidget {
  final String titulo;

  const TitleIcon({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
            width: 200,
            padding: const EdgeInsets.only(top: 50, bottom: 50),
            child: TextTitle(
                color: ColorsConsts.primarybackground,
                size: 30,
                fontw: FontWeight.w500,
                titulo: titulo)),
        Ink(
          decoration: ShapeDecoration(
            color: ColorsConsts.primarybackground,
            shape: const CircleBorder(),
          ),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_sharp,
                color: Colors.white,
                size: 30,
              )),
        )
      ],
    );
  }
}
