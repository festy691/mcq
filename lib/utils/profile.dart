
import 'package:get_it/get_it.dart';
import 'package:mcq_cbt/models/user_model.dart';
import 'package:mcq_cbt/services/user_service.dart';
import 'package:mcq_cbt/utils/shared_preference.dart';

UserService get profileService => GetIt.I<UserService>();

getDetails() async{

  final auth = await prefs.getString('auth-token');

  id = null;
  firstName = null;
  lastName = null;
  email = null;
  phonenumber = null;
  image = null;

  if(auth != null){

    final result = await profileService.getMyProfile();

    if(result.error) getDetails();

    UserModel user = result.data;

    id = user.id;
    firstName = user.firstName;
    lastName = user.lastName;
    email = user.email;
    phonenumber = user.phonenumber;
    image = user.image;

  }
}

String id;
String firstName;
String lastName;
String email;
String phonenumber;
String image;