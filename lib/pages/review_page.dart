import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcq_cbt/models/question_model.dart';

class ReviewPage extends StatefulWidget {

  List<QuestionModel> questionList;

  ReviewPage(this.questionList);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {

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
        title: Center(child: Text('Test Review', style: GoogleFonts.adamina(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)),
        actions: [
          Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Text('Close', style: GoogleFonts.adamina(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
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
              maxHeight: _height - 200,
              child: questionCard(context),
            ),
          ),
        ],
      ),
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
                      child: Container(
                        width: 240,
                        decoration: BoxDecoration(
                            color: model.answer == 1 ? Colors.green : model.selected == 1 ? Colors.red : Colors.white,
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

                    SizedBox(
                      height: 10.0,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Container(
                        width: 240,
                        decoration: BoxDecoration(
                            color: model.answer == 2 ? Colors.green : model.selected == 2 ? Colors.red : Colors.white,
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

                    SizedBox(
                      height: 10.0,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Container(
                        width: 240,
                        decoration: BoxDecoration(
                            color: model.answer == 3 ? Colors.green : model.selected == 3 ? Colors.red : Colors.white,
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

                    SizedBox(
                      height: 10.0,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Container(
                        width: 240,
                        decoration: BoxDecoration(
                            color: model.answer == 4 ? Colors.green : model.selected == 4 ? Colors.red : Colors.white,
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
