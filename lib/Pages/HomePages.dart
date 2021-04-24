import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:somiti/Language/Langguage.dart';
import 'package:somiti/Pages/FilterList/DepositFilterList.dart';
import 'package:somiti/Pages/FilterList/ExpenseFilter.dart';
import 'package:somiti/Variables/Variables.dart';
import 'package:somiti/Widgets/SummaryWidget.dart';
import 'package:intl/intl.dart';
import 'package:somiti/Widgets/myDrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 var selectCat;
 String selectedCategoryName;
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

  Map<String, dynamic> _categoriesDeposit = {
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

  @override
  Widget build(BuildContext context) {
    var _crossAxisSpacing = 8;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 3;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = 90;
    var _aspectRatio = _width / cellHeight;
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        centerTitle: true,
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
          Container(
            color: Colors.blue,
            child: Column(
              children: [
                Card(
                  color: Colors.cyan,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text("${Language.khorocherHisab}"),
                ),
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
                        
                           selectedCategoryName =  _categories['responseBody'][index]
                           ['category_name'];
                           Route route = MaterialPageRoute(builder: (c) => ExpenseListFilter(selectedCategoryName: selectedCategoryName,));
                           Navigator.pushReplacement(context, route);
                         });
                      },
                      child: Card(

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
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            color: Colors.green,
            child: Column(
              children: [
                Card(
                  color: Colors.cyan,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Text("${Language.biniyogerHisab}"),
                ),
                GridView.builder(
                  padding:
                  EdgeInsets.only(left: 5.0, right: 5.0, top: 10, bottom: 22),
                  shrinkWrap: true,
                  itemCount: _categoriesDeposit['responseTotalResult'],
                  // itemCount: searchList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _crossAxisCount,
                      childAspectRatio: _aspectRatio),
                  itemBuilder: (context, index) {
                    //  final item = searchList[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {

                            selectedCategoryName =  _categoriesDeposit['responseBody'][index]
                            ['category_name'];
                            Route route = MaterialPageRoute(builder: (c) => DepositListFilter(selectedCategoryName: selectedCategoryName,));
                            Navigator.pushReplacement(context, route);

                          selectCat = _categories['responseBody'][index]
                          ['category_name'];
                          Variables.selectCate = selectCat ;
                        });
                      },
                      child: Card(
                        color: selectCat ==
                            _categoriesDeposit['responseBody'][index]
                            ['category_name']
                                .toString()
                            ? Colors.blueAccent
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Container(
                          child: Column(
                             children: [
                               Text(_categoriesDeposit['responseBody'][index]
                          ['category_id'], style: TextStyle(fontSize: 10),),
                               Text(
                                 _categoriesDeposit['responseBody'][index]
                                 ['category_name'],
                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize:12),
                               ),
                               Text(
                                 _categoriesDeposit['responseBody'][index]
                                 ['amount'],
                                 style: TextStyle(fontWeight: FontWeight.bold, fontSize:12),
                               ),
                             ],
                           ),


                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),


        ],

      ),
    );
  }
}
