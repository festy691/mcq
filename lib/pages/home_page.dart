import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcq_cbt/pages/edit_profile_page.dart';
import 'package:mcq_cbt/pages/free_instruction_page.dart';
import 'package:mcq_cbt/pages/pick_subject_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _navPosition = 0;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _height = _size.height;
    final _width = _size.width;
    return Scaffold(
      backgroundColor: Color(0xFF00642B),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: _width,
          height: _height,
          child: Stack(
            children: [
              if(_navPosition == 0) homePage(context),
              if(_navPosition == 1) profilePage(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navPosition,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home, color: Color(0xFF00642B),),
            icon: Icon(Icons.home, color: Colors.grey[400],),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.info, color: Colors.white,),
            icon: Icon(Icons.info, color: Colors.white,),
            title: Text('',style: TextStyle(color: Colors.white),),
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.info, color: Color(0xFF00642B),),
            icon: Icon(Icons.info, color: Colors.grey[400],),
            title: Text('About'),
          ),
        ],
        onTap: (index){
          setState(() {
            _navPosition = index;
          });
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 70.0,
          height: 70.0,
          child: FloatingActionButton(
            onPressed: (){
              setState(() {
                _navPosition = 1;
              });
            },
            elevation: 1.0,
            backgroundColor: Color(0xFF00642B),
            child: Container(
                width: 70.0,
                height: 70.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 4.0),
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFF00642B),
                        Color(0xFF187A41),
                        Color(0xFF308F56),
                        Color(0xFF48A56C),
                      ]
                  ),
                ),
                child: Icon(Icons.person, color: Colors.white,)),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget homePage(BuildContext context){
    final _size = MediaQuery.of(context).size;
    final _height = _size.height;
    final _width = _size.width;
    return Container(
        height: _height,
        width: _width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF00642B),
                Color(0xFF187A41),
                Color(0xFF308F56),
                Color(0xFF48A56C),
              ]
          ),
        ),
      child: Stack(
        children: [

          Image(
            width: _width,
            height: _height * 0.5,
            image: AssetImage('asset/images/home_vector.png'),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topCenter,
                child: Text('UBTH MCQ', style: GoogleFonts.adamina(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 32.0, right: 32.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text('Practise questions for Department of surgery, UBTH MCQ for resident doctors', style: GoogleFonts.adamina(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),),
            ),
          ),

          DraggableScrollableSheet(
            builder: (context, scrollController){
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Choose Practise type', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 24.0, fontWeight: FontWeight.bold),),

                          LimitedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>  PickSubjectPage()
                                    ));
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    child: Container(
                                      width: 100.0,
                                      height: 100.0,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.timer, color: Color(0xFF00642B),),
                                          Text('Timed Test', style: GoogleFonts.adamina(fontSize: 14.0, color: Color(0xFF00642B), fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>  FreeInstructionPage()
                                    ));
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    child: Container(
                                      width: 100.0,
                                      height: 100.0,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.lock_open, color: Color(0xFF00642B),),
                                          Text('Free Test', style: GoogleFonts.adamina(fontSize: 14.0, color: Color(0xFF00642B), fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: MaterialButton(
                              height: 45,
                              minWidth: 240,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0)),
                              onPressed: () {},
                              child: Text(
                                "Study Materials",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                              color: Color(0xFF00642B),
                            ),
                          ),
                        ]
                    ),
                  ),
                  controller: scrollController,
                ),
              );
            },
            initialChildSize: 0.45,
            minChildSize: 0.45,
            maxChildSize: 0.7,
          ),
        ],
      ),
    );
  }

  Widget profilePage(BuildContext context){
    final _size = MediaQuery.of(context).size;
    final _height = _size.height;
    final _width = _size.width;
    return Container(
      height: _height,
      width: _width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('asset/images/logo.png'), fit: BoxFit.contain
        )
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
          child: Stack(
            children: [
              Container(
                height: _height * 0.25,
                width: _width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFF00642B),
                        Color(0xFF187A41),
                        Color(0xFF308F56),
                        Color(0xFF48A56C),
                      ]
                  ),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('My Profile', style: GoogleFonts.adamina(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),),
                    )),
              ),

              Positioned(
                top: _height * 0.15,
                left: 16.0,
                child: Container(
                  height: _width * 0.3,
                  width: _width * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF00642B), width: 4.0),
                    image: DecorationImage(image: AssetImage('asset/images/no_image.png'), fit: BoxFit.cover),
                  ),
                ),
              ),

              Positioned(
                top: _height * 0.18,
                right: 16.0,
                child: MaterialButton(
                  elevation: 0.2,
                  height: 45,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(4.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>  EditProfilePage()
                    ));
                  },
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  color: Color(0xFF00642B),
                ),
              ),

              Positioned(
                top: (_height * 0.17) + (_width * 0.3),
                child: Container(
                  height: _height - (_height * 0.17) + (_width * 0.3),
                  width: _width,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Name', style: GoogleFonts.roboto(fontSize: 20.0, fontWeight: FontWeight.bold),),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListTile(
                          leading: Icon(Icons.email),
                          title: Text('Email', style: GoogleFonts.roboto(fontSize: 20.0, fontWeight: FontWeight.bold),),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListTile(
                          leading: Icon(Icons.phone),
                          title: Text('Phone Number', style: GoogleFonts.roboto(fontSize: 20.0, fontWeight: FontWeight.bold),),
                        ),
                      ),

                      LimitedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text('Best Score', style: GoogleFonts.roboto(color: Colors.black54, fontSize: 14.0),),

                                  Material(
                                    elevation: 2.0,
                                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      color: Color(0xFF0BE6BA),
                                      child: Center(child: Text('80', style: GoogleFonts.roboto(color: Colors.white, fontSize: 22.0),)),
                                    ),
                                  ),
                                ],
                              ),

                              Column(
                                children: [
                                  Text('Average Score', style: GoogleFonts.roboto(color: Colors.black54, fontSize: 14.0),),

                                  Material(
                                    elevation: 2.0,
                                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      color: Color(0xFFE5BD0C),
                                      child: Center(child: Text('65', style: GoogleFonts.roboto(color: Colors.white, fontSize: 22.0),)),
                                    ),
                                  ),
                                ],
                              ),

                              Column(
                                children: [
                                  Text('Total Trials', style: GoogleFonts.roboto(color: Colors.black54, fontSize: 14.0),),

                                  Material(
                                    elevation: 2.0,
                                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      color: Color(0xFF870BE6),
                                      child: Center(child: Text('13', style: GoogleFonts.roboto(color: Colors.white, fontSize: 22.0),)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
