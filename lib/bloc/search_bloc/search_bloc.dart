import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutterblocwallpaper/bloc/search_bloc/search_event.dart';
import 'package:flutterblocwallpaper/bloc/search_bloc/search_state.dart';
import 'package:flutterblocwallpaper/data/model/main_model.dart';
import 'package:flutterblocwallpaper/data/repository/category_repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  CategoryRepo categoryRepo;

  SearchBloc({@required this.categoryRepo});

  @override
  SearchState get initialState => IsLoadingState();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is FetchData) {
      yield IsLoadingState();
      try {
        List<ImageModel> data = await categoryRepo.getData(event.query, '30');
        yield IsLoadedState(list: data);
      } catch (e) {
        print("print error: $e");
        yield ErrorState(message: e.toString());
      }
    }
    if (event is OnScrollEvent) {
      try {
        List<ImageModel> data =
            await categoryRepo.getData(event.query, event.page);
        yield IsLoadedState(list: data);
      } catch (e) {
        print("print error: $e");
        yield ErrorState(message: e.toString());
      }
    }
  }
}
