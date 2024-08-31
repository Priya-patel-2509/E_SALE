import 'package:e_commerce/models/cart/get_products.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier{


  int _counter=1;
  int get counter => _counter;

  void increment(){
    _counter++;
    notifyListeners();
  }

  void decrement(){
    if(counter>1){
      _counter--;
      notifyListeners();
    }
  }

  int? _productIndex;

  int get productIndex => _productIndex??0;
  set productIndex(int newState){
    _productIndex=newState;
    notifyListeners();
  }

  List<Product> _checkOut=[];

  List<Product> get checkOut => _checkOut;
  set checkOut(List<Product> newState){
    _checkOut=newState; 
    notifyListeners();
  }
}