import 'package:flutter_bloc/flutter_bloc.dart';

//Event
abstract class HomeEvent {}

class OnLoadHome extends HomeEvent {
  final bool isFirstTime;
  OnLoadHome(this.isFirstTime);
}

//State
abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {}

//Bloc

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<OnLoadHome>((event, emit) async {
      if (event.isFirstTime) {
        // to display splash screen
        await Future.delayed(const Duration(milliseconds: 2));
      }
      emit(HomeLoaded());
    });
  }
}
