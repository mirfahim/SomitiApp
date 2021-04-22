import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:somiti/Variables/Variables.dart';
import 'package:somiti/Widgets/SummaryWidget.dart';
import 'package:intl/intl.dart';
import 'package:somiti/Widgets/myDrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HomePage"
        ),
      ),
      drawer: MyDrawer(),
      body: ListView(
        children: [

          SummaryWidget(

            income: Variables.depositAmount,
            expense: Variables.expenseAmount,
          ),

          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Expense")
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
                          Navigator.pushNamed(context, "details", arguments: "")
                              .then((value) => {
                            if (value != null)
                              {
                                if (value) {}
                              }
                          });
                        },
                        child: Container(
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
                                    "Expense",
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

        ],

      ),
    );
  }
}
