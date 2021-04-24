import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:somiti/Language/Langguage.dart';
import 'package:somiti/Pages/HomePages.dart';
import 'package:somiti/Variables/Variables.dart';
import 'package:somiti/Widgets/myDrawer.dart';


class FormPage extends StatefulWidget {
  FormPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<FormPage> {
 var selectCat;
 var selectIndex;
 var selectDoc;
 var docID = "DepositDoc";
  Map<String, dynamic> _categories = {
    "responseCode": "1",
    "responseText": "List categories.",
    "responseBody": [
      {"category_id": "1", "category_name": "${Language.bank_loan}", "amount": "0.00"},
      {"category_id": "2", "category_name": "${Language.ongshidar_biniyog}", "amount": "0.00"},
      {"category_id": "3", "category_name": "${Language.nogod_dhar}", "amount": "0.00"},
      {"category_id": "4", "category_name": "${Language.mach_bikri}", "amount": "0.00"},
      {"category_id": "5", "category_name": "${Language.onnanno}", "amount": "0.00"},
      {"category_id": "6", "category_name": "Repair", "amount": "0.00"},
      {"category_id": "7", "category_name": "Water", "amount": "0.00"},
      {"category_id": "8", "category_name": "Labour", "amount": "0.00"},
      {"category_id": "9", "category_name": "Others", "amount": "0.00"},
      {"category_id": "10", "category_name": "Pant_924049", "amount": "0.00"},
      {"category_id": "11", "category_name": "Pant_09328", "amount": "0.00"},
      {"category_id": "12", "category_name": "Pant_7483", "amount": "0.00"},
      {"category_id": "13", "category_name": "Pant_924049", "amount": "0.00"},
      {"category_id": "14", "category_name": "Pant_09328", "amount": "0.00"},
      {"category_id": "15", "category_name": "Pant_7783", "amount": "0.00"},
      {"category_id": "16", "category_name": "Pant_924049", "amount": "0.00"},
      {"category_id": "17", "category_name": "Pant_09328", "amount": "0.00"},
      {"category_id": "18", "category_name": "Pant_7483", "amount": "0.00"},
    ],
    "responseTotalResult": 5
  };
  var sum;
  String memberName;
  String memberAmount;

  getName(name) {
    this.memberName = name;
  }

  getAmount(amount) {
    this.memberAmount = amount;
  }

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
        title: Text("Deposit Form"),
      ),
      drawer: MyDrawer(),
      body: ListView(

        children: <Widget>[
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
                    ['category_id'], style: TextStyle(fontSize: 10),),
                    subtitle: Text(
                      _categories['responseBody'][index]
                      ['category_name'],
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize:12),
                    ),

                  ),
                ),
              );
            },
          ),
          Container(
            child: Column(
              children: [
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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Deposit Amount",
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
              ],

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
          SizedBox(height: 20,),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("SomitiMember")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final documents = snapshot.data.docs;
                Variables.depositAmount = documents.fold(
                    0, (s, n) => s + int.parse(n['memberAmount'].toString()));

                return Text("Total Deposit: ${Variables.depositAmount}");
              }),
          SizedBox(height: 20,),
          Container(
            height: MediaQuery.of(context).size.height * .2,
            color: Colors.white70,
            child: StreamBuilder(
   // Query query = mFirestore.collection("rootcollection").whereEqualTo("month", 3);
                stream: FirebaseFirestore.instance
                    .collection("SomitiMember")

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
                          "${documentSnapshot.data()["memberAmount"]} VIIIIIVVVIIII");



                      return Card(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectIndex = index;
                              selectDoc = documentSnapshot.id;
                            });
                          },
                          child: Container(
                            color: selectIndex == index ? Colors.blue: Colors.white,
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
                                      "Deposit",
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
                                      .data()["memberName"]
                                      .toString()),
                                  trailing:
                                  Text(documentSnapshot
                                      .data()["memberAmount"]
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

    if(memberName == null || selectCat ==null){

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:Text('Write Expense Details and Expense Amount'),
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
      FirebaseFirestore.instance.collection("KaziFarm").doc(docID).collection("Deposit").doc();
      Map<String, dynamic> memberInfo = {
        "memberName": memberName,
        "memberAmount": memberAmount,
        "category": selectCat,
        "date": DateTime.now(),
      };
      documentReference.set(memberInfo).whenComplete(() {
        print("$memberName created ki hoiche");
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:Text('Your $selectCat details and Amount is $memberAmount added to the List'),
          duration: Duration(seconds: 2),
        ),
      );
    }

  }

  readData() {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("SomitiMember").doc(memberName);
    documentReference.get().then((value) {
      print(value.data()["memberName"]);
      print(value.data()["memberAmount"]);
    });
    print("createdREADDATAAAAAAAAAAAAAAAAAAAAAAAAA");
  }

  updateData() {
    if(selectCat == null || memberName == null){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:Text('Write Expense Details and Expense Amount'),
          duration: Duration(seconds: 2),
        ),
      );
    }else{
      var date = DateTime.now();
      print("created");
      DocumentReference documentReference =
      FirebaseFirestore.instance.collection("KaziFarm").doc(docID).collection("Deposit").doc(selectDoc);
      Map<String, dynamic> memberInfo = {
        "memberName": memberName,
        "memberAmount": memberAmount,
        "category": selectCat,
        "date": DateFormat.yMd().format(date),
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
    FirebaseFirestore.instance.collection("KaziFarm").doc(docID).collection("Deposit").doc(selectDoc);
    documentReference.delete().whenComplete(() {
      print("$memberName is deleted");
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:Text('Your $selectCat details and Amount is $memberAmount deleted'),
        duration: Duration(seconds: 2),
      ),
    );
    print("created");
  }
}
