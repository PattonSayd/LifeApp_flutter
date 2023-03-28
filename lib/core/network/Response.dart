class CustomResponse<T> {
  late T data;
  String? message;
  Status? status;

  CustomResponse.initial() : status = Status.INITIAL;
  CustomResponse.loading() : status = Status.LOADING;
  CustomResponse.completed(this.data) : status = Status.COMPLETED;
  CustomResponse.error(this.data) : status = Status.ERROR;

  @override
  String toString() => "Status : $status \n Message : $message \n Data : $data";
}

enum Status { LOADING, COMPLETED, ERROR, INITIAL }
