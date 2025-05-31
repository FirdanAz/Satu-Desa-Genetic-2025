import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardAgendaDesaWidget extends StatelessWidget {
  const CardAgendaDesaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6DB389), Color(0xFF3F7D58)],
        ),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
            child: SvgPicture.asset(
              'assets/images/bg_auth.svg',
              fit: BoxFit.fitWidth,
            ),
          ),

          // Syringe image
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 8),
              child: Image.asset(
                'assets/icons/ic_suntik.png',
                height: 135,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Text content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Imunisasi Balita',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Sabtu, 17 Mei 2025',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '08.00 Wib - Selesai',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/ic_location.svg', // ganti dengan path icon lokasi
                      height: 17,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Posyandu Desa Maju',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
