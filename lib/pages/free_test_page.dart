import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcq_cbt/models/question_model.dart';
import 'package:mcq_cbt/pages/home_page.dart';

class FreeTestPage extends StatefulWidget {

  List<QuestionModel> questionList;

  FreeTestPage(this.questionList);

  @override
  _FreeTestPageState createState() => _FreeTestPageState();
}

class _FreeTestPageState extends State<FreeTestPage> {
  int position = 0;
  int score = 0;
  bool quit = false;
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

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 8,
                  width: double.infinity,
                  child: questionIndicator(context),
                ),
              ),

              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 70.0, 16.0, 16.0),
                  child: SizedBox(
                    height: double.infinity,
                    width: _width,
                    child: questionView(context),
                  ),
                ),
              ),
            ],
          ),
        ),
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
            width: 30.0,
            height: 6.0,
            decoration: BoxDecoration(
                color: model.answer ==  model.selected ?
                Colors.green
                    :
                model.selected != null ?
                Colors.red[900]
                    :
                Colors.grey[400],
            ),
          ),
        );
      },
      itemCount: widget.questionList.length,
    );
  }

  Widget questionView(BuildContext context){
    QuestionModel model = widget.questionList[position];
    final _size = MediaQuery.of(context).size;
    final _height = _size.height;
    final _width = _size.width;
    return Container(
      color: Colors.white,
      width: _width,
      height: _height - 100,
      child: ListView(
        children: [
          Center(
            child: Text('Question ${position + 1} of ${widget.questionList.length}', style: GoogleFonts.roboto(color: Colors.green,  fontSize: 26, fontWeight: FontWeight.bold),),
          ),

          Center(
            child: Text('Score: ${score}', style: GoogleFonts.roboto(color: Colors.green,  fontSize: 26, fontWeight: FontWeight.bold),),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(model.question, style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 18.0, fontWeight: FontWeight.bold),),
          ),

          SizedBox(
            height: 20.0,
          ),


          IgnorePointer(
            ignoring: model.selected == null ? false : true,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: InkWell(
                onTap: (){
                  setState(() {
                    model.selected = 1;
                    if(model.answer == 1) score = score + 1;
                  });
                },
                child: Container(
                  width: 240,
                  decoration: BoxDecoration(
                      color: model.selected == 1 ? Color(0xFF00642B) : Colors.white,
                      border: Border.all(color: model.selected == 1 ? Colors.white : Color(0xFF00642B), width: 2.0),
                      borderRadius: new BorderRadius.circular(8.0)
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
          ),

          SizedBox(
            height: 10.0,
          ),

          IgnorePointer(
            ignoring: model.selected == null ? false : true,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: InkWell(
                onTap: (){
                  setState(() {
                    model.selected = 2;
                    if(model.answer == 2) score = score + 1;
                  });
                },
                child: Container(
                  width: 240,
                  decoration: BoxDecoration(
                      color: model.selected == 2 ? Color(0xFF00642B) : Colors.white,
                      border: Border.all(color: model.selected == 2 ? Colors.white : Color(0xFF00642B), width: 2.0),
                      borderRadius: new BorderRadius.circular(8.0)
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
          ),

          SizedBox(
            height: 10.0,
          ),


          IgnorePointer(
            ignoring: model.selected == null ? false : true,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: InkWell(
                onTap: (){
                  setState(() {
                    model.selected = 3;
                    if(model.answer == 3) score = score + 1;
                  });
                },
                child: Container(
                  width: 240,
                  decoration: BoxDecoration(
                      color: model.selected == 3 ? Color(0xFF00642B) : Colors.white,
                      border: Border.all(color: model.selected == 3 ? Colors.white : Color(0xFF00642B), width: 2.0),
                      borderRadius: new BorderRadius.circular(8.0)
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
          ),

          SizedBox(
            height: 10.0,
          ),


          IgnorePointer(
            ignoring: model.selected == null ? false : true,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: InkWell(
                onTap: (){
                  setState(() {
                    model.selected = 4;
                    if(model.answer == 4) score = score + 1;
                  });
                },
                child: Container(
                  width: 240,
                  decoration: BoxDecoration(
                      color: model.selected == 4 ? Color(0xFF00642B) : Colors.white,
                      border: Border.all(color: model.selected == 4 ? Colors.white : Color(0xFF00642B), width: 2.0),
                      borderRadius: new BorderRadius.circular(8.0)
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

          SizedBox(height: 20.0,),

          model.selected != null ? Center(
            child: Text('The correct answer is option ${model.answer}', style: GoogleFonts.roboto(color: Colors.green,  fontSize: 26, fontWeight: FontWeight.bold),),
          )
              :
          SizedBox(),

          SizedBox(height: 40.0,),

          model.selected != null ? Align(
            alignment: Alignment.centerRight,
            child: MaterialButton(
              color: Colors.green,
              elevation: 0.0,
              onPressed: (){
                setState(() {
                  position = position + 1;
                });
              },
                child: Text('Next Question', style: GoogleFonts.roboto(color: Colors.white,  fontSize: 16,),),
            ),
          )
              :
          SizedBox(),

          SizedBox(height: 16.0,),

          MaterialButton(
            color: Colors.red,
            elevation: 0.0,
            onPressed: (){
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
                          quit = true;
                          Navigator.of(context).pop();
                        },
                        child: Text("Yes"),
                      ),
                    ],
                  )
              ).then((data) async {
                if(quit) Navigator.of(context).pop();
              });
            },
            child: Text('Quit Test', style: GoogleFonts.roboto(color: Colors.white,  fontSize: 16,),),
          ),

          SizedBox(height: 40.0,),

        ],
      ),
    );
  }

}
