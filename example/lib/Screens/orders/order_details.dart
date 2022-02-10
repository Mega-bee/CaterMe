import 'package:CaterMe/Providers/orderById_provider.dart';
import 'package:CaterMe/Providers/orderStatus_provider.dart';
import 'package:CaterMe/Screens/occasion/theme/colors/light_colors.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsOrder extends StatefulWidget {
  int id;

  DetailsOrder(this.id);

  @override
  _DetailsOrderState createState() => _DetailsOrderState();
}

class _DetailsOrderState extends State<DetailsOrder> {
  double Price = 0.0;
  double finaltax = 0.0;
  double finalPrice = 0.0;

  bool loading = true;

  getData() async {
    final orders = Provider.of<OrderByIdProvider>(context, listen: false);
    await orders.getOrderById(widget.id);

    setState(() {
      loading = false;
    });
    orders.orderList.forEach((element) {
      Price += element.finalPrice;
    });
  }

  Future refreshOrderData() async {
    final orders = Provider.of<OrderByIdProvider>(context, listen: false);

    await orders.clearData();
    await orders.getOrderById(widget.id);
    orders.orderList.forEach((element) {
      Price += element.finalPrice;
    });
    return;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    Price = 0.0;
    finaltax = 0.0;
    finalPrice = 0.0;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrderByIdProvider>(context, listen: true);

    finalPrice = Price + finaltax;
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refreshOrderData,
          child: loading
              ? Container(
                  color: LightColors.kLightYellow,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF3F5521),
                    ),
                  ),
                )
              : Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 5,
                        child: Container(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${order.orderList[index].item} x ${order.orderList[index].quantity}",
                                          style: TextStyle(
                                              color: Color(0xFF3F5521),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                        ),
                                        Text(
                                          "\$ ${order.orderList[index].finalPrice.toDouble().toStringAsFixed(2)}",
                                          style: TextStyle(
                                              color: Color(0xFF3F5521),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                            itemCount: order.orderList.length,
                          ),
                        ),
                      ),
                    ]),
              ),
        ),
      ),
    );
  }
}
