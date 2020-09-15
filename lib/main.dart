import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertaskdemo/FadeAnimation.dart';
import 'package:fluttertaskdemo/Toast.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  TextEditingController nameController,
      addressController,
      dateOfbirthController,
      colorPickerController;
  Color pickerColor = Colors.blue;
  List<ItemAdd> profileList = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = new TextEditingController();
    addressController = new TextEditingController();
    dateOfbirthController = new TextEditingController();
    colorPickerController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Task"),
        ),
        body: Column(
          children: [_body(), Expanded(child: _listView())],
        ));
  }

  _body() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 8.0,
          ),
          AppTextField(
            enabled: true,
            keyboardType: TextInputType.text,
            hinText: "Name ",
            controller: nameController,
            icon: Icons.person,
//            rightPadding: 10,
//            leftPadding: kDefaultPadding,
            iconSize: 24,
          ),
          SizedBox(
            height: 8.0,
          ),
          AppTextField(
            enabled: true,
            keyboardType: TextInputType.text,
            hinText: "Address ",
            controller: addressController,
            icon: Icons.location_city,
            maxLines: 3,
            iconSize: 24,
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
            padding: EdgeInsets.fromLTRB(15, 0, 20, 0),
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: Colors.grey.withOpacity(0.23),
                ),
              ],
            ),
            child: TextFormField(
              controller: dateOfbirthController,
              decoration: InputDecoration(
                  labelText: "Date of birth",
                  hintText: "Ex. Insert your dob",
                  contentPadding: EdgeInsets.fromLTRB(0, 10, 10, 8),
                  icon: Icon(
                    Icons.date_range,
                    size: 24,
                    color: Colors.grey
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none),
              onTap: () async {
                DateTime date = DateTime(1900);
                FocusScope.of(context).requestFocus(new FocusNode());

                date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));

                dateOfbirthController.text = dateFormatForDisplay(date);
              },
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    _changeColor(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                      color: pickerColor == null ? Colors.white : pickerColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Colors.grey.withOpacity(0.23),
                        ),
                      ],
                    ),
                    child: Text(
                      "Select your Favourite color",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 15),
                  child: MaterialButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      if (nameController.text.trim().length == 0) {
                        MyToast.normalMsg("Please enter the name", context);
                      } else if (addressController.text.trim().length == 0) {
                        MyToast.normalMsg("Please enter the address", context);

                      } else if (dateOfbirthController.text.trim().length ==
                          0) {
                        MyToast.normalMsg("Please select the date of birth", context);


                      } else if (pickerColor == null) {
                        MyToast.normalMsg("Please select your favourite color", context);


                      } else {

                        setState(() {
                          profileList.add(ItemAdd(
                              address: addressController.text,
                              dob: dateOfbirthController.text,
                              name: nameController.text,
                              pickedcolor: pickerColor));
                        });
                        addressController.clear();
                        dateOfbirthController.clear();
                        nameController.clear();
                      }
                    },
                    child: Text(
                      "Add Data",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }



  _listView() {
    return profileList.length != 0
        ? Container(
            child: ListView.builder(
                itemCount: profileList.length,
                padding: EdgeInsets.only(bottom: 15),
                itemBuilder: (BuildContext context, int index) {
                  return _listBody(profileList[index]);
                }))
        : Center(
            child: Container(
                child: Text(
              "No profile data added",
              style: TextStyle(color: Colors.black),
            )),
          );
  }

  _listBody(ItemAdd itemlist) {
    return FadeAnimation(
      1.0,
      Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: const Offset(3.0, 3.0),
                  color: Colors.grey,
                  blurRadius: 3.0,
                ),
              ],
              // border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
              color: itemlist.pickedcolor),
          margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
//           padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: ListTile(
            title: Text(
              itemlist.name,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            subtitle: Text(
              itemlist.address,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            trailing: Text(
              itemlist.dob,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          )),
    );
  }

  String dateFormatForDisplay(DateTime date) {
    return DateFormat('dd-MM-yyyy') //this format is for returning
        .format(DateFormat("yyyy-MM-dd") //this format is for incoming string
            .parse(date.toString()));
  }

  _changeColor(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0.0),
          contentPadding: const EdgeInsets.all(0.0),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (Color color) {
                setState(() {
                  pickerColor = color;
                });
              },
              colorPickerWidth: 300.0,
              pickerAreaHeightPercent: 0.7,
              enableAlpha: true,
              displayThumbColor: true,
              showLabel: true,
              paletteType: PaletteType.hsv,
              pickerAreaBorderRadius: const BorderRadius.only(
                topLeft: const Radius.circular(2.0),
                topRight: const Radius.circular(2.0),
              ),
            ),
          ),
          actions: [
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text("Cancle"),
                color: pickerColor,
                onPressed: () {
                  Navigator.pop(context);
                }),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text("Select"),
                color: pickerColor,
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }
}

class AppTextField extends StatelessWidget {
  String hinText;
  IconData icon;
  TextEditingController controller;
  double leftPadding;
  double rightPadding;
  int maxLines;
  double iconSize;
  TextInputType keyboardType;
  Function validator;

  bool enabled = true;

  AppTextField(
      {this.iconSize = 24,
      this.hinText,
      this.icon,
      this.controller,
      this.leftPadding = 15.0,
      this.rightPadding = 15,
      this.maxLines = 1,
      this.validator,
      this.enabled = true,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(leftPadding, 0, rightPadding, 0),
        padding: EdgeInsets.fromLTRB(leftPadding, 0, rightPadding, 0),
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 50,
              color: Colors.grey.withOpacity(0.23),
            ),
          ],
        ),
        child:
//      Row(
//        children: <Widget>[
//          Icon(icon,color: Colors.grey,),

//          Expanded(
//            child:
            TextFormField(
          enabled: enabled,
          keyboardType: keyboardType,
          maxLines: maxLines,
          controller: controller,
          onChanged: (value) {},
          validator: validator,
          style: TextStyle(color: enabled ? Colors.black : Colors.grey[600]),
          decoration: InputDecoration(
              icon: Icon(
                icon,
                color: Colors.grey[400],
                size: iconSize,
              ),
              labelText: hinText,
              labelStyle: TextStyle(
                color: Colors.grey[600],
              ),
              contentPadding: EdgeInsets.fromLTRB(0, 10, 10, 8),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none
              // suffix isn't working properly  with SVG
              // that's why we use row
              // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
              ),
        ));
//          ),
//        ],
//      ),
//    );
  }
}

class ItemAdd {
  String name;
  String address;
  String dob;
  Color pickedcolor;

  ItemAdd({this.name, this.address, this.dob, this.pickedcolor});
}
