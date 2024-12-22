import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../widgets/decoration.dart';
import '../../widgets/my_card.dart';

class AllImgCard extends StatefulWidget {
  final String img;
  final String itemName;
  final double itemPrice;
  final int time;
  final bool available;
  const AllImgCard({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.time,
    required this.available,
    required this.img,
  });

  @override
  State<AllImgCard> createState() => _AllImgCardState();
}

class _AllImgCardState extends State<AllImgCard> {
  late ImageProvider imageProvider;
  bool isImageLoaded = false;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  void loadImage() {
    Uint8List imageBytes = base64Decode(widget.img);
    imageProvider = MemoryImage(imageBytes);
    imageProvider.resolve(ImageConfiguration.empty).addListener(
          ImageStreamListener(
            (ImageInfo info, bool _) {
              if (mounted) {
                setState(() {
                  isImageLoaded = true;
                });
              }
            },
            onError: (exception, stackTrace) {
              if (mounted) {
                setState(() {
                  isImageLoaded = false;
                });
              }
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return MyCard(
        padding: myCardPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (!widget.available)
                ? Text(
                    "Currently Unavailable",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: itemAvailableTextStyle,
                  )
                : Container(),
            !isImageLoaded
                ? Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white38,
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundColor: allBgClr,
                    ),
                  )
                : CircleAvatar(
                    radius: 60,
                    backgroundColor: allBgClr,
                    backgroundImage: imageProvider,
                  ),
            Text(
              widget.itemName,
              style: foodNameTextStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              "Rs ${widget.itemPrice}",
              style: foodPriceTextStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              "Deliver in ${widget.time} min",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: foodTimeTextStyle,
            ),
          ],
        ));
  }
}
