import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ImagesForSlider extends StatelessWidget {
  const ImagesForSlider({
    Key? key,
    required this.slideImageUrl,
    required this.strInfo,
    required this.backGroundColor,
  }) : super(key: key);

  final String strInfo;
  final String slideImageUrl;
  final Color backGroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backGroundColor,
      ),
      child: Row(
        children: [
          Container(
            width: 216,
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                Positioned(
                  top: 25,
                  left: 10,
                  child: SizedBox(
                    width: 180,
                    child: Text(
                      strInfo,
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 160.71,
            height: 210,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Image.network(
                slideImageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
