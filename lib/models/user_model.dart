class UserModel{
  String id;
  String firstName;
  String lastName;
  String email;
  String phonenumber;
  String image;
  String level;
  String password;
  num highscore;
  num average;
  num attempts;

  UserModel(
      {
        this.id,
        this.firstName,
        this.lastName,
        this.phonenumber,
        this.email,
        this.image,
        this.level,
        this.highscore,
        this.average,
        this.attempts,
      }
  );

  factory UserModel.fromJson(Map<String, dynamic> data){
    return UserModel(
      id: data['_id'],
      image: data['image'],
      firstName: data['firstname'],
      lastName: data['lastname'],
      email: data['email'],
      phonenumber: data['phonenumber'],
      level: data['level'],
      highscore: data['highscore'],
      average: data['average'],
      attempts: data['attempts'],
    );
  }

  toJson() {
    return {
      "firstname": firstName,
      "lastname": lastName,
      "email": email,
      "phonenumber": phonenumber,
      "password": password,
    };
  }
}