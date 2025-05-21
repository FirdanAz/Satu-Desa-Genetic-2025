import 'package:flutter/material.dart';
import 'package:satu_desa/core/constant/constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PhotoDetailPage extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;
  final String heroTag;

  const PhotoDetailPage({
    super.key,
    required this.imageUrls,
    required this.initialIndex,
    required this.heroTag,
  });

  @override
  State<PhotoDetailPage> createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  late PageController _pageController;
  late int currentIndex;

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            onPageChanged: (index) => setState(() => currentIndex = index),
            itemBuilder: (context, index) {
              return Center(
                child: InteractiveViewer(
                  boundaryMargin: EdgeInsets.all(80),
                  panEnabled: false,
                  scaleEnabled: true,
                  minScale: 1.0,
                  maxScale: 2.2,
                  child: Hero(
                    tag: widget.heroTag,
                    child: Image.network(
                        Constant.baseUrlImage + widget.imageUrls[index]),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            bottom: 30,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: widget.imageUrls.length,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.white,
                dotColor: Colors.white24,
                dotHeight: 8,
                dotWidth: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
