import 'dart:math';

import 'package:who_pay_what/model/ThaiSort.dart';

import 'Item.dart';

class Person{
  String name;
  double pay;

  Person({this.name,this.pay});

  calculatePay(List<Item> items){
    pay = 0;
    for(Item i in items){
      int size = i.payers.length;
      for(Person p in i.payers){
        if(p.name == name){
          pay+=i.calPrice()/size;
          break;
        }
      }
    }
  }

  getPay(){
    double mod = pow(10.0, 2);
    return ((pay * mod).round().toDouble() / mod);
  }

  static sortNameAfterAdd(List<Person> people){
    int i = people.length-1;
    // while(i!=0 && people[i].name.toLowerCase().compareTo(people[i-1].name.toLowerCase())<0){
    //   Person swap = people[i];
    //   people[i] = people[i-1];
    //   people[i-1] = swap;
    //   i--;
    // }
    while(i!=0 && ThaiSort.compareTo(people[i].name.toLowerCase(), people[i-1].name.toLowerCase())<0){
      // print(people[i].name + " " + people[i-1].name + " " + people[i].name.compareTo(people[i-1].name).toString());
      Person swap = people[i];
      people[i] = people[i-1];
      people[i-1] = swap;
      i--;
    }
    return people;
  }
  static fullSort(List<Person> people){
    for(int i=0 ; i<people.length ; i++){
      for(int j=people.length-1 ; j>i ; j--){
        if(ThaiSort.compareTo(people[j].name.toLowerCase(), people[j-1].name.toLowerCase())<0){
          // print(people[j].name + " " + people[j-1].name + " " + people[j].name.compareTo(people[j-1].name).toString());
          Person swap = people[j];
          people[j] = people[j-1];
          people[j-1] = swap;
        }
      }
    }
    return people;
  }
}