import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mcq_cbt/models/api_response.dart';
import 'package:mcq_cbt/models/question_model.dart';
import 'package:mcq_cbt/models/subject_model.dart';
import 'package:mcq_cbt/utils/shared_preference.dart';

final auth = prefs.getString('auth-token');

class SubjectService{
  static const API = 'https://ubth-cbt.herokuapp.com/api/v1';
  static var headers = {
    'Authorization' : 'bearer ${auth}',
    'Content-Type' : 'application/json'
  };
  static const header = {
    'Content-Type' : 'application/json'
  };

  Future<APIResponse<List<SubjectModel>>> getSubjectList(){
    return http.get(API+'/class',headers: header)
        .then((data) {
      if (data.statusCode == 200){
        final jsonBody = json.decode(data.body);
        final subjects = <SubjectModel>[];

        for (var sub in jsonBody){
          subjects.add(SubjectModel.fromJson(sub));
        }
        return APIResponse<List<SubjectModel>>(data: subjects);
      }
      return APIResponse<List<SubjectModel>>(error: true, message: data.body.toString());
    }).catchError((error){
      print(error);
      return APIResponse<List<SubjectModel>>(error: true, message: error.toString());
    });
  }

  Future<APIResponse<List<QuestionModel>>> getCourseSubjectList(String id){
    return http.get(API+'/questions/subject/${id}',headers: header)
        .then((data) {
      if (data.statusCode == 200){
        final jsonBody = json.decode(data.body);
        final questions = <QuestionModel>[];

        for (var quest in jsonBody){
          questions.add(QuestionModel.fromJson(quest));
        }
        return APIResponse<List<QuestionModel>>(data: questions);
      }
      return APIResponse<List<QuestionModel>>(error: true, message: data.body.toString());
    }).catchError((error){
      print(error);
      return APIResponse<List<QuestionModel>>(error: true, message: error.toString());
    });
  }

  Future<APIResponse<List<QuestionModel>>> getQuestionList(){
    return http.get(API+'/questions',headers: header)
        .then((data) {
      if (data.statusCode == 200){
        final jsonBody = json.decode(data.body);
        final questions = <QuestionModel>[];

        for (var quest in jsonBody){
          questions.add(QuestionModel.fromJson(quest));
        }
        return APIResponse<List<QuestionModel>>(data: questions);
      }
      return APIResponse<List<QuestionModel>>(error: true, message: data.body.toString());
    }).catchError((error){
      print(error);
      return APIResponse<List<QuestionModel>>(error: true, message: error.toString());
    });
  }


}