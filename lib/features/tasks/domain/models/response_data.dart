import 'package:equatable/equatable.dart';

class ResponseData<T> extends Equatable {
  final int status;
  final T? data;
  final int? revision;

  const ResponseData(this.status, this.data, this.revision);

  factory ResponseData.error(int status) => ResponseData(status, null, null);

  @override
  List<Object?> get props => [status, data, revision];
}
