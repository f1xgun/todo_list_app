class ResponseData<T> {
  final int status;
  final T? data;
  final int? revision;

  ResponseData(this.status, this.data, this.revision);

  factory ResponseData.error(int status) => ResponseData(status, null, null);
}
