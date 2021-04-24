import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:somiti/Pages/Admin/DepositFormPage.dart';
import 'package:somiti/Pages/Admin/ExpenseForm.dart';
import 'package:somiti/Pages/HomePages.dart';
import 'package:somiti/Pages/depostList.dart';
import 'package:somiti/Variables/Variables.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Admin"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){

              Route route = MaterialPageRoute(builder: (c) => FormPage());
              Navigator.pushReplacement(context, route);
            },
            child: Container(

              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Center(child: Text("Deposit")),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){

              Route route = MaterialPageRoute(builder: (c) => ExpenseCategory());
              Navigator.pushReplacement(context, route);
            },
            child: Container(

              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: Colors.cyan,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Center(child: Text("Expense")),
              ),
            ),
          ),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: Colors.pinkAccent,

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Update Password",
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      ElevatedButton(
                          onPressed: () {
                            updateData();
                          },
                          child: Text("Update")),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  getName(name) {
    this.memberName = name;
  }
  String passID = "passID";
  String memberName;

  updateData() {
    if(memberName == null){

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:Text('Fill all Details, Amount and select Category'),
          duration: Duration(seconds: 2),
        ),
      );

    } else {
      print("created");
      DocumentReference documentReference =
      FirebaseFirestore.instance.collection("KaziFarm").doc().collection("Password").doc(passID);
      Map<String, dynamic> memberInfo = {
        "password": memberName,

        "date": DateTime.now(),
      };
      documentReference.set(memberInfo).whenComplete(() {

      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:Text('Yto the List'),
          duration: Duration(seconds: 2),
        ),

      );

        Variables.password = memberName;
        print("${Variables.password} PASWORDDDDDDDDDDDDD ki hoiche");
        print("$memberName PASWORDDDDDDDDDDDDD ki hoiche");

    }

  }

  deleteData() {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("Expense").doc();
    documentReference.delete().whenComplete(() {
      print("$memberName is deleted");
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:Text('Your Deleted'),
        duration: Duration(seconds: 2),
      ),
    );
    print("created");
  }
}
