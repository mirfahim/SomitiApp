
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:somiti/Pages/Admin/AdminPage.dart';
import 'package:somiti/Pages/Admin/ExpenseForm.dart';
import 'package:somiti/Pages/Admin/DepositFormPage.dart';
import 'package:somiti/Variables/Variables.dart';



class AdminPassPopup extends StatefulWidget {
  @override
  _AreYouSureState createState() => _AreYouSureState();
}

class _AreYouSureState extends State<AdminPassPopup> {

  TextEditingController passController = TextEditingController();
  String password = "123";
  String pass;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Warning'),
      content:  Container(
        height: 100,
        child: Form(
          child:  TextFormField(
            controller: passController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Password'),
            validator: (val) => val.length == 0 ? 'Enter Pass' : null,
            //onSaved: (val) => pass = val,
          ),

        ),
      ),
      actions: <Widget>[

        FlatButton(
          child: Text("Go"),
          onPressed: (){

            print("$passController");
            print("$password");
            print("${Variables.password}THIS_IS__________PASS");
            if(Variables.password == passController.text){
              print("HOCHEE>>>>>>");
              Navigator.of(context).push(new CupertinoPageRoute(
                  builder: (context) => AdminPage()));
            }else{
              print("FIHAAAAAAAAAAAAAA>>>>>>");
              Navigator.of(context).pop(false);
            }

          },
        ),
        FlatButton(
          child: Text('no'),
          onPressed: (){
            Navigator.of(context).pop(false);
          },
        ),

      ],

    );
  }
}