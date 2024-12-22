import 'package:express_dine_rest_api/dao/order_dao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/order_model.dart';
import '../../widgets/decoration.dart';
import 'order_card.dart';

class OrderTabView extends StatefulWidget {
  final int hid;
  const OrderTabView({super.key, required this.hid});

  @override
  State<OrderTabView> createState() => _OrderTabViewState();
}

class _OrderTabViewState extends State<OrderTabView> {
  final OrderDao _orderDao = OrderDao();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder<List<Order>>(
      future: _orderDao.getHotelOrders(widget.hid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("Something went wrong !!!", style: stationTextStyle),
          );
        }
        if (snapshot.data!.isEmpty) {
          return Center(
            child: Text("No Data Found", style: stationTextStyle),
          );
        } else {
          final todayOrders = snapshot.data!.where((order) {
            DateTime orderDate = order.date;
            DateTime today = DateTime.now();
            return orderDate.year == today.year &&
                orderDate.month == today.month &&
                orderDate.day == today.day;
          }).toList();
          return (todayOrders.isNotEmpty)
              ? Container(
                  height: size.height,
                  width: size.width,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                    itemCount: todayOrders.length,
                    itemBuilder: (context, index) {
                      final order = todayOrders[index];
                      DateTime d = DateTime.parse(order.date.toString());
                      String formattedDate = DateFormat('d MMM yy').format(d);
                      return OrderCard(
                        itemName: order.menu!.dishName,
                        itemPrice: order.menu!.price,
                        totalPrice: order.totalPrice,
                        quantity: order.quantity,
                        deliveryTime: order.menu!.duration,
                        userName: order.user!.userName,
                        trainName: order.trainName,
                        seatNo: order.seatNo,
                        compartment: order.compartment,
                        contactNo: order.contactNo,
                        date: formattedDate,
                      );
                    },
                  ))
              : Center(
                  child: Text(
                    "No Today's Orders Found",
                    style: stationTextStyle,
                  ),
                );
        }
      },
    );
  }
}
