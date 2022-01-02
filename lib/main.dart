import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:themoviedb/bloc/movies_bloc.dart';
import 'repository/movies_repository.dart';
import 'view/view.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<bool>("favoriteMovies");
  BlocOverrides.runZoned(
    () => runApp(const App()),
    blocObserver: SimpleBlocObserver(),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => MoviesRepository(),
      child: BlocProvider(
        create: (context) =>
            MoviesBloc(moviesRepository: context.read<MoviesRepository>()),
        child: MaterialApp(
          theme: TheMovieTheme.darkTheme,
          home: const MoviesScreen(),
        ),
      ),
    );
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}
