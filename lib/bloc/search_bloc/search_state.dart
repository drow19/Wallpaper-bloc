import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutterblocwallpaper/data/model/main_model.dart';

abstract class SearchState extends Equatable {

}

class IsLoadingState extends SearchState {
  @override
  List<Object> get props => [];

}

class IsLoadedState extends SearchState {
  List<ImageModel> list;
  IsLoadedState({@required this.list});

  @override
  List<Object> get props => [list];

}

class ErrorState extends SearchState {

  String message;
  ErrorState({@required this.message});

  @override
  List<Object> get props => [message];

}