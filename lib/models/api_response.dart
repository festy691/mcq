class APIResponse<T>{
  T data;
  bool error;
  String message;
  String pages;

  APIResponse({this.data, this.error=false, this.message, this.pages});
}