class RepositoriesResponse {
  final bool isSuccess;
  int? statusCode;
  final dynamic dataResponse;

  RepositoriesResponse({required this.isSuccess, this.statusCode, required this.dataResponse});
}
