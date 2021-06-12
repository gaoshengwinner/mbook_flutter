import 'package:flutter/material.dart';

class MBImage extends StatefulWidget {
  MBImage(
      {this.url,
      this.w,
      this.h,
      this.defImagePath = "assets/graphics/logo_shu.png", this.fit}){
    createState();
  }

  final String url;
  final double w;
  final double h;
  final String defImagePath;
  final BoxFit fit;

  @override
  State<StatefulWidget> createState() {
    return _StateImageWidget();
  }
}

class _StateImageWidget extends State<MBImage> {
  Image _image;

  @override
  void initState() {
    super.initState();
    _image = Image.network(
      widget.url,
      width: widget.w,
      height: widget.h,
        fit:widget.fit,
    );
    var resolve = _image.image.resolve(ImageConfiguration.empty);
    resolve.addListener(ImageStreamListener((_, __) {
      //加载成功
    }, onError: (dynamic exception, StackTrace stackTrace) {
      //加载失败
      setState(() {
        _image = Image.asset(
          widget.defImagePath,
          width: widget.w,
          height: widget.h,
        );
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return _image;
  }
}
