import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcq_cbt/models/question_model.dart';
import 'package:mcq_cbt/pages/result_page.dart';

class TestPage extends StatefulWidget {

  List<QuestionModel> questionList;

  TestPage(this.questionList);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  int score = 0;

  Timer _timer;
  int _start = 60;
  int _mins = 9;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
              if (_mins > 0 || _start > 0) {
                if (_start < 1) {
                  if (_mins == 0) timer.cancel();

                  _mins -= 1;
                  _start = 59;
                } else {
                  _start = _start - 1;
                }
              }
              else{
                timer.cancel();
                if(widget.questionList.length > 10){
                  for(int i=0; i<10; i++){
                    if(widget.questionList[i].answer == widget.questionList[i].selected) score = score + 1;
                  }
                }
                else{
                  for(int i=0; i<widget.questionList.length; i++){
                    if(widget.questionList[i].answer == widget.questionList[i].selected) score = score + 1;
                  }
                }

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>  ResultPage(widget.questionList, score)
                ));
              }
            },
          ),
      );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  bool quit = false;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final _height = _size.height;
    final _width = _size.width;

    return Scaffold(
      backgroundColor: Color(0xFF00642B),
      appBar: AppBar(
        backgroundColor: Color(0xFF00642B),
        leading: SizedBox(width: 50,),
        elevation: 0.0,
        title: Center(child: Text(_start < 10 ? '${_mins}:0${_start}' :'${_mins}:${_start}', style: GoogleFonts.adamina(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)),
        actions: [
          Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("End Test"),
                      content: Text('Are you sure'),
                      actions: [
                        FlatButton(
                          onPressed: ()=>{
                            Navigator.of(context).pop()
                          },
                          child: Text("No"),
                        ),
                        FlatButton(
                          onPressed: (){
                            if(widget.questionList.length > 10){
                              for(int i=0; i<10; i++){
                                if(widget.questionList[i].answer == widget.questionList[i].selected) score = score + 1;
                              }
                            }
                            else{
                              for(int i=0; i<widget.questionList.length; i++){
                                if(widget.questionList[i].answer == widget.questionList[i].selected) score = score + 1;
                              }
                            }

                            quit = true;
                            Navigator.of(context).pop();
                          },
                          child: Text("Yes"),
                        ),
                      ],
                    )
                ).then((data) async {
                  if(quit) Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>  ResultPage(widget.questionList, score)
                  ));
                });

              },
                child: Text('Submit', style: GoogleFonts.adamina(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
            ),
          )),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: _width,
          height: _height,
          child: Stack(
            children: [
              examPage(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget examPage(BuildContext context){
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LimitedBox(
              maxHeight: 50,
                child: questionIndicator(context),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LimitedBox(
              maxHeight: _height - 200,
              child: questionCard(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget questionIndicator(BuildContext context){
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index){
        QuestionModel model = widget.questionList[index];
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: model.selected != null ? Colors.deepOrange : Colors.white,
              border: Border.all(color: Colors.blue, width: 2.0),
              borderRadius: new BorderRadius.circular(20.0)
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text('${index+1}', style: GoogleFonts.roboto(color:  model.selected != null ? Colors.white : Colors.green,  fontSize: 20, fontWeight: FontWeight.bold),),
              ),
            ),
          ),
        );
      },
      itemCount: widget.questionList.length > 10 ? 10 : widget.questionList.length,
    );
  }

  Widget questionCard(BuildContext context){
    final _size = MediaQuery.of(context).size;
    final _height = _size.height;
    final _width = _size.width;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index){
        QuestionModel model = widget.questionList[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 2.0,
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            child: Container(
              height: _height - 220,
              width: _width - 80,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Center(
                      child: Text('${index+1}', style: GoogleFonts.roboto(color: Colors.green,  fontSize: 26, fontWeight: FontWeight.bold),),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(model.question, style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 18.0, fontWeight: FontWeight.bold),),
                    ),

                    SizedBox(
                      height: 20.0,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            model.selected = 1;
                          });
                        },
                        child: Container(
                          width: 240,
                          decoration: BoxDecoration(
                              color: model.selected == 1 ? Color(0xFF00642B) : Colors.white,
                            border: Border.all(color: model.selected == 1 ? Colors.white : Color(0xFF00642B), width: 2.0),
                            borderRadius: new BorderRadius.circular(18.0)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              model.option1,
                              style: TextStyle(
                                fontSize: 18,
                                color: model.selected == 1 ? Colors.white : Color(0xFF00642B),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10.0,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            model.selected = 2;
                          });
                        },
                        child: Container(
                          width: 240,
                          decoration: BoxDecoration(
                              color: model.selected == 2 ? Color(0xFF00642B) : Colors.white,
                              border: Border.all(color: model.selected == 2 ? Colors.white : Color(0xFF00642B), width: 2.0),
                              borderRadius: new BorderRadius.circular(18.0)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              model.option2,
                              style: TextStyle(
                                fontSize: 18,
                                color: model.selected == 2 ? Colors.white : Color(0xFF00642B),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10.0,
                    ),


                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            model.selected = 3;
                          });
                        },
                        child: Container(
                          width: 240,
                          decoration: BoxDecoration(
                              color: model.selected == 3 ? Color(0xFF00642B) : Colors.white,
                              border: Border.all(color: model.selected == 3 ? Colors.white : Color(0xFF00642B), width: 2.0),
                              borderRadius: new BorderRadius.circular(18.0)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              model.option3,
                              style: TextStyle(
                                fontSize: 18,
                                color: model.selected == 3 ? Colors.white : Color(0xFF00642B),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10.0,
                    ),


                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            model.selected = 4;
                          });
                        },
                        child: Container(
                          width: 240,
                          decoration: BoxDecoration(
                              color: model.selected == 4 ? Color(0xFF00642B) : Colors.white,
                              border: Border.all(color: model.selected == 4 ? Colors.white : Color(0xFF00642B), width: 2.0),
                              borderRadius: new BorderRadius.circular(18.0)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              model.option4,
                              style: TextStyle(
                                fontSize: 18,
                                color: model.selected == 4 ? Colors.white : Color(0xFF00642B),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.0,),

                    model.image != null ? CachedNetworkImage(
                      imageUrl: model.image,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Center(child: CupertinoActivityIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                    :
                    SizedBox(),

                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: widget.questionList.length > 10 ? 10 : widget.questionList.length,
    );
  }
}
