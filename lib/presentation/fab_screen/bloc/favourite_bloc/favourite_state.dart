import 'package:equatable/equatable.dart';
import 'package:tuannq_movie/domain/favourite/entity/user_favourite_entity.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';

import '../../../../domain/favourite/entity/user_favourite_entity.dart';
import '../../../../manager/enum/status_enum.dart';

class FavouriteState extends Equatable {
  final Status? status;
  final String? message;
  final List<UserFavouriteEntity> favourites;
  final bool isFavourite;
  final bool isReset;
  final int? loadingItemId;

  const FavouriteState({
    this.status = Status.initial,
    this.message = '',
    this.favourites = const [],
    this.isFavourite = false,
    this.isReset = false,
    this.loadingItemId,
  });

  FavouriteState copyWith({
    Status? status,
    String? message,
    List<UserFavouriteEntity>? favourites,
    bool? isFavourite,
    bool? isReset,
    int? loadingItemId,
  }) {
    return FavouriteState(
      status: status ?? this.status,
      message: message ?? this.message,
      favourites: favourites ?? this.favourites,
      isFavourite: isFavourite ?? this.isFavourite,
      isReset: isReset ?? this.isReset,
      loadingItemId: loadingItemId ?? this.loadingItemId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        favourites,
        isFavourite,
        isReset,
        loadingItemId,
      ];
}
