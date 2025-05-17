import 'package:flutter/material.dart';
import 'package:satu_desa/core/constant/constant.dart';

class FotoGrid extends StatelessWidget {
  final List<String> fotoUrls;

  const FotoGrid({super.key, required this.fotoUrls});

  @override
  Widget build(BuildContext context) {
    final displayPhotos = fotoUrls.take(3).toList();
    final overflowCount = fotoUrls.length - 3;

    return Row(
      children: List.generate(displayPhotos.length, (index) {
        final isLastVisible = index == 2 && fotoUrls.length > 3;
        return Padding(
          padding: const EdgeInsets.only(right: 6),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  '${Constant.baseUrlOnly}storage/${displayPhotos[index]}',
                  width: 100,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              if (isLastVisible)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '+$overflowCount',
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
            ],
          ),
        );
      }),
    );
  }
}
