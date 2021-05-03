import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:woocommerce/models/products.dart';

class ProductImagesCarousel extends StatelessWidget {
  final List items;

  const ProductImagesCarousel({Key key, @required this.items})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CarouselSlider.builder(
      itemCount: items.length,
      options: CarouselOptions(
        autoPlay: false,
        // disableCenter: true,
        enableInfiniteScroll: false,
        height: size.height / 2,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        initialPage: 0,
        viewportFraction: 1,
      ),
      itemBuilder: (context, index, _) => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierColor: Colors.transparent,
                    barrierDismissible: true,
                    builder: (context) => ImageDialog(
                      images: items,
                      currentIndex: index,
                    ),
                  );
                },
                child: CachedNetworkImage(
                  imageUrl: items.elementAt(index).src,
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  fit: BoxFit.fill,
                  height: size.height / 2,
                  width: size.width,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 20,
            child: Chip(
              label: Text("${index + 1} / ${items.length}"),
            ),
          )
        ],
      ),
    );
  }
}

class ImageDialog extends StatefulWidget {
  final List<WooProductImage> images;
  final currentIndex;

  ImageDialog({
    Key key,
    @required this.images,
    @required this.currentIndex,
  }) : super(key: key);

  @override
  _ImageDialogState createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  // This controller helps setting the initial index.
  // So the gallery doesn't start always at index 0 but at the currentIndex.
  //
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: widget.currentIndex,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: PhotoViewGallery.builder(
                    itemCount: widget.images.length,
                    pageController: _pageController,
                    scrollPhysics: BouncingScrollPhysics(),
                    onPageChanged: (index) {},
                    backgroundDecoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    loadingBuilder: (context, event) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                        // Contained = the smallest possible size to fit one dimension of the screen
                        minScale: PhotoViewComputedScale.contained,
                        // Covered = the smallest possible size to fit the whole screen
                        maxScale: PhotoViewComputedScale.covered * 1.5,
                        imageProvider: CachedNetworkImageProvider(
                          widget.images.elementAt(index).src,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 20,
              child: GestureDetector(
                child: Icon(
                  Icons.close,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
