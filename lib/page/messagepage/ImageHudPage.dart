import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageHudPage extends StatefulWidget {
  static final String sName = "ImageHud";
  final ImageProvider imageProvider;
  final String tag;
  const ImageHudPage({Key key, this.imageProvider, this.tag}) : super(key: key);

  @override
  _ImageHudPageState createState() {
    // TODO: implement createState
    return _ImageHudPageState();
  }
}

class _ImageHudPageState extends State<ImageHudPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
          child: PhotoViewGallery(
        pageOptions: <PhotoViewGalleryPageOptions>[
          PhotoViewGalleryPageOptions(
            imageProvider: widget.imageProvider,
            heroTag: widget.tag,
          ),
//            PhotoViewGalleryPageOptions(
//                imageProvider: AssetImage("assets/gallery2.jpeg"),
//                heroTag: "tag2",
//                maxScale: PhotoViewComputedScale.contained * 0.3
//            ),
//            PhotoViewGalleryPageOptions(
//              imageProvider: AssetImage("assets/gallery3.jpeg"),
//              initialScale: PhotoViewComputedScale.contained * 0.98,
//              heroTag: "tag3",
//            ),
        ],
        backgroundDecoration: BoxDecoration(color: Colors.black87),
      )),
    );
  }
}
