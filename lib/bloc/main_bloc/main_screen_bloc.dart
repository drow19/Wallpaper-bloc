import 'package:flutterblocwallpaper/data/model/main_model.dart';
import 'package:flutterblocwallpaper/data/repository/main_repository.dart';
import 'package:bloc/bloc.dart';
import 'main_screen_event.dart';
import 'main_screen_state.dart';
import 'package:meta/meta.dart';

class MainBloc extends Bloc<MainScreenEvent, MainScreenState>{
  MainRepository mainRepository;
  MainBloc({@required this.mainRepository});

  @override
  MainScreenState get initialState => IsLoadingState();

  @override
  Stream<MainScreenState> mapEventToState(MainScreenEvent event) async* {
    if(event is FetchData){
      yield IsLoadingState();
      try{
        List<ImageModel> data = await mainRepository.getData('30');
        print("print : $data");
        yield IsLoadedState(list: data);
      }catch(e){
        print("print error : $e");
        yield ErrorState(message: e.toString());
      }
    }else if(event is OnScrollPage){
      try{
        List<ImageModel> data = await mainRepository.getData(event.page);
        print("print : $data");
        yield IsLoadedState(list: data);
      }catch(e){
        print("print error : $e");
        yield ErrorState(message: e.toString());
      }
    }
  }

}