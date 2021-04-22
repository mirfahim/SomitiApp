import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:somiti/Variables/Variables.dart';
import 'package:somiti/Widgets/myDrawer.dart';

import 'HomePages.dart';

class ExpenseCategory extends StatefulWidget {
  @override
  _ExpenseCategoryState createState() => _ExpenseCategoryState();
}

class _ExpenseCategoryState extends State<ExpenseCategory> {

  var selectCat;
  Map<String, dynamic> _categories = {
    "responseCode": "1",
    "responseText": "List categories.",
    "responseBody": [
      {"category_id": "1", "category_name": "Wrong Size"},
      {"category_id": "2", "category_name": "Yarn Pulling"},
      {"category_id": "3", "category_name": "Hanging Thread"},
      {"category_id": "4", "category_name": "Shining Mark"},
      {"category_id": "5", "category_name": "SPI"},
      {"category_id": "6", "category_name": "Uneven Shap"},
      {"category_id": "7", "category_name": "Puckering"},
      {"category_id": "8", "category_name": "Pant_09328"},
      {"category_id": "9", "category_name": "Pant_7483"},
      {"category_id": "10", "category_name": "Pant_924049"},
      {"category_id": "11", "category_name": "Pant_09328"},
      {"category_id": "12", "category_name": "Pant_7483"},
      {"category_id": "13", "category_name": "Pant_924049"},
      {"category_id": "14", "category_name": "Pant_09328"},
      {"category_id": "15", "category_name": "Pant_7783"},
      {"category_id": "16", "category_name": "Pant_924049"},
      {"category_id": "17", "category_name": "Pant_09328"},
      {"category_id": "18", "category_name": "Pant_7483"},
    ],
    "responseTotalResult": 12
  };

  @override
  Widget build(BuildContext context) {
    var _crossAxisSpacing = 8;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 4;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = 70;
    var _aspectRatio = _width / cellHeight;
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      drawer: MyDrawer(),
      body: ListView(
        children: [
          GridView.builder(
            padding:
                EdgeInsets.only(left: 5.0, right: 5.0, top: 10, bottom: 22),
            shrinkWrap: true,
            itemCount: _categories['responseTotalResult'],
            // itemCount: searchList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _crossAxisCount,
                childAspectRatio: _aspectRatio),
            itemBuilder: (context, index) {
              //  final item = searchList[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectCat = _categories['responseBody'][index]
                    ['category_name'];
                    Variables.selectCate = selectCat ;
                  });
                },
                child: Card(
                  color: selectCat ==
                      _categories['responseBody'][index]
                      ['category_name']
                          .toString()
                      ? Colors.blueAccent
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: ListTile(
                    title: Text(_categories['responseBody'][index]
                    ['category_id']),
                    subtitle: Text(
                      _categories['responseBody'][index]
                      ['category_name'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                  ),
                ),
              );
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Name",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      )),
                  onChanged: (String name) {
                    getName(name);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Deposit",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                      )),
                  onChanged: (String amount) {
                    getAmount(amount);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        createData();
                      },
                      child: Text("Create")),
                  ElevatedButton(
                      onPressed: () {
                        readData();
                        Navigator.of(context).push(new CupertinoPageRoute(
                            builder: (context) => HomePage()));
                      },
                      child: Text("Read")),
                  ElevatedButton(
                      onPressed: () {
                        updateData();
                      },
                      child: Text("Update")),
                  ElevatedButton(
                      onPressed: () {
                        deleteData();
                      },
                      child: Text("Delete")),
                ],
              ),
            ],
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Expense")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final documents = snapshot.data.docs;
                Variables.expenseAmount = documents.fold(
                    0, (s, n) => s + int.parse(n['amount'].toString()));

                return Text("${Variables.expenseAmount}");
              }),
        ],
      ),
    );
  }

  createData() {
    print("created");
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Expense").doc(Variables.selectCate);
    Map<String, dynamic> memberInfo = {
      "memo": memberName,
      "amount": memberAmount,
      "category": Variables.selectCate,
      "date": DateTime.now(),
    };
    documentReference.set(memberInfo).whenComplete(() {
      print("$memberName created ki hoiche");
      print("createdREADDATAAAAAAAAAAAAAAAAAAAAAAAAA${Variables.expenseAmount}");
    });
  }

  readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Expense").doc(memberName);
    documentReference.get().then((value) {
      print(value.data()["memberName"]);
      print(value.data()["memberAmount"]);
    });

  }

  updateData() {
    var date = DateTime.now();
    print("created");
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("SomitiMember").doc(memberName);
    Map<String, dynamic> memberInfo = {
      "memberName": memberName,
      "memberAmount": memberAmount,
      "date": DateFormat.yMd().format(date),
    };
    documentReference.set(memberInfo).whenComplete(() {
      print("$memberName updated ki hoiche");
    });
  }

  deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("SomitiMember").doc(memberName);
    documentReference.delete().whenComplete(() {
      print("$memberName is deleted");
    });
    print("created");
  }
  String expense = "expense";
  String memberName;
  String memberAmount;

  getName(name) {
    this.memberName = name;
  }

  getAmount(amount) {
    this.memberAmount = amount;
  }
}
