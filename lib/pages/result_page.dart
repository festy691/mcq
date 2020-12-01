import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcq_cbt/models/question_model.dart';
import 'package:mcq_cbt/pages/review_page.dart';

class ResultPage extends StatefulWidget {
  List<QuestionModel> questionList;
  int score;

  ResultPage(this.questionList, this.score);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  int attempt = 0;
  num score = 0;
  int wrong = 0;

  void calcAttempt(){
    score = (widget.score / 10) * 100;
    wrong = 10 - widget.score;
    for(int i=0; i<widget.questionList.length; i++){
      if(widget.questionList[i].selected != null){
        attempt = attempt + 1;
      }
    }
    setState(() {
      attempt = attempt;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calcAttempt();
  }
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
          child: Center(
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              child: Container(
                height: _height * 0.7,
                width: _width * 0.8,
                color: Colors.white,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text('Test Result', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 24.0, fontWeight: FontWeight.bold),)),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Questions', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 18.0, fontWeight: FontWeight.bold),),
                          Text('10', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 18.0, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Attempt', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 18.0, fontWeight: FontWeight.bold),),
                          Text('${attempt}', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 18.0, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Correct', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 18.0, fontWeight: FontWeight.bold),),
                          Text('${widget.score}', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 18.0, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Wrong', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 18.0, fontWeight: FontWeight.bold),),
                          Text('${wrong}', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 18.0, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Score', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 18.0, fontWeight: FontWeight.bold),),
                          Text('${score}', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 18.0, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),

                    SizedBox(height: 30,),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MaterialButton(
                        height: 45,
                        elevation: 0.0,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>  ReviewPage(widget.questionList)
                          ));
                        },
                        child: Text(
                          "Review Test",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        color: Color(0xFF00642B),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MaterialButton(
                        elevation: 0.0,
                        height: 45,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "End Test",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
