import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcq_cbt/models/api_response.dart';
import 'package:mcq_cbt/models/question_model.dart';
import 'package:mcq_cbt/pages/free_test_page.dart';
import 'package:mcq_cbt/pages/test_page.dart';
import 'package:mcq_cbt/services/subject_service.dart';

class FreeInstructionPage extends StatefulWidget {
  @override
  _FreeInstructionPageState createState() => _FreeInstructionPageState();
}

class _FreeInstructionPageState extends State<FreeInstructionPage> {

  SubjectService get service => GetIt.I<SubjectService>();
  APIResponse<List<QuestionModel>> _apiResponse;

  List<QuestionModel> questionList;

  bool _isLoading = false;

  _fetchTransactions() async {
    if (_apiResponse != null) _apiResponse.data.clear();
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getQuestionList();
    //await prefs.setString("giftcards", GiftcardModel.encodeList(_apiResponse.data));
    if(!_apiResponse.error) questionList = _apiResponse.data;
    questionList.shuffle();
    print(questionList.length);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF00642B),),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        title: Center(child: Text('UBTH MCQ', style: GoogleFonts.adamina(color: Color(0xFF00642B)),)),
        actions: [
          SizedBox(width: 50.0,),
        ],
      ),
      body: ListView(
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text('Instruction', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 24.0, fontWeight: FontWeight.bold),),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('All Courses', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 18.0, fontWeight: FontWeight.bold),),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('This questions are meant for Department of surgery, UBTH MCQ for resident doctors examination preparations', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 18.0, fontWeight: FontWeight.bold),),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('This test is not timed, you can check the answers immediately you pick an option', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 18.0, fontWeight: FontWeight.bold),),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('You can end the test and submit at any moment', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 18.0, fontWeight: FontWeight.bold),),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Click the start button below to start test', style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 18.0, fontWeight: FontWeight.bold),),
          ),

          SizedBox(height: 100.0,),


          _isLoading ?
          Center(child: CupertinoActivityIndicator()) :
          _apiResponse.error ? Center(child: Text(_apiResponse.message, style: GoogleFonts.adamina(color: Color(0xFF00642B), fontSize: 18.0, fontWeight: FontWeight.bold),),)
              :
          Padding(
            padding: const EdgeInsets.all(64),
            child: MaterialButton(
              height: 45,
              minWidth: 240,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0)),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>  FreeTestPage(questionList)
                ));
              },
              child: Text(
                "Start Test",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              color: Color(0xFF00642B),
            ),
          ),
        ],
      ),
    );
  }
}
