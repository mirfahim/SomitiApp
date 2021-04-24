import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:somiti/Language/Langguage.dart';
import 'package:somiti/Variables/Variables.dart';
import 'package:somiti/Widgets/myDrawer.dart';

import '../HomePages.dart';

class ExpenseCategory extends StatefulWidget {
  @override
  _ExpenseCategoryState createState() => _ExpenseCategoryState();
}

class _ExpenseCategoryState extends State<ExpenseCategory> {
var selectDoc;
var selectIndex;
  var selectCat;
  var docID = "expenseDoc";
  Map<String, dynamic> _categories = {
    "responseCode": "1",
    "responseText": "List categories.",
    "responseBody": [
      {"category_id": "1", "category_name": "${Language.ijara}", "amount": "${Variables.foodAmount}".toString()},
      {"category_id": "2", "category_name": "${Language.kormocharibeton}", "amount": "0.00"},
      {"category_id": "3", "category_name": "${Language.sompodKena}","amount": "0.00"},
      {"category_id": "4", "category_name": "${Language.macherkhabar}", "amount": "0.00"},
      {"category_id": "5", "category_name": "${Language.oushodh}","amount": "0.00"},
      {"category_id": "6", "category_name": "${Language.onudan}","amount": "0.00"},
      {"category_id": "7", "category_name": "${Language.jatayat}","amount": "0.00"},
      {"category_id": "8", "category_name": "${Language.commision}","amount": "${Variables.labourAmount}".toString()},
      {"category_id": "9", "category_name": "${Language.diselPetrol}","amount": "0.00"},
      {"category_id": "10", "category_name": "${Language.gherKhonon}",  "amount": "0.00"},
      {"category_id": "11", "category_name": "${Language.onnanno}", "amount": "0.00"},
      {"category_id": "12", "category_name": "Pant_7483",  "amount": "0.00"},
      {"category_id": "13", "category_name": "Pant_924049",  "amount": "0.00"},
      {"category_id": "14", "category_name": "Pant_09328", "amount": "0.00"},
      {"category_id": "15", "category_name": "Pant_7783", "amount": "0.00"},
      {"category_id": "16", "category_name": "Pant_924049",  "amount": "0.00"},
      {"category_id": "17", "category_name": "Pant_09328",  "amount": "0.00"},
      {"category_id": "18", "category_name": "Pant_7483",  "amount": "0.00"},
    ],
    "responseTotalResult": 11
  };

  @override
  Widget build(BuildContext context) {
    var _crossAxisSpacing = 8;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 3;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = 70;
    var _aspectRatio = _width / cellHeight;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Expense"),
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
                  child: Container(

                  child:  Column(
                      children: [
                        Text(_categories['responseBody'][index]
                        ['category_id'], style: TextStyle(fontSize: 10),),
                    Text(
                      _categories['responseBody'][index]
                      ['category_name'],
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize:12)),
                        Text(
                            _categories['responseBody'][index]
                            ['amount'],
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize:12)),

                      ],


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
                      labelText: "Expense Details",
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
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Expense Amount",
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
             // .where("category", isEqualTo: "Food")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final documents = snapshot.data.docs;
                Variables.expenseAmount = documents.fold(
                    0, (s, n) => s + int.parse(n['amount'].toString()));


                return Center(child: Text("Total: ${Variables.expenseAmount}"));
              }),
          SizedBox(height: 20,),
          Container(
            height: MediaQuery.of(context).size.height *.2,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("KaziFarm").doc(docID).collection("Expense")
                    .snapshots(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {

                      print("${snapshot.data.docs.length} HOCCHHE NAAAAAA");
                      DocumentSnapshot documentSnapshot =
                      snapshot.data.docs[index];

                      DateTime date = documentSnapshot
                          .data()["date"].toDate();
                      var newDate = DateFormat.yMMMd().format(date);
                      print(
                          "${documentSnapshot.data()["amount"]} VIIIIIVVVIIII");



                      return Card(

                        child: InkWell(
                          onTap: () {
                            print("Nothing");
                            print("DOC__ID_KI__PAICHE___${documentSnapshot.id}");
                            setState(() {
                              selectDoc = documentSnapshot.id;
                              selectIndex = index;
                            });


                          },
                          child: Container(
                            color:selectIndex == index ? Colors.blue :Colors.white,
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      newDate,
                                      style: TextStyle(fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      "Expense: ${documentSnapshot
                                          .data()["category"]
                                          .toString()}",
                                      style: TextStyle(fontWeight: FontWeight.w300),
                                    )
                                  ],
                                ),
                                Divider(
                                  thickness: 1,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.blue.withOpacity(.1),

                                  ),
                                  title: Text(documentSnapshot
                                      .data()["memo"]
                                      .toString()),
                                  trailing:
                                  Text(documentSnapshot
                                      .data()["amount"]
                                      .toString()),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }

  createData() {
    if(memberName == null || selectCat == null){

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:Text('Fill all Details, Amount and select Category'),
          duration: Duration(seconds: 2),
        ),
      );
      // Scaffold.of(context).showSnackBar(
      //   SnackBar(
      //     duration: Duration(seconds: 2),
      //     content: Text('select your issue first'),
      //   ),
     // );
    } else {
      DocumentReference documentReference =
      FirebaseFirestore.instance.collection("KaziFarm").doc(docID).collection("Expense").doc();
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:Text('Your $selectCat details and Amount is $memberAmount added to the List'),
          duration: Duration(seconds: 2),
        ),
      );


    }
    print("DOC________ID_______${FirebaseFirestore.instance.collection("Expense").doc()}");


  }

  readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Expense").doc();
    documentReference.get().then((value) {

    });

  }

  updateData() {
    if(memberName == null || selectCat == null){

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:Text('Fill all Details, Amount and select Category'),
          duration: Duration(seconds: 2),
        ),
      );
      // Scaffold.of(context).showSnackBar(
      //   SnackBar(
      //     duration: Duration(seconds: 2),
      //     content: Text('select your issue first'),
      //   ),
      // );
    } else {
      print("created");
      DocumentReference documentReference =
      FirebaseFirestore.instance.collection("KaziFarm").doc(docID).collection("Expense").doc(selectDoc);
      Map<String, dynamic> memberInfo = {
        "memo": memberName,
        "amount": memberAmount,
        "category": Variables.selectCate,
        "date": DateTime.now(),
      };
      documentReference.set(memberInfo).whenComplete(() {
        print("$memberName updated ki hoiche");
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:Text('Your $selectCat details and Amount is $memberAmount added to the List'),
          duration: Duration(seconds: 2),
        ),
      );
    }

  }

  deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("KaziFarm").doc(docID).collection("Expense").doc(selectDoc);
    documentReference.delete().whenComplete(() {
      print("$memberName is deleted");
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:Text('Your $selectCat details and Amount is $memberAmount Deleted'),
        duration: Duration(seconds: 2),
      ),
    );
    print("created");
  }
  String expense = "expense";
  String memberName;
  String memberAmount = "0";

  getName(name) {
    this.memberName = name;
  }

  getAmount(amount) {
    this.memberAmount = amount;
  }
}
