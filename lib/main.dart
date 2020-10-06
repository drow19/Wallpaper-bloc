import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocwallpaper/bloc/detail_bloc/detail_screen_bloc.dart';
import 'package:flutterblocwallpaper/bloc/main_bloc/main_screen_bloc.dart';
import 'package:flutterblocwallpaper/bloc/search_bloc/search_bloc.dart';
import 'package:flutterblocwallpaper/data/repository/category_repository.dart';
import 'package:flutterblocwallpaper/data/repository/main_repository.dart';
import 'package:flutterblocwallpaper/helper/permission.dart';
import 'package:flutterblocwallpaper/view/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(categoryRepo: CategoryRepo()),
        ),
        BlocProvider<MainBloc>(
          create: (context) => MainBloc(mainRepository: MainRepository()),
        ),
        BlocProvider<DetailScreenBloc>(
          create: (context) => DetailScreenBloc(savedImagesToGallery: SavedImagesToGallery()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: MainScreen(),
      ),
    );
  }
}
