import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  TextEditingController _oldPass = new TextEditingController();
  TextEditingController _newPass = new TextEditingController();
  TextEditingController _conNewPass = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool _isLoading = false;
  bool _isLoadingImg = false;

  var _formKey = GlobalKey<FormState>();

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _height = _size.height;
    final _width = _size.width;
    var textStyle = GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 18.0);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF00642B),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Color(0xFF00642B),), onPressed: (){
          Navigator.of(context).pop();
        },),
        title: Center(child: Text('Change Password', style: GoogleFonts.adamina(color: Color(0xFF00642B)),)),
        actions: [
          SizedBox(width: 50.0,),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: _width,
          height: _height,
          decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage('asset/images/logo.png'), fit: BoxFit.contain
              )
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              child: ListView(
                children: [

                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Form(
                      key: _formKey,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            SizedBox(height: 64.0,),

                            TextFormField(
                              style: textStyle,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'Old Password',
                                labelText: 'Old Password',
                              ),
                              controller: _oldPass,
                              obscureText: true,
                              validator: (value){
                                if(value.isEmpty) return 'Enter Old Password';
                              },
                            ),

                            SizedBox(height: 32.0,),

                            TextFormField(
                              style: textStyle,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'New Password',
                                labelText: 'New Password',
                              ),
                              controller: _newPass,
                              obscureText: true,
                              validator: (value){
                                if(value.isEmpty) return 'Enter New Password';
                              },
                            ),
                            SizedBox(height: 32.0,),

                            TextFormField(
                              style: textStyle,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'Confirm New Password',
                                labelText: 'Confirm New Password',
                              ),
                              controller: _conNewPass,
                              obscureText: true,
                              validator: (value){
                                if(value.isEmpty) return 'Confirm New Password';
                              },
                            ),

                            SizedBox(height: 32.0,),


                            _isLoading ?
                            CupertinoActivityIndicator(
                              radius: 24.0,
                            )
                                :
                            Container(
                              height: 50.0,
                              width: MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                color: Color(0xFF00642B),
                                child: Text('Update', style: GoogleFonts.adamina(color: Colors.white),),
                                elevation: 2.0,
                                onPressed: () async {
                                  if (_formKey.currentState.validate()){

                                  }
                                },
                              ),
                            ),

                            SizedBox(height: 32.0,),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context, String message){
    var snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(label: "Ok", onPressed: (){
        _scaffoldKey.currentState.hideCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
      }),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

}
