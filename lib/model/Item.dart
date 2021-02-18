import 'dart:math';

import 'Person.dart';
import 'ThaiSort.dart';

class Item {
  String name;
  double rawPrice;
  int unit=1;

  List<Person> payers = new List<Person>();

  Item({this.name,this.rawPrice,this.unit});

  addPayer(Person payer){
    payers.add(payer);
  }
  removePayer(Person payer){
    payers.remove(payer);
  }
  calPrice(){
    return rawPrice*unit;
  }
  getPrice(){
    double mod = pow(10.0, 2);
    return ((calPrice() * mod).round().toDouble() / mod);
  }
  getPricePerPerson(){
    double mod = pow(10.0, 2);
    if(payers.length==0){
      return getPrice();
    }
    return ((calPrice()/payers.length * mod).round().toDouble() / mod);
  }

  static sortNameAfterAdd(List<Item> items){
    int i = items.length-1;
    while(i!=0 && ThaiSort.compareTo(items[i].name.toLowerCase(), items[i-1].name.toLowerCase())<0){
      Item swap = items[i];
      items[i] = items[i-1];
      items[i-1] = swap;
      i--;
    }
    return items;
  }
  static fullSort(List<Item> items){
    for(int i=0 ; i<items.length ; i++){
      for(int j=items.length-1 ; j>i ; j--){
        if(ThaiSort.compareTo(items[j].name.toLowerCase(), items[j-1].name.toLowerCase())<0){
          Item swap = items[j];
          items[j] = items[j-1];
          items[j-1] = swap;
        }
      }
    }
    return items;
  }
  removeItem(){
    for(Person p in payers){
      p.pay -= getPricePerPerson();
    }
  }
}