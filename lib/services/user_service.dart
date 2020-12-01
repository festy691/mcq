import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:mcq_cbt/models/api_response.dart';
import 'package:mcq_cbt/models/user_model.dart';
import 'package:mcq_cbt/utils/shared_preference.dart';

final auth = prefs.getString('auth-token');

class UserService{
  static const API = 'https://ubth-cbt.herokuapp.com/api/v1';
  static var headers = {
    'Authorization' : 'bearer ${auth}',
    'Content-Type' : 'application/json'
  };
  static const header = {
    'Content-Type' : 'application/json'
  };

  Future<APIResponse<List<UserModel>>> getUsersList(){
    return http.get(API+'/users',headers: headers)
        .then((data) {
      if (data.statusCode == 200){
        final jsonBody = json.decode(data.body);
        final users = <UserModel>[];

        for (var user in jsonBody){
          users.add(UserModel.fromJson(user));
        }
        return APIResponse<List<UserModel>>(data: users);
      }
      return APIResponse<List<UserModel>>(error: true, message: data.body.toString());
    }).catchError((error){
      print(error);
      return APIResponse<List<UserModel>>(error: true, message: error.toString());
    });
  }

  Future<APIResponse<UserModel>> getMyProfile(){
    return http.get(API+"/authenticate",headers: headers)
        .then((data) {
      if (data.statusCode == 200){
        final jsonBody = json.decode(data.body);
        final user = UserModel.fromJson(jsonBody);

        return APIResponse<UserModel>(data: user);
      }
      final jsonBody = data.body;
      return APIResponse<UserModel>(error: true, message: jsonBody.toString());
    }).catchError((error){
      return  APIResponse<UserModel>(error: true, message: error.toString());
    });
  }

  Future<APIResponse<String>> createUser(UserModel user){
    return http.post(API+'/users', headers: header, body: json.encode(user.toJson()))
    .then((data) {
        if (data.statusCode == 200){
          return APIResponse<String>(data: data.body);
        }
        final jsonBody = data.body;
        print(jsonBody);
        return APIResponse<String>(error: true, message: jsonBody.toString());
      }).catchError((error) {
        print(error);
        return APIResponse<String>(error: true, message: error.toString());
    });
  }

  Future<APIResponse<String>> uploadImage(String id, File fileImage) async {
    var postUri = Uri.parse(API+'/users/${id}');

    var request = new http.MultipartRequest("PUT", postUri);
    request.headers['Authorization'] = 'bearer ${auth}';
    final file = await http.MultipartFile.fromPath('image', fileImage.path,
        contentType: new MediaType('image', 'jpeg'));
    //request.files.add(new http.MultipartFile.fromPath('image', await fileImage.path, contentType: new MediaType('image', 'jpeg')));
    request.files.add(file);

    try{
      var result = await request.send();
      final respStr = await result.stream.bytesToString();
      if (result.statusCode == 200) {
        return APIResponse<String>(error: false, message: respStr);
      }
      print(respStr);
      print(result.statusCode);
      return APIResponse<String>(error: true, message: respStr);
    }
    catch(error){
      print(error);
      return APIResponse<String>(error: true, message: error.toString());
    }
  }

  Future<APIResponse<UserModel>> updateUser(UserModel user, String id){
    return http.put(API+'/users/${id}',headers: headers, body: json.encode(user.toJson()))
        .then((data) {
      if (data.statusCode == 200 || data.statusCode == 201){
        return APIResponse<UserModel>(error: false, message: data.body.toString());
      }
      return APIResponse<UserModel>(error: true, message: data.body.toString());
    }).catchError((error){
      return APIResponse<UserModel>(error: true, message: error.toString());
    });
  }

  Future<APIResponse<UserModel>> deleteUser(String id){
    return http.delete(API+'/users/${id}',headers: headers,)
        .then((data) {
      if (data.statusCode == 200){
        return APIResponse<UserModel>(error: false, message: data.body.toString());
      }
      return APIResponse<UserModel>(error: true, message: data.body.toString());
    }).catchError((error){
      return APIResponse<UserModel>(error: true, message: error.toString());
    });
  }

