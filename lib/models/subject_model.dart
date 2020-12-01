class SubjectModel{
  String id;
  String name;
  String image;

  SubjectModel(
      {
        this.id,
        this.name,
        this.image,
      }
      );

  factory SubjectModel.fromJson(Map<String, dynamic> data){
    return SubjectModel(
      id: data['_id'],
      image: data['image'],
      name: data['name'],
    );
  }
}