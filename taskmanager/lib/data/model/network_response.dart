class NetworkResponse{
  final bool isSuccess;
  final int StatusCode;
  dynamic responseData;
  String erroMessage;

  NetworkResponse(
      {required this.isSuccess,
      required this.StatusCode,
      this.responseData,
      this.erroMessage = 'Something went Wrong'});
}