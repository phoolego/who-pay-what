import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:who_pay_what/model/Item.dart';
import 'package:who_pay_what/model/Person.dart';
import 'package:who_pay_what/widgets/CustomDropdown.dart';

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

    items.add(Item(name: "ไอติม", price: 70));
    items[0].addPayer(people[0]);
    items[0].addPayer(people[1]);
    for(Person p in people){
      p.calculatePay(items);
    }
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.12 - MediaQuery.of(context).padding.top),
          child: AppBar(
            bottom: TabBar(
              // isScrollable: true,
              tabs: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.115 - MediaQuery.of(context).padding.top,
                  width: MediaQuery.of(context).size.width*0.5,
                  child: Center(
                    child: Text(
                      "Who",
                      style: TextStyle(fontSize: 24),
                    )
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.115 - MediaQuery.of(context).padding.top,
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
        body: TabBarView(
          children: [
            Container(
              color: Color(0xFFf9e0ae),
              child: Who(),
            ),
            Container(
              color: Color(0xFFf9e0ae),
              child: What(),
            ),
          ],
        ),
      ),
    );
  }

  Widget Who(){
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
                                  editNameAlert(context, people[index]);
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
                  inputNameAlert(context);
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
  inputNameAlert(BuildContext context){
    String name;
    final _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor:Color(0xFFf9e0ae),
            shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(20.0)
            ), //this right here
            child: Container(
              height: MediaQuery.of(context).size.height*0.3,
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
                      child: Column(
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
                                  for(Person p in people){
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
                                  people.add(new Person(name: name,pay: 0));
                                  people = Person.sortNameAfterAdd(people);
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text(
                                "Save",
                                style: TextStyle(color: Color(0xFF682c0e),fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
  editNameAlert(BuildContext context,Person person){
    String name=person.name;
    final _formKey = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
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
                    child: Column(
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
                              if(name.toLowerCase()==person.name.toLowerCase()){
                                return null;
                              } else if (value.isEmpty) {
                                return 'Name is a required filed.';
                              } else {
                                for(Person p in people){
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
                                person.name = name;
                                Person.fullSort(people);
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
                              setState(() {
                                for(Item i in items){
                                  if(i.payers.contains(person)){
                                    for(Person p in i.payers){
                                      p.pay -= i.price/i.payers.length;
                                    }
                                    i.payers.remove(person);
                                    for(Person p in i.payers){
                                      p.pay += i.price/i.payers.length;
                                    }
                                  }
                                }
                                people.remove(person);
                              });
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
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Widget What(){
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
                                editItemAlert(context, items[index]);
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
                              items[index].getPrice().toString(),
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
                          children: buildNameTag(items[index].payers,items[index]),
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
                    inputItemAlert(context);
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
  inputItemAlert(BuildContext context){
    String name;
    double price;
    final _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor:Color(0xFFf9e0ae),
            shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(20.0)
            ), //this right here
            child: Container(
              height: MediaQuery.of(context).size.height*0.41,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Add new item",style: TextStyle(color: Color(0xFF682c0e)),),
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
                      child: Column(
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
                                  for(Person p in people){
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
                          SizedBox(height: 15),
                          SizedBox(
                            width: 280,
                            child: TextFormField(
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
                                  items.add(new Item(name: name,price: price));
                                  Item.sortNameAfterAdd(items);
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text(
                                "Save",
                                style: TextStyle(color: Color(0xFF682c0e),fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
  editItemAlert(BuildContext context,Item item){
    String name=item.name;
    double price = item.price;
    final _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor:Color(0xFFf9e0ae),
            shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(20.0)
            ), //this right here
            child: Container(
              height: MediaQuery.of(context).size.height*0.46,
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.34,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Form(
                            key: _formKey,
                              child: Column(
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
                                          for(Item i in items){
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
                                          item.name = name;
                                          for(Person p in item.payers){
                                            p.pay -= item.price/item.payers.length;
                                            p.pay += price/item.payers.length;
                                          }
                                          item.price = price;
                                          Item.fullSort(items);
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
                                        setState(() {
                                          item.removeItem();
                                          items.remove(item);
                                        });
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  buildNameTag(List<Person> person,Item item){
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
                  setState(() {
                    for(Person person in item.payers){
                      person.pay -= item.price/item.payers.length;
                    }
                    item.payers.remove(p);
                    for(Person person in item.payers){
                      person.pay += item.price/item.payers.length;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      );
      tag.add(w);
    }
    tag.add(CustomDropdown(text: "Add",item: item,people: people,parent: this,));
    return tag;
  }

}
