import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mcq_cbt/pages/change_password_page.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _EditProfilePageState extends State<EditProfilePage> {

  AppState state;
  File imageFile;

  TextEditingController _phone = new TextEditingController();
  TextEditingController _fname = new TextEditingController();
  TextEditingController _lname = new TextEditingController();

  @override
  void initState() {
    super.initState();
    state = AppState.free;
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
        title: Center(child: Text('Update Profile', style: GoogleFonts.adamina(color: Color(0xFF00642B)),)),
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
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        if (state == AppState.free) {
                          await _pickImage();

                        }
                        /*else if (state == AppState.picked)
                                          _cropImage();*/
                        else if (state == AppState.cropped) _clearImage();
                      },
                      child: Container(
                        height: _size.width * 0.3,
                        width: _size.width * 0.3,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          height: _size.width * 0.3,
                          width: _size.width * 0.3,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage("asset/images/no_image.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Form(
                      key: _formKey,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            SizedBox(height: 32.0,),

                            TextFormField(
                              style: textStyle,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'First Name',
                                labelText: 'First Name',
                              ),
                              controller: _fname,
                            ),

                            SizedBox(height: 32.0,),

                            TextFormField(
                              style: textStyle,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'Last Name',
                                labelText: 'Last Name',
                              ),
                              controller: _lname,
                            ),
                            SizedBox(height: 32.0,),

                            TextFormField(
                              style: textStyle,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Phone Number',
                                labelText: 'Phone Number',
                              ),
                              controller: _phone,
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

                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>  ChangePasswordPage()
                                  )
                                );
                              },
                              child: Center(
                                child: Text('Change Password', style: GoogleFonts.adamina(color: Color(0xFF00642B)),),
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

  Future<Null> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile  = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      setState(() {
        state = AppState.picked;
      });
      _cropImage();
    }
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.green,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  void _clearImage() {
    imageFile = null;
    setState(() {
      state = AppState.free;
    });
  }
}
