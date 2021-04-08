import 'package:flutter/material.dart';
import 'package:who_pay_what/model/Item.dart';
import 'package:who_pay_what/model/Person.dart';
import 'package:who_pay_what/widgets/EditWho.dart';
import 'package:who_pay_what/widgets/InputWho.dart';

class Who extends StatelessWidget {
  List<Person> people;
  List<Item> items;
  final operation;

  Who({this.people,this.items,this.operation});
  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.of(context);
    return Column(
        children: [
          SizedBox(
            height: device.size.height*0.78,
            width: device.size.width,
            child: people.length==0 ? Center(
              child: Text(
                "Add who need to pay.",
                style: TextStyle(
                    color: Color(0xFF682c0e),
                    fontSize: 16
                ),
              ),
            ):
            ListView.builder(
              itemCount: people.length,
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
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                child: Icon(Icons.edit,size: 15,color: Colors.white,),
                                onTap: (){
                                  showDialog(
                                    context: context,
                                    builder: (context) => EditWho(person: index,people: people,operation: operation,),
                                  );
                                },
                              ),
                              Container(
                                width:device.size.width*0.9-45,
                                child: Text(
                                  people[index].name,
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
                                people[index].getPay().toString(),
                                style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 16
                                ),
                              ),
                            ],
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
                        builder: (context) => InputWho(people: people,addPerson: operation['addPerson'],),
                      );
                    },
                    child: Text(
                      "Add Person name",
                      style: TextStyle(color: Color(0xFF682c0e),fontSize: 18),
                    ),
                  ),
                )
            ),
          ),
        ],
      );
    }
}
