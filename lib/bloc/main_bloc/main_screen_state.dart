import 'package:equatable/equatable.dart';
import 'package:flutterblocwallpaper/data/model/main_model.dart';
import 'package:meta/meta.dart';

abstract class MainScreenState extends Equatable {}

class IsLoadingState extends MainScreenState {
  @override
  List<Object> get props => [];
}

class IsLoadedState extends MainScreenState {
  List<ImageModel> list;

  IsLoadedState({@required this.list});

  @override
  List<Object> get props => [list];
}

// ignore: must_be_immutable
class ErrorState extends MainScreenState {
  String message;

  ErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}
