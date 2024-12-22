import 'package:flutter/material.dart';

import '../../widgets/decoration.dart';

class OrderCard extends StatelessWidget {
  final String itemName;
  final double itemPrice;
  final double totalPrice;
  final int quantity;
  final int deliveryTime;
  final String date;
  final String userName;
  final String trainName;
  final String seatNo;
  final String compartment;
  final int contactNo;
  const OrderCard({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.totalPrice,
    required this.quantity,
    required this.deliveryTime,
    required this.date,
    required this.userName,
    required this.trainName,
    required this.seatNo,
    required this.compartment,
    required this.contactNo,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
        color: cardBgClr,
        elevation: 0,
        margin: const EdgeInsets.all(10),
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
            color: orangeSurfaceClr.withOpacity(0.3),
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  userName,
                  style: cardNameTextStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: orderCardClr,
                    border: const Border(
                      top: BorderSide(color: Colors.black12),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: size.width * 0.45,
                      decoration: const BoxDecoration(
                          border: Border(
                        right: BorderSide(color: Colors.black12),
                      )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            itemName,
                            style: orderCardItemNameTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            "Rs. $itemPrice /-",
                            style: cardInfoTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quantity: $quantity",
                            style: cardInfoTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            "Total Price Rs. $totalPrice /-",
                            style: orderCardTotalPriceTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: orderCardClr,
                    border: const Border(
                      top: BorderSide(color: Colors.black12),
                      bottom: BorderSide(color: Colors.black12),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: size.width * 0.45,
                      decoration: const BoxDecoration(
                          border: Border(
                        right: BorderSide(color: Colors.black12),
                      )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Train Name: $trainName",
                            style: cardInfoTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          Text(
                            "Seat No: $seatNo",
                            style: cardInfoTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Compartment: $compartment",
                            style: cardInfoTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            "Contact: $contactNo",
                            style: cardInfoTextStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(color: orderCardClr),
                padding: const EdgeInsets.only(left: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        date,
                        style: cardDateTimeTextStyle,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // width: size.width * 0.45,
                        decoration: BoxDecoration(color: orderCardClr),
                        child: Text(
                          "Delivery time: $deliveryTime min",
                          style: orderCardItemNameTextStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
