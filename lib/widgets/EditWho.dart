import 'package:flutter/material.dart';
import 'package:who_pay_what/model/Item.dart';
import 'package:who_pay_what/model/Person.dart';

class EditWho extends StatefulWidget {
  List<Person> people;
  int person;
  final operation;

  EditWho({this.person,this.people,this.operation});
  @override
  _EditWhoState createState() => _EditWhoState();
}

class _EditWhoState extends State<EditWho> {
  int index;
  String name;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = widget.person;
    name = widget.people[index].name;
  }
  @override
  Widget build(BuildContext context) {
    final editPerson = widget.operation['editPerson'];
    final deletePerson = widget.operation['deletePerson'];
    return Dialog(
      backgroundColor:Color(0xFFf9e0ae),
      shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(20.0)
      ), //this right here
      child: Container(
        height: MediaQuery.of(context).size.height*0.4,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Edit name",style: TextStyle(color: Color(0xFF682c0e)),),
                  SizedBox(
                    width: 30,
                    child: MaterialButton(
                      padding: EdgeInsets.all(0),
                      child: Icon(Icons.close),
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 280,
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          initialValue: name,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            labelText: "Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              gapPadding: 0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).primaryColor,width: 2),
                              borderRadius: BorderRadius.circular(20.0),
                              gapPadding: 0,
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red,width: 2),
                              borderRadius: BorderRadius.circular(20.0),
                              gapPadding: 0,
                            ),
                          ),
                          validator: (String value) {
                            if(name.toLowerCase()==widget.people[index].name.toLowerCase()){
                              return null;
                            } else if (value.isEmpty) {
                              return 'Name is a required filed.';
                            } else {
                              for(Person p in widget.people){
                                if(p.name.toLowerCase() == value.toLowerCase()){
                                  return "Name is already use.";
                                }
                              }
                              return null;
                            }
                          },
                          onChanged: (val){
                            name = val;
                          },
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(height: 20),
                          SizedBox(
                            width: 300.0,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0)
                                  )
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()){
                                  editPerson(widget.people[index],name);
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text(
                                "Save",
                                style: TextStyle(color: Color(0xFF682c0e),fontSize: 16),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            width: 300.0,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                primary: Color(0xFF682c0e),
                              ),
                              onPressed: () {
                                deletePerson(widget.people[index]);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Delete",
                                style: TextStyle(color: Colors.white,fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
