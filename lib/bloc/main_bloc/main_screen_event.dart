import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class MainScreenEvent extends Equatable{

}

class FetchData extends MainScreenEvent {
  @override
  List<Object> get props => [];

}

class OnScrollPage extends MainScreenEvent {
  String page;
  OnScrollPage({@required this.page});

  @override
  List<Object> get props => [];

}