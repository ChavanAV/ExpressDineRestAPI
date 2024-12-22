// import 'package:flutter/material.dart';
//
// import '../../utils/decoration.dart';
// import '../../widgets/my_card.dart';
//
// class AllImgCard extends StatelessWidget {
//   const AllImgCard({super.key});
//
//   // @override
//   // void initState()  {
//   //   super.initState();
//   //   loadImage();
//   // }
//
//   void loadImage() {
//     // imageProvider = NetworkImage(widget.imageUrl);
//     // ImageStream stream = imageProvider.resolve(ImageConfiguration.empty);
//     // stream.addListener(ImageStreamListener((_, __) {
//     //   if(mounted){
//     //   setState(() {
//     //     isImageLoaded = true;
//     //   });
//     //   }
//     // }, onError: (_, __) {
//     //   if(mounted){
//     //   setState(() {
//     //     isImageLoaded = false;
//     //   });
//     //   }
//     // }));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MyCard(
//         padding: myCardPadding,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             (true)
//                 ? Text(
//                     "Currently Unavailable",
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                     style: itemAvailableTextStyle,
//                   )
//                 : Container(),
//             // !true
//             //   ? Shimmer.fromColors(
//             // baseColor: Colors.grey.shade300,
//             // highlightColor: Colors.white38,
//             // child: CircleAvatar(
//             //   radius: 60.0,
//             //   backgroundColor: allBgClr,
//             // ),
//             // ) :
//             CircleAvatar(
//               radius: 60,
//               backgroundColor: allBgClr,
//               // backgroundImage:  imageProvider
//             ),
//             Text(
//               "itemName",
//               style: foodNameTextStyle,
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//             ),
//             Text(
//               "Rs 45",
//               style: foodPriceTextStyle,
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//             ),
//             Text(
//               "Deliver in 45 min",
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//               style: foodTimeTextStyle,
//             ),
//           ],
//         ));
//   }
// }
