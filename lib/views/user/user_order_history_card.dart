import 'dart:async';
import 'dart:convert';

import 'package:express_dine_rest_api/models/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../widgets/decoration.dart';

class UserOrderHistoryCard extends StatefulWidget {
  final Menu menu;
  final double totalPrice;
  final int quantity;
  final DateTime date;

  const UserOrderHistoryCard({
    super.key,
    required this.totalPrice,
    required this.quantity,
    required this.date,
    required this.menu,
  });

  @override
  State<UserOrderHistoryCard> createState() => _UserOrderHistoryCardState();
}

class _UserOrderHistoryCardState extends State<UserOrderHistoryCard> {
  Timer? timer;
  double progress = 0.0;
  late MemoryImage cachedImage;
  String? formattedDateTime;

  @override
  void initState() {
    super.initState();
    cachedImage = MemoryImage(base64Decode(widget.menu.image!));
    formattedDateTime = DateFormat('dd MMM yy, h:mm a').format(widget.date);
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    final deliveryTime = Duration(minutes: widget.menu.duration);
    const interval = Duration(seconds: 1);

    timer = Timer.periodic(interval, (t) {
      final currentTime = DateTime.now();
      final timeDifference = currentTime.difference(widget.date);

      if (timeDifference >= deliveryTime) {
        setState(() {
          progress = 1.0;
        });
        timer!.cancel();
      } else {
        setState(() {
          progress =
              timeDifference.inMilliseconds / deliveryTime.inMilliseconds;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(3),
      decoration: decoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Image is now loaded once and reused
          CircleAvatar(
            radius: 45,
            backgroundImage: cachedImage,
            backgroundColor: allBgClr,
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.menu.dishName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: foodNameTextStyle),
                const SizedBox(height: 10),
                Text("Rs ${widget.menu.price}",
                    overflow: TextOverflow.ellipsis, maxLines: 2),
                const SizedBox(height: 10),
                Text("Quantity ${widget.quantity}",
                    overflow: TextOverflow.ellipsis, maxLines: 2),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formattedDateTime!,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Delivery time ${widget.menu.duration} min",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 10),
                Text(
                  "Total Price Rs ${widget.totalPrice}",
                  style: const TextStyle(color: Colors.green),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 10),
                (progress == 1.0)
                    ? Row(
                        children: [
                          const Text(
                            "Delivered",
                            style: TextStyle(
                              color: Colors.green,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(width: 3),
                          Icon(
                            Icons.check_circle_outline_sharp,
                            size: 16,
                            color: orangeTextClr,
                          )
                        ],
                      )
                    : LinearProgressIndicator(
                        color: orangeSurfaceClr,
                        minHeight: 7,
                        backgroundColor: Colors.grey,
                        value: progress,
                      ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
