import 'package:flutter/material.dart';
import 'package:who_pay_what/model/Person.dart';

class InputWho extends StatefulWidget {
  List<Person> people;
  final addPerson;
  InputWho({this.people,this.addPerson});

  @override
  _InputWhoState createState() => _InputWhoState();
}

class _InputWhoState extends State<InputWho> {
  String name;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor:Color(0xFFf9e0ae),
      shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(20.0)
      ), //this right here
      child: Container(
        height: MediaQuery.of(context).size.height*0.32,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Add new name",style: TextStyle(color: Color(0xFF682c0e)),),
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              gapPadding: 0,
                            ),
                            contentPadding: EdgeInsets.all(10),
                            labelText: "Name",
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
                            if (value.isEmpty) {
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
                                setState(() {
                                  if (_formKey.currentState.validate()) {
                                    widget.addPerson(name);
                                    Navigator.of(context, rootNavigator: true).pop();
                                  }
                                });
                              },
                              child: Text(
                                "Save",
                                style: TextStyle(color: Color(0xFF682c0e),fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      )
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
