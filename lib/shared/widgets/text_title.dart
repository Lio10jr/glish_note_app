import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextTitle extends StatelessWidget {
  final String titulo;
  final double size;
  final FontWeight fontw;
  final Color color;

  const TextTitle({
    super.key,
    required this.titulo,
    required this.size,
    required this.fontw,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      titulo,
      style:
          GoogleFonts.ubuntu(fontSize: size, fontWeight: fontw, color: color),
    );
  }
}
