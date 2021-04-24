import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:somiti/Pages/HomePages.dart';
import 'package:somiti/Variables/Variables.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();


    Timer(
        Duration(seconds: 3),
            () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [Colors.blue, Colors.blue[800]],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 250,
            width: 250,
            child: Image(
              image: AssetImage("assets/icons/wallet.png"),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("KaziFarm")
              .doc("DepositID")
              .collection("Deposit")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final documents = snapshot.data.docs;
                Variables.depositAmount = documents.fold(
                    0, (s, n) => s + int.parse(n['memberAmount'].toString()));

                return Text("Total Deposit: ${Variables.depositAmount}", style: TextStyle(fontSize: 8,color: Colors.blue),);
              }),

          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("KaziFarm")
              .doc("ExpenseDoc")
              .collection("Expense")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final documents = snapshot.data.docs;
                Variables.expenseAmount = documents.fold(
                    0, (s, n) => s + int.parse(n['amount'].toString()));

                return Center(child: Text("Total: ${Variables.expenseAmount}", style: TextStyle(fontSize: 8, color: Colors.blue),));
              }),

          

        ],

      ),
    );
  }

}