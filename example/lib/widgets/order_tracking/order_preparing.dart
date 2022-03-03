import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderPreparing extends StatelessWidget {
  const OrderPreparing({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaquerywidth = MediaQuery.of(context).size.width;
    final mediaqueryheight = MediaQuery.of(context).size.height;
    return Center(child: Image.asset("images/orderprepare.png",height:MediaQuery.of(context).size.height*1,));
    //   Expanded(
    //   child: Container(
    //     color:LightColors.kLightYellow,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Image.asset("images/order_preparing.png"),
    //         Container(
    //           width: double.infinity,
    //           padding: EdgeInsets.symmetric(horizontal: 10),
    //           child: FittedBox(
    //             fit: BoxFit.contain,
    //             child: Text(
    //               "Preparing Order",
    //               style: TextStyle(color:  Color(0xFF3F5521), fontWeight: FontWeight.bold),
    //             ),
    //           ),
    //         ),
    //         SizedBox(height: mediaqueryheight * 0.03,),
    //
    //         Padding(
    //           padding: const EdgeInsets.only(left: 20.0),
    //           child: Row(
    //             children: [
    //               Icon(Icons.circle,color: colorCustom,),
    //               SizedBox(
    //                 width: mediaquerywidth * 0.03,
    //               ),
    //               Text('Received',style: TextStyle(color: colorCustom,fontSize: 20),),
    //             ],
    //           ),
    //
    //
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 20.0),
    //           child: Row(
    //             children: [
    //               Icon(Icons.circle,color: yellowColor,),
    //               SizedBox(
    //                 width: mediaquerywidth * 0.03,
    //               ),
    //               Text('Preparing Order',style: TextStyle(fontSize: 20,color:  yellowColor,),),
    //             ],
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 20.0),
    //           child: Row(
    //             children: [
    //               Icon(Icons.circle,color: colorCustom,),
    //               SizedBox(
    //                 width: mediaquerywidth * 0.03,
    //               ),
    //               Text('Order Is On The Way',style: TextStyle(fontSize: 20,color: colorCustom),),
    //             ],
    //           ),
    //         ),
    //         Padding(
    //           padding:const EdgeInsets.only(left: 20.0),
    //           child: Row(
    //             children: [
    //               Icon(Icons.circle,color: colorCustom,),
    //               SizedBox(
    //                 width: mediaquerywidth * 0.03,
    //               ),
    //               Text('Order Delivered',style: TextStyle(fontSize: 20,color: colorCustom),),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
