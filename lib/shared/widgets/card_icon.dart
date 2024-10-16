import 'package:flutter/material.dart';
import 'package:glish_note_app/shared/consts/colors.dart';
import 'package:google_fonts/google_fonts.dart';

Card cardIcon(BuildContext context, String tema, Widget pagina, IconData icon) {
  return Card(
    elevation: 5.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: InkWell(
      splashColor: ColorsConsts.backgroundColor,
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => pagina));
      },
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            Container(
                padding: const EdgeInsets.all(5.0),
                child: Icon(icon, color: ColorsConsts.endColor, size: 75)),
            VerticalDivider(
              color: ColorsConsts.endColor,
              thickness: 2,
              width: 20,
              indent: 10,
              endIndent: 10,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  tema,
                  textAlign: TextAlign.start,
                  softWrap: true,
                  style: GoogleFonts.ubuntu(
                    fontSize: 15, fontWeight: FontWeight.w700
                  )
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
