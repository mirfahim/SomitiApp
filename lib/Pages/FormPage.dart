import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("FormPage"),
      ),
      drawer: MyDrawer(),
      body: Column(
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
          StreamBuilder(
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
                    print(
                        "${documentSnapshot.data()["memberName"]} KIIIIIIIII");
                    print(
                        "${documentSnapshot.data()["memberAmount"]} VIIIIIVVVIIII");

                    return Container(
                      height: 30,
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(documentSnapshot
                                  .data()["memberName"]
                                  .toString())),
                          Expanded(
                              child: Text(documentSnapshot
                                  .data()["memberAmount"]
                                  .toString())),
                        ],
                      ),
                    );
                  },
                );
              }),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("SomitiMember")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final documents = snapshot.data.docs;
                Variables.depositAmount = documents.fold(
                    0, (s, n) => s + int.parse(n['memberAmount'].toString()));

                return Text("${Variables.depositAmount}");
              }),
        ],
      ),
    );
  }

  createData() {
    print("created");
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("SomitiMember").doc(memberName);
    Map<String, dynamic> memberInfo = {
      "memberName": memberName,
      "memberAmount": memberAmount,
      "date": DateTime.now(),
    };
    documentReference.set(memberInfo).whenComplete(() {
      print("$memberName created ki hoiche");
    });
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
}
