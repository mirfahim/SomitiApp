import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:somiti/Widgets/myDrawer.dart';

class DepositListFilter extends StatefulWidget {
  final String selectedCategoryName;

  DepositListFilter({
    this.selectedCategoryName,
  });
  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<DepositListFilter> {
  var docID = "DepositDoc";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${widget.selectedCategoryName}"),
      ),
      drawer: MyDrawer(),
      body: Container(
        height: 550,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
            .collection("KaziFarm")
            .doc(docID)
                .collection("Deposit")
                .where("category", isEqualTo:  "${widget.selectedCategoryName}")
            //.orderBy('date', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if(snapshot.data == null) return Center(child: CircularProgressIndicator());
              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
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
                                child: Text("${index + 1}"),

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
    );
  }
}