  Future<APIResponse<String>> loginUser(String email, String password){
    print(email+ ' ' + password);
    return http.post(API+'/users/login', headers: header, body: json.encode({"email": email, "password": password}))
    .then((data) {
        if (data.statusCode == 200 || data.statusCode == 201){
          final jsonBody = json.decode(data.body);
          prefs.setString('auth-token',jsonBody['token']);
          return APIResponse<String>(error: false, data: jsonBody.toString());
        }
        final jsonBody = data.body;
        print(jsonBody.toString());
        return APIResponse<String>(error: true, message: jsonBody.toString());
      }).catchError((error){
        print(error);
        return APIResponse<String>(error: true, message: error.toString());
    });
  }

  Future<APIResponse<String>> forgotPassword(String email){
    return http.post(API+'/users/forgotpassword', headers: header, body: json.encode({"email": email}))
        .then((data) {
      if (data.statusCode == 200 || data.statusCode == 201){
        return APIResponse<String>(data: data.body.toString());
      }
      final jsonBody = data.body;
      return APIResponse<String>(error: true, message: jsonBody.toString());
    }).catchError((error){
      return APIResponse<String>(error: true, message: error.toString());
    });
  }

  Future<APIResponse<String>> completeResetPassword(String email, String code){
    return http.post(API+'/users/resetpassword', headers: header, body: json.encode({"email": email, "resetPasswordToken":code}))
        .then((data) {
      if (data.statusCode == 200 || data.statusCode == 201){
        final jsonBody = json.decode(data.body);
        prefs.setString('auth-token',jsonBody['token']);
        return APIResponse<String>(data: data.body.toString());
      }
      final jsonBody = data.body;
      return APIResponse<String>(error: true, message: jsonBody.toString());
    }).catchError((error){
      return APIResponse<String>(error: true, message: error.toString());
    });
  }

  Future<APIResponse<String>> resendVerificatonCode(String email){
    return http.post(API+'/users/verifyemail', headers: header, body: json.encode({"email": email}))
        .then((data) {
      print(data.body);
      if (data.statusCode == 200 || data.statusCode == 201){
        return APIResponse<String>(data: data.body.toString());
      }
      final jsonBody = data.body;
      return APIResponse<String>(error: true, message: jsonBody.toString());
    }).catchError((error){
      print(error);
      return APIResponse<String>(error: true, message: error.toString());
    });
  }

  Future<APIResponse<String>> completeEmailVerification(String email, String code){
    return http.post(API+'/users/activate', headers: header, body: json.encode({"email": email, "verificationCode":code}))
        .then((data) {
      if (data.statusCode == 200 || data.statusCode == 201){
        final jsonBody = json.decode(data.body);
        prefs.setString('auth-token',jsonBody['token']);
        return APIResponse<String>(data: data.body.toString());
      }
      final jsonBody = data.body;
      return APIResponse<String>(error: true, message: jsonBody.toString());
    }).catchError((error){
      return APIResponse<String>(error: true, message: error.toString());
    });
  }

  Future<APIResponse<String>> changePassword(String id, String oldPassword,String newPassword){
    return http.put(API+'/users/updatepassword/${id}', headers: headers, body: json.encode({"oldPassword": oldPassword,"newPassword": newPassword}))
        .then((data) {
      if (data.statusCode == 200 || data.statusCode == 201){
        return APIResponse<String>(data: data.body.toString());
      }
      final jsonBody = data.body;
      return APIResponse<String>(error: true, message: jsonBody.toString());
    }).catchError((error){
      return APIResponse<String>(error: true, message: error.toString());
    });
  }

  Future<APIResponse<String>> logOut(){
    print('clicked');
    return http.post(API+'/users/logout', headers: headers)
        .then((data) {
      if (data.statusCode == 200 || data.statusCode == 201){
        prefs.remove('auth-token');
        print(data.body.toString());
        return APIResponse<String>(error: false, data: data.body.toString());
      }
      print(data.body.toString());
      final jsonBody = data.body;
      return APIResponse<String>(error: true, message: jsonBody.toString());
    }).catchError((error){
      print(error.toString());
      return APIResponse<String>(error: true, message: error.toString());
    });
  }
}