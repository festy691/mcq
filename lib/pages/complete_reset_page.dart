import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompleteResetPage extends StatefulWidget {
  @override
  _CompleteResetPageState createState() => _CompleteResetPageState();
}

class _CompleteResetPageState extends State<CompleteResetPage> {

  TextEditingController _confirm = new TextEditingController();

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

                  SizedBox(height: 16.0,),

                  Center(child: Text('Password Reset', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 28.0, fontWeight: FontWeight.bold),)),

                  SizedBox(height: 32.0,),

                  Center(child: Text('Please enter the code sent to your provided email', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 28.0),)),

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
                                hintText: 'Confirmation Code',
                                labelText: 'Confirmation Code',
                              ),
                              controller: _confirm,
                              validator: (value){
                                if(value.isEmpty) return 'Enter Confirmation Code';
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
                                child: Text('Reset Password', style: GoogleFonts.adamina(color: Colors.white),),
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
