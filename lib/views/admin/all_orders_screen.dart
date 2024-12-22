import 'package:express_dine_rest_api/dao/order_dao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/order_model.dart';
import '../../widgets//decoration.dart';
import 'order_card.dart';

class AllOrdersScreen extends StatefulWidget {
  final int hid;
  const AllOrdersScreen({super.key, required this.hid});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  final OrderDao _orderDao = OrderDao();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: myAppBar("All Orders"),
      backgroundColor: allBgClr,
      body: FutureBuilder<List<Order>>(
        future: _orderDao.getHotelOrders(widget.hid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong !!!"));
          }
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No Data Found",
                style: stationTextStyle,
              ),
            );
          } else {
            return Container(
                height: size.height,
                width: size.width,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Order order = snapshot.data![index];
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
                ));
          }
        },
      ),
    );
  }
}
