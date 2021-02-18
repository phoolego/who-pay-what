import 'package:flutter/material.dart';
import 'package:who_pay_what/model/Item.dart';
import 'package:who_pay_what/model/Person.dart';
import 'package:who_pay_what/screen/Home.dart';

class CustomDropdown extends StatefulWidget {
  final String text;
  List<Person> people;
  List<Person> localPeople = new List<Person>();
  Item item;
  HomeState parent;
  CustomDropdown({Key key, @required this.text, this.people, this.item,this.parent}) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  GlobalKey actionKey;
  double height, width, xPosition, yPosition;
  OverlayEntry floatingDropdown;
  OverlayEntry floatingBackground;

  @override
  void initState() {
    actionKey = LabeledGlobalKey(widget.text);
    super.initState();
  }

  void findDropdownData() {
    RenderBox renderBox = actionKey.currentContext.findRenderObject();
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
    print(height);
    print(width);
    print(xPosition);
    print(yPosition);
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: MediaQuery.of(context).size.width*0.1,
        width: MediaQuery.of(context).size.width*0.8,
        top: yPosition<MediaQuery.of(context).size.height*0.5 ? yPosition + height: yPosition - MediaQuery.of(context).size.height*0.3 - 20,
        height: MediaQuery.of(context).size.height*0.3 + 20,
        child: Container(
          // color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: yPosition<MediaQuery.of(context).size.height*0.5?[
              SizedBox(
                height: 20,
                width: MediaQuery.of(context).size.width*0.8,
                child: ClipPath(
                  clipper: ArrowClipperUp(center: xPosition+(width/2)-MediaQuery.of(context).size.width*0.1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFfc8621),
                    ),
                  ),
                ),
              ),
              // Container(
              //   height: 20,
              //   color: Color(0xFFfc8621),
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.3,
                width: MediaQuery.of(context).size.width*0.8,
                child: AddPersonList(),
              ),
            ]:[
              SizedBox(
                height: MediaQuery.of(context).size.height*0.3,
                width: MediaQuery.of(context).size.width*0.8,
                child: AddPersonList(),
              ),
              SizedBox(
                height: 20,
                width: MediaQuery.of(context).size.width*0.8,
                child: ClipPath(
                  clipper: ArrowClipperDown(center: xPosition+(width/2)-MediaQuery.of(context).size.width*0.1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFfc8621),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget AddPersonList(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFfc8621),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  child: Icon(Icons.close,color: Color(0xFF682c0e),size: 20,),
                  onTap: (){
                    floatingBackground.remove();
                    floatingDropdown.remove();
                  },
                ),
                SizedBox(width: 10,),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.3-30,
              child: widget.localPeople.length==0? Container(
                child: Center(
                  child:Card(
                    color: Color(0xFFfc8621),
                    elevation: 0,
                    child: Text(
                      "No more person to add",
                      style: TextStyle(
                        color: Color(0xFF682c0e),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ):PersonList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget PersonList(){
    return ListView.builder(
      itemCount: widget.localPeople.length,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) => Card(
        color: Color(0xFF682c0e),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          title: Text(
            widget.localPeople[index].name,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onTap: (){
            print(widget.localPeople[index].name);
            widget.parent.setState(() {
              for(Person p in widget.item.payers){
                p.pay-= widget.item.calPrice()/widget.item.payers.length;
              }
              widget.item.payers.add(widget.localPeople[index]);
              for(Person p in widget.item.payers){
                p.pay+= widget.item.calPrice()/widget.item.payers.length;
              }
            });
            setState(() {
              floatingBackground.remove();
              floatingDropdown.remove();
            });
          },
        ),
      ),
    );
  }

  OverlayEntry _createFloatingBackground(){
    return OverlayEntry(builder: (context) {
      return GestureDetector(
        onTap: (){
          print("Close");
          floatingBackground.remove();
          floatingDropdown.remove();
          // isDropdownOpened != isDropdownOpened;
        },
        child: Container(
          // height: 200,
          color: Color(0x01000000),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.localPeople.clear();
    bool isSame=false;
    for(Person person in widget.people){
      isSame=false;
      for(Person payer in widget.item.payers){
        if(payer == person){
          isSame=true;
          break;
        }
      }
      if(!isSame){
        widget.localPeople.add(person);
      }
    }
    return GestureDetector(
      key: actionKey,
      onTap: () {
        setState(() {
          findDropdownData();
          floatingBackground = _createFloatingBackground();
          floatingDropdown = _createFloatingDropdown();
          Overlay.of(context).insert(floatingBackground);
          Overlay.of(context).insert(floatingDropdown);
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5,2,5,2),
        decoration: BoxDecoration(
          color: Color(0xFFfc8621),
          borderRadius: BorderRadius.circular(10),
        ),
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.text,
                style: TextStyle(
                  color: Color(0xFF682c0e),
                  fontSize: 15,
                ),
              ),
              Icon(Icons.add,size: 15,color: Color(0xFF682c0e),),
            ],
          ),
        ),
      )
    );
  }
}

class ArrowClipperUp extends CustomClipper<Path> {
  double center;
  ArrowClipperUp({this.center});
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(center-10, size.height);
    path.lineTo(center, 0);
    path.lineTo(center+10, size.height);
    path.lineTo(center-10, size.height);

    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class ArrowClipperDown extends CustomClipper<Path> {
  double center;
  ArrowClipperDown({this.center});
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(center-10, 0);
    path.lineTo(center, size.height);
    path.lineTo(center+10, 0);
    path.lineTo(center-10, 0);

    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}