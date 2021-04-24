

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:somiti/Pages/Admin/ExpenseForm.dart';
import 'package:somiti/Pages/Admin/DepositFormPage.dart';
import 'package:somiti/Pages/ExpenseList.dart';
import 'package:somiti/Pages/HomePages.dart';
import 'package:somiti/Pages/depostList.dart';

import 'Alert_popup/DepositPoppup.dart';
import 'Alert_popup/AdminPassPopup.dart';


class MyDrawer extends StatelessWidget {

  int pass = 123456;
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: Container(

        child: ListView(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                ],
              ),
              padding: EdgeInsets.only(top: 35, bottom: 10),


            ),
            SizedBox(height: 12.0,),
            Container(
              padding: EdgeInsets.only(top: 1),

              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.home, color: Colors.black,),
                    title: Text("Home", style: TextStyle(color: Colors.black, ),),
                    onTap: (){

                      Route route = MaterialPageRoute(builder: (c) => HomePage());
                      Navigator.pushReplacement(context, route);
                    },
                  ),
                  Divider(height: 10,color: Colors.white,thickness: 6.0,),

                  Divider(height: 10,color: Colors.white,thickness: 6.0,),
                  ListTile(
                    leading: Icon(Icons.dashboard, color: Colors.black,),
                    title: Text("Deposit List", style: TextStyle(color: Colors.black, ),),
                    onTap: (){
                      Route route = MaterialPageRoute(builder: (c) => Deposit());
                      Navigator.pushReplacement(context, route);
                    },
                  ),

                  Divider(height: 10,color: Colors.white,thickness: 6.0,),
                  ListTile(
                    leading: Icon(Icons.money_off, color: Colors.black,),
                    title: Text("Expense List", style: TextStyle(color: Colors.black, ),),
                    onTap: (){
                      showDialog(
                        context: context,
                        builder:(_)=> ExpenseList(),
                      );
                    },
                  ),

                  Divider(height: 10,color: Colors.white,thickness: 6.0,),
                  ListTile(
                    leading: Icon(Icons.admin_panel_settings_outlined, color: Colors.black,),
                    title: Text("Admin", style: TextStyle(color: Colors.black, ),),
                    onTap: (){
                      showDialog(
                        context: context,
                        builder:(_)=> AdminPassPopup(),
                      );
                    },
                  ),


                  // Divider(height: 10,color: Colors.white,thickness: 6.0,),
                  //
                  // ListTile(
                  //   leading: Icon(Icons.home, color: Colors.white,),
                  //   title: Text("FTT", style: TextStyle(color: Colors.white, ),),
                  //   onTap: (){
                  //     Navigator.push(
                  //         context,
                  //         new MaterialPageRoute(
                  //             builder: (BuildContext context) => FttOperation()));
                  //   },
                  // ),
                  // Divider(height: 10,color: Colors.white,thickness: 6.0,),
                  //
                  // ListTile(
                  //   leading: Icon(Icons.home, color: Colors.white,),
                  //   title: Text("Graphic", style: TextStyle(color: Colors.white, ),),
                  //   onTap: (){
                  //     Route route = MaterialPageRoute(builder: (c) => CanvasPainting());
                  //     Navigator.pushReplacement(context, route);
                  //   },
                  // ),
                  // Divider(height: 10,color: Colors.white,thickness: 6.0,),



                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
