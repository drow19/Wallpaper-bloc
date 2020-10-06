import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocwallpaper/bloc/detail_bloc/detail_screen_event.dart';
import 'package:flutterblocwallpaper/bloc/detail_bloc/detail_screen_state.dart';
import 'package:flutterblocwallpaper/helper/permission.dart';
import 'package:meta/meta.dart';


class DetailScreenBloc extends Bloc<DetailScreenEvent, DetailScreenState>{
  SavedImagesToGallery savedImagesToGallery;
  DetailScreenBloc({this.savedImagesToGallery});

  @override
  DetailScreenState get initialState => null;

  @override
  Stream<DetailScreenState> mapEventToState(DetailScreenEvent event) async*{
    if(event is SavedImage){
      try {
        var data = await savedImagesToGallery.saveImage(event.context, event.img);
        yield data;
      }catch(e){
        print("print error : $e");
      }
    }
  }

}