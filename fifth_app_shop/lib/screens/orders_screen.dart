import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart' show OrdersProvider;

import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

//   @override
//   _OrdersScreenState createState() => _OrdersScreenState();
// }

// class _OrdersScreenState extends State<OrdersScreen> {
  // var _isLoading = false;

  // @override
  // void initState() {
  // Future.delayed(Duration.zero).then((_) async { // don't need to use when listen is false,
  // setState(() {
  // _isLoading = true;
  // // });
  // // await
  // Provider.of<OrdersProvider>(context, listen: false) //going to use alternative to init state
  //     .fetchAndSetOrders()
  //     .then((_) {
  //   setState(() {
  //     _isLoading = false;
  //   });
  // });
  // });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    print('building orders');
    // final orderData = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<OrdersProvider>(context, listen: false)
            .fetchAndSetOrders(),
        builder: (context, dataSnaphot) {
          if (dataSnaphot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnaphot.error != null) {
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<OrdersProvider>(
                builder: (context, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (context, index) =>
                      OrderItem(orderData.orders[index]),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
