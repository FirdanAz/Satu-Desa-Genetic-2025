import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:satu_desa/core/theme/app_color.dart';

class CardAnggaranWidget extends StatelessWidget {
  final int totalAnggaran;
  final int anggaranTerpakai;

  const CardAnggaranWidget({
    Key? key,
    required this.totalAnggaran,
    required this.anggaranTerpakai,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double persen = anggaranTerpakai / totalAnggaran;
    print(persen);

    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          // Optional: shadow
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [Color(0xFF6DB389), Color(0xFF3F7D58)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/ic_dana_desa.svg',
                    width: 21,
                    height: 21,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Anggaran Desa',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      '2025/2026',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Anggaran',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Text(
                    'Rp${totalAnggaran.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xFF3F7D58),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rp${anggaranTerpakai.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xFF3F7D58),
                ),
              ),
              Text(
                'Rp${totalAnggaran.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xFF3F7D58),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: double.maxFinite,
              height: 14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor.bgOnPrimary,
              ),
              child: Stack(
                children: [
                  FractionallySizedBox(
                    widthFactor: persen,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [Color(0xFF6DB389), Color(0xFF3F7D58)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
