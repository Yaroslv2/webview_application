import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:webview_application/application/models/exercise_model.dart';

part 'exersices_event.dart';
part 'exersices_state.dart';

class ExersicesBloc extends Bloc<ExersicesEvent, ExersicesState> {
  ExersicesBloc() : super(ExersicesState.initial()) {
    on<_LoadExersices>(_loadExersices);
  }

  Future _loadExersices(
      _LoadExersices event, Emitter<ExersicesState> emit) async {
    emit(state.copyWith(state: ExersicesStateEnum.loading));
    try {
      final String response =
          await rootBundle.loadString("assets/jsons/exersices.json");
      final data = await json.decode(response);
      emit(
        state.copyWith(
          list: List<ExersiceModel>.from(
              data.map((i) => ExersiceModel.fromJson(i))).toList(),
          state: ExersicesStateEnum.success,
        ),
      );
    } catch (e) {
      print(e);
      emit(
        state.copyWith(
          state: ExersicesStateEnum.error,
          errorMessaage: "Cath error...",
        ),
      );
      print(state.state);  
    }
    print(state.state);
  }
}
