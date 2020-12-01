class QuestionModel{
  String id;
  String question;
  String option1;
  String option2;
  String option3;
  String option4;
  int answer;
  int selected;
  String subject;
  String image;


  QuestionModel(
      {
        this.id,
        this.question,
        this.option1,
        this.option2,
        this.option3,
        this.option4,
        this.answer,
        this.selected,
        this.subject,
        this.image
      }
  );

  factory QuestionModel.fromJson(Map<String, dynamic> data){
    return QuestionModel(
      id: data['_id'],
      image: data['image'],
      question: data['question'],
      option1: data['option1'],
      option2: data['option2'],
      option3: data['option3'],
      option4: data['option4'],
      answer: data['answer'],
      subject: data['subject'],
    );
  }
}