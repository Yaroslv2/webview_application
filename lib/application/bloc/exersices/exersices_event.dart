part of 'exersices_bloc.dart';

abstract class ExersicesEvent {
  const ExersicesEvent();

  factory ExersicesEvent.loadExersices() => _LoadExersices();
}

class _LoadExersices extends ExersicesEvent {}
