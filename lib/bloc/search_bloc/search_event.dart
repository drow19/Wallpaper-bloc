import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class SearchEvent extends Equatable {}

class FetchData extends SearchEvent {
  String query;

  FetchData({@required this.query});

  @override
  List<Object> get props => [query];
}

class OnScrollEvent extends SearchEvent {
  String query;
  String page;

  OnScrollEvent({@required this.page, this.query});

  @override
  List<Object> get props => [query, page];

}
