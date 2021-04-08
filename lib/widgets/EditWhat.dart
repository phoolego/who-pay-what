import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:who_pay_what/model/Item.dart';

class EditWhat extends StatefulWidget {
  List<Item> items;
  int index;
  final operation;

  EditWhat({this.index,this.items,this.operation});

  @override
  _EditWhatState createState() => _EditWhatState();
}

class _EditWhatState extends State<EditWhat> {
  String name;
  double price;
  int unit;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final editItem = widget.operation['editItem'];
    final deleteItem = widget.operation['deleteItem'];
    Item item = widget.items[widget.index];
    name = item.name;
    price = item.rawPrice;
    unit = item.unit;
    return Dialog(
      backgroundColor:Color(0xFFf9e0ae),
      shape: RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(20.0)
      ),
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height*0.60,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Edit Item detail",style: TextStyle(color: Color(0xFF682c0e)),),
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
                        Column(
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
                                  if(name.toLowerCase()==item.name.toLowerCase()){
                                    return null;
                                  } else if (value.isEmpty) {
                                    return 'Name is a required filed.';
                                  } else {
                                    for(Item i in widget.items){
                                      if(i.name.toLowerCase() == value.toLowerCase()){
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
                            SizedBox(height: 15,),
                            SizedBox(
                              width: 280,
                              child: TextFormField(
                                initialValue: price.toString(),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  // FilteringTextInputFormatter.digitsOnly, // Only numbers can be entered
                                ],
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    gapPadding: 0,
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                  labelText: "Price",
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
                                  if(double.parse(value, (e) => null) == null){//check numberic
                                    return "invalid number format";
                                  }else if (double.parse(value)<0) {
                                    return 'price must be 0 or more';
                                  }else {
                                    return null;
                                  }
                                },
                                onChanged: (val){
                                  price = double.parse(val);
                                },
                              ),
                            ),
                            SizedBox(height: 15),
                            SizedBox(
                              width: 280,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                initialValue: unit.toString(),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly, // Only numbers can be entered
                                ],
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    gapPadding: 0,
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                  labelText: "Unit",
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
                                  if(double.parse(value, (e) => null) == null){//check numberic
                                    return "invalid number format";
                                  }else if (double.parse(value)<0) {
                                    return 'unit must be 0 or more';
                                  }else {
                                    return null;
                                  }
                                },
                                onChanged: (val){
                                  unit = int.parse(val);
                                },
                              ),
                            ),
                          ],
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
                                    editItem(item, name, price, unit);
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
                                  deleteItem(item);
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
      ),
    );
  }
}
