part of 'exersices_bloc.dart';

class ExersicesState extends Equatable {
  final List<ExersiceModel> list;
  final String? errorMessaage;
  final ExersicesStateEnum state;

  ExersicesState({required this.list, this.errorMessaage, required this.state});

  factory ExersicesState.initial() => ExersicesState(
        list: [],
        state: ExersicesStateEnum.unknown,
      );

  ExersicesState copyWith({
    List<ExersiceModel>? list,
    String? errorMessaage,
    ExersicesStateEnum? state,
  }) =>
      ExersicesState(
        list: list ?? this.list,
        errorMessaage: errorMessaage ?? this.errorMessaage,
        state: state ?? this.state,
      );

  @override
  List<Object> get props => [
        list,
      ];
}

enum ExersicesStateEnum {
  unknown,
  loading,
  success,
  error,
}
