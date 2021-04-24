
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:somiti/Pages/Admin/DepositFormPage.dart';



class AreYouSure extends StatefulWidget {
  @override
  _AreYouSureState createState() => _AreYouSureState();
}

class _AreYouSureState extends State<AreYouSure> {

  TextEditingController passController = TextEditingController();
  String password = 123456.toString();
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
            print("$pass");
            if(password == passController.text){
              print("HOCHEE>>>>>>");
              Navigator.of(context).push(new CupertinoPageRoute(
                  builder: (context) => FormPage()));
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