import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/core/resource/api/api_exception.dart';
import 'package:tuannq_movie/domain/favourite/entity/user_favourite_entity.dart';
import 'package:tuannq_movie/domain/favourite/usecase/favourite_usecase.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/presentation/fab_screen/bloc/favourite_bloc/favourite_event.dart';
import 'package:tuannq_movie/presentation/fab_screen/bloc/favourite_bloc/favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final FavouriteUseCase favouriteUseCase;

  FavouriteBloc(this.favouriteUseCase) : super(const FavouriteState()) {
    on<AddFavourite>(_onAddFavourite);
    on<GetFavourites>(_getFavourite);
    on<RemoveFavourite>(_deleteFavourite);
    on<ResetFavourite>(_resetFavourite);
  }

  Future<void> _resetFavourite(ResetFavourite event, Emitter<FavouriteState> emit) async {
    emit(state.copyWith(status: Status.initial, favourites: []));
  }

  Future<void> _onAddFavourite(AddFavourite event, Emitter<FavouriteState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      await favouriteUseCase.addFavouriteUseCase(event.movie, event.userId);
      final updatedFavourites = List<UserFavouriteEntity>.from(state.favourites)..add(event.movie);
      emit(
        state.copyWith(status: Status.success, favourites: updatedFavourites),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  Future<void> _getFavourite(GetFavourites event, Emitter<FavouriteState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final favourites = await favouriteUseCase.getFavouriteUseCase(event.userId);
      emit(state.copyWith(status: Status.success, favourites: favourites));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    }
  }

  Future<void> _deleteFavourite(RemoveFavourite event, Emitter<FavouriteState> emit) async {
    final loadingItemId = event.movieId;
    emit(state.copyWith(loadingItemId: loadingItemId));
    try {
      await favouriteUseCase.deleteFavouriteUseCase(event.userId, event.movieId);
      final updatedFavourites = List<UserFavouriteEntity>.from(state.favourites)
        ..removeWhere((favourite) => favourite.id == event.movieId);
      emit(state.copyWith(
        status: Status.success,
        favourites: updatedFavourites,
        loadingItemId: null,
      ));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message, loadingItemId: null));
    }
  }
}
