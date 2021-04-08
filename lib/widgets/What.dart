import 'package:flutter/material.dart';
import 'package:who_pay_what/model/Item.dart';
import 'package:who_pay_what/model/Person.dart';
import 'package:who_pay_what/widgets/CustomDropdown.dart';
import 'package:who_pay_what/widgets/EditWhat.dart';
import 'package:who_pay_what/widgets/InputWhat.dart';

class What extends StatelessWidget {

  List<Person> people;
  List<Item> items;
  final operation;

  What({this.people,this.items,this.operation});
  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context);
    return Column(
      children: [
        SizedBox(
          height: device.size.height*0.78,
          width: device.size.width,
          child: items.length==0 ? Center(
            child: Text(
              "What things you buy",
              style: TextStyle(
                  color: Color(0xFF682c0e),
                  fontSize: 16
              ),
            ),
          ):
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => Column(
              children: [
                SizedBox(
                  height: index==0? 15:0,
                ),
                Container(
                  width: device.size.width*0.9,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Color(0xFFc24914),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              child: Icon(Icons.edit,size: 15,color: Colors.white,),
                              onTap: (){
                                showDialog(
                                  context: context,
                                  builder: (context) => EditWhat(index: index,items: items,operation: operation,),
                                );
                              },
                            ),
                            Container(
                              width:device.size.width*0.9-45,
                              child: Text(
                                items[index].name,
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              items[index].unit.toString() + " Unit",
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 16
                              ),
                            ),
                            SizedBox(width: 15,),
                            Text(
                              items[index].getPrice().toString(),
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 16
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              items[index].getPricePerPerson().toString()+ " per person",
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 16
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: buildNameTag(items[index]),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: device.size.height*0.1,
          child: Center(
              child: SizedBox(
                width: device.size.width*0.9,
                height: device.size.height*0.08,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      )
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => InputWhat(items: items,addItem: operation['addItem'],),
                    );
                  },
                  child: Text(
                    "Add Item",
                    style: TextStyle(color: Color(0xFF682c0e),fontSize: 18),
                  ),
                ),
              )
          ),
        ),
      ],
    );
  }
  buildNameTag(Item item){
    List<Person> person = item.payers;
    List<Widget> tag = new List<Widget>();
    for(Person p in person){
      Widget w = Container(
        padding: EdgeInsets.fromLTRB(5,2,5,2),
        decoration: BoxDecoration(
          color: Color(0xFF682c0e),
          borderRadius: BorderRadius.circular(10),
        ),
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                p.name,
                style: TextStyle(
                  color: Color(0xFFf9e0ae),
                  fontSize: 15,
                ),
              ),
              InkWell(
                child: Icon(Icons.close,size: 15,color: Color(0xFFf9e0ae),),
                onTap: (){
                  operation['deletePersonFromItem'](item,p);
                },
              ),
            ],
          ),
        ),
      );
      tag.add(w);
    }
    tag.add(CustomDropdown(text: "Add",item: item,people: people,addPersonToItem: operation['addPersonToItem'],));
    return tag;
  }
}
