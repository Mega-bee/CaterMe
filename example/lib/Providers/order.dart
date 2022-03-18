import 'package:CaterMe/Services/order.dart';
import 'package:CaterMe/model/order_model.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier{

  OrderServices _orderServices=OrderServices();
  List<OrderModel> _listOrder=[];





  List<OrderModel> get listOrder => _listOrder;

  set listOrder(List<OrderModel> value) {
    _listOrder = value;
  }

  getAllOrders(String a) async{
    _listOrder=[];
    _listOrder=await _orderServices.getAllOrders(a);
    notifyListeners();
  }


  clearData(){
    _listOrder=[];
    notifyListeners();
  }
}