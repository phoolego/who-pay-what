import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:who_pay_what/model/Item.dart';
import 'package:who_pay_what/model/Person.dart';
import 'package:who_pay_what/widgets/CustomDropdown.dart';
import 'package:who_pay_what/widgets/What.dart';
import 'package:who_pay_what/widgets/Who.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Person> people = new List<Person>();
  List<Item> items = new List<Item>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    people.add(Person(name: "Phoo"));
    people.add(Person(name: "Phat"));
    people.add(Person(name: "Phem"));
    print(people.length.toString());
    people = Person.fullSort(people);

    items.add(Item(name: "ไอติม", rawPrice: 70,unit: 1));
    items[0].addPayer(people[0]);
    items[0].addPayer(people[1]);
    for(Person p in people){
      p.calculatePay(items);
    }
  }
  addPerson(String name){
    setState(() {
      people.add(new Person(name: name, pay: 0));
      people = Person.sortNameAfterAdd(people);
    });
  }
  editPerson(Person person,String newName){
    person.name = newName;
    Person.fullSort(people);
  }
  deletePerson(Person person){
    setState(() {
      for(Item i in items){
        if(i.payers.contains(person)){
          for(Person p in i.payers){
            p.pay -= i.getPricePerPerson();
          }
          i.payers.remove(person);
          for(Person p in i.payers){
            p.pay += i.getPricePerPerson();
          }
        }
      }
      people.remove(person);
    });
  }
  addItem(String name,double price,int unit){
    setState(() {
      items.add(new Item(name: name,rawPrice: price,unit: unit));
      Item.sortNameAfterAdd(items);
    });
  }
  deleteItem(Item item){
    setState(() {
      item.removeItem();
      items.remove(item);
    });
  }
  editItem(Item item,String name,double price,int unit){
    setState(() {
      item.name = name;
      for(Person p in item.payers){
        p.pay -= item.getPricePerPerson();
        p.pay += price*unit/item.payers.length;
      }
      item.rawPrice = price;
      item.unit = unit;
      Item.fullSort(items);
    });
  }
  addPersonToItem(Item item,Person person){
    setState(() {
      for(Person p in item.payers){
        p.pay-= item.calPrice()/item.payers.length;
      }
      item.payers.add(person);
      for(Person p in item.payers){
        p.pay+= item.calPrice()/item.payers.length;
      }
    });
  }
  deletePersonFromItem(Item item,Person person){
    setState(() {
      for(Person person in item.payers){
        person.pay -= item.calPrice()/item.payers.length;
      }
      item.payers.remove(person);
      for(Person person in item.payers){
        person.pay += item.calPrice()/item.payers.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    // print(String.fromCharCode(0xe01));
    // print("Code unit list ${"เกรีย".codeUnits}");
    // String s = "ดูอะไรดี";
    // for (int i = 0; i < s.length; i++) {
    //   print("Code unit for ${s[i]} is ${s.codeUnitAt(i)}");
    // }
    Map operation = {
      "addPerson" : addPerson,
      "editPerson" : editPerson,
      "deletePerson": deletePerson,
      "addItem":addItem,
      "deleteItem":deleteItem,
      "editItem":editItem,
      "addPersonToItem":addPersonToItem,
      "deletePersonFromItem":deletePersonFromItem
    };
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.12 - MediaQuery.of(context).padding.top),
          child: AppBar(
            flexibleSpace:SafeArea(
              child: TabBar(
                // isScrollable: true,
                tabs: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.12 - MediaQuery.of(context).padding.top,
                    width: MediaQuery.of(context).size.width*0.5,
                    child: Center(
                      child: Text(
                        "Who",
                        style: TextStyle(fontSize: 24),
                      )
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.12 - MediaQuery.of(context).padding.top,
                    width: MediaQuery.of(context).size.width*0.5,
                    child: Center(
                        child: Text(
                          "What",
                          style: TextStyle(fontSize: 24),
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              color: Color(0xFFf9e0ae),
              child: Who(items: items,people: people,operation: operation,),
            ),
            Container(
              color: Color(0xFFf9e0ae),
              child: What(items: items,people: people,operation: operation),
            ),
          ],
        ),
      ),
    );
  }
}
