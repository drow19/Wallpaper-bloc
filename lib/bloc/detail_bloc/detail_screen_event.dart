import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

abstract class DetailScreenEvent extends Equatable {}

class SavedImage extends DetailScreenEvent {
  BuildContext context;
  String img;

  SavedImage({@required this.context, this.img});

  @override
  List<Object> get props => [context, img];
}
