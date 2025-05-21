import 'package:flutter/material.dart';
import 'package:satu_desa/core/public/widgets/tile.dart';

class ListTileImageWidget extends StatelessWidget {
  const ListTileImageWidget({super.key, required this.urlImages});
  final List<String> urlImages;

  @override
  Widget build(BuildContext context) {
    if (urlImages.length == 1) {
      return _buildSingleAttachments(height: 150, imageUrl: urlImages.first);
    } else if (urlImages.length == 2) {
      return _buildTwoAttachments();
    } else {
      return _buildThreeOrMoreAttachments();
    }
  }

  Widget _buildSingleAttachments({
    double? height,
    required String imageUrl,
  }) {
    return SizedBox(
      width: double.maxFinite,
      child: Tile(
        imageUrl: imageUrl,
        height: height,
      ),
    );
  }

  Widget _buildTwoAttachments() {
    return Row(
      children: urlImages.map((url) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Tile(
              imageUrl: url,
              height: 150,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildThreeOrMoreAttachments() {
    return SizedBox(
      height: 120,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: _buildSingleAttachments(
                height: double.maxFinite, imageUrl: urlImages.first),
          ),
          SizedBox(
            width: 4,
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                    child: Stack(
                  children: [
                    _buildSingleAttachments(
                      height: double.maxFinite,
                      imageUrl: urlImages[1],
                    ),
                  ],
                )),
                if (urlImages.length > 2) ...[
                  SizedBox(height: 4),
                  Expanded(child: _buildMoreAttachments()),
                ]
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMoreAttachments() {
    return Stack(
      children: [
        _buildSingleAttachments(
            height: double.maxFinite, imageUrl: urlImages[2]),
        if (urlImages.length > 3)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  "+${urlImages.length - 3}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
