import 'package:express_dine_rest_api/dao/order_dao.dart';
import 'package:express_dine_rest_api/views/user/user_order_history_card.dart';
import 'package:flutter/material.dart';

import '../../models/order_model.dart';
import '../../widgets/decoration.dart';

class UserOrderHistoryScreen extends StatefulWidget {
  final int uid;
  const UserOrderHistoryScreen({super.key, required this.uid});

  @override
  State<UserOrderHistoryScreen> createState() => _UserOrderHistoryScreenState();
}

class _UserOrderHistoryScreenState extends State<UserOrderHistoryScreen> {
  final OrderDao _orderDao = OrderDao();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: myAppBar("My Orders"),
      backgroundColor: allBgClr,
      body: Container(
          height: size.height,
          width: size.width,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: FutureBuilder<List<Order>>(
            future: _orderDao.getUSerOrders(widget.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Something went wrong !!!",
                  style: cardNameTextStyle,
                ));
              }
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    "No Data Found",
                    style: cardNameTextStyle,
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final Order order = snapshot.data![index];
                    return UserOrderHistoryCard(
                      totalPrice: order.totalPrice,
                      quantity: order.quantity,
                      date: order.date,
                      menu: order.menu!,
                    );
                  },
                );
              }
            },
          )),
    );
  }
}
