

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:somiti/Pages/ExpenseCategory.dart';
import 'package:somiti/Pages/FormPage.dart';
import 'package:somiti/Pages/HomePages.dart';
import 'package:somiti/Pages/depostList.dart';


class MyDrawer extends StatelessWidget {
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
                    title: Text("FormPage", style: TextStyle(color: Colors.black
                      , ),),
                    onTap: (){
                      Route route = MaterialPageRoute(builder: (c) => FormPage());
                      Navigator.pushReplacement(context, route);
                    },
                  ),
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
                    leading: Icon(Icons.dashboard, color: Colors.black,),
                    title: Text("Expense", style: TextStyle(color: Colors.black, ),),
                    onTap: (){
                      Route route = MaterialPageRoute(builder: (c) => ExpenseCategory());
                      Navigator.pushReplacement(context, route);
                    },
                  ),
                  Divider(height: 10,color: Colors.white,thickness: 6.0,),

                  ListTile(
                    leading: Icon(Icons.login_outlined, color: Colors.black,),
                    title: Text("Home", style: TextStyle(color: Colors.black, ),),
                    onTap: ()async{

                      Route route = MaterialPageRoute(builder: (c) => HomePage());
                      Navigator.pushReplacement(context, route);
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
