import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../core/constant/app_constant.dart';
import '../core/internet/bloc/internet/internet_bloc.dart';
import '../core/theme/bloc/theme_bloc.dart';
import '../core/time_tracking/time_tracker.dart';
import '../data/local/detail_tv/resource/detail_movie_cached_database.dart';
import '../data/local/feed/resource/feed_cached_database.dart';
import '../data/local/keyword/datasource/keyword_db_helper.dart';
import '../data/local/movie/datasource/cached_db_helper.dart';
import '../data/local/tv_show/datasource/cached_db_tv_show_hepler.dart';
import '../data/remote/auth/auth_repository_impl.dart';
import '../data/remote/cast/api/cast_api_service.dart';
import '../data/remote/cast/repository/cast_repository_impl.dart';
import '../data/remote/comment/api/comment_api_service.dart';
import '../data/remote/comment/repository/comment_repository_impl.dart';
import '../data/remote/credit/api/credit_api_service.dart';
import '../data/remote/credit/repository/credit_repository_impl.dart';
import '../data/remote/detail_movie/api/movie_detail_api_service.dart';
import '../data/remote/detail_movie/repository/movie_detail_repository_impl.dart';
import '../data/remote/favourite/favourite_repository_impl.dart';
import '../data/remote/genres/api/genres_api_service.dart';
import '../data/remote/genres/repository/genres_repository_impl.dart';
import '../data/remote/image/api/image_api_service.dart';
import '../data/remote/image/repository/image_repository_impl.dart';
import '../data/remote/keyword/api/keyword_api_service.dart';
import '../data/remote/keyword/repository/keyword_repository_impl.dart';
import '../data/remote/like_post/api/like_post_api_service.dart';
import '../data/remote/like_post/repository/like_post_repository_impl.dart';
import '../data/remote/movie/api/movie_api_service.dart';
import '../data/remote/movie/repository/movie_repository_impl.dart';
import '../data/remote/people/api/people_api_service.dart';
import '../data/remote/people/repository/people_repository_impl.dart';
import '../data/remote/person_detail/api/detail_person_api_service.dart';
import '../data/remote/person_detail/repository/detail_person_repository_impl.dart';
import '../data/remote/review/api/review_api_service.dart';
import '../data/remote/review/repository/review_repository_impl.dart';
import '../data/remote/search/api/search_api_service.dart';
import '../data/remote/search/repository/search_repository_impl.dart';
import '../data/remote/shared/api/shared_api_service.dart';
import '../data/remote/shared/repository/shared_repository_impl.dart';
import '../data/remote/trailer/api/trailer_api_service.dart';
import '../data/remote/trailer/repository/trailer_repository_impl.dart';
import '../data/remote/tv_detail/api/tv_detail_api_service.dart';
import '../data/remote/tv_detail/repository/tv_detail_repository_impl.dart';
import '../data/remote/tv_show/api/tv_show_api_service.dart';
import '../data/remote/tv_show/repository/tv_show_repository_impl.dart';
import '../domain/auth/repository/auth_reposiory.dart';
import '../domain/auth/usecase/auth_usecase.dart';
import '../domain/cast/repository/cast_repository.dart';
import '../domain/cast/usecase/cast_usecase.dart';
import '../domain/comment/repository/comment_repository.dart';
import '../domain/comment/usecase/comment_use_case.dart';
import '../domain/creadit/repository/credit_repository.dart';
import '../domain/creadit/usecase/credit_usecase.dart';
import '../domain/detail_movie/repository/movie_detail_repository.dart';
import '../domain/detail_movie/usecase/detail_movie_usecase.dart';
import '../domain/detail_people/repository/detail_person_repository.dart';
import '../domain/detail_people/usecase/detail_person_usecase.dart';
import '../domain/favourite/repository/favourite_repository.dart';
import '../domain/favourite/usecase/favourite_usecase.dart';
import '../domain/genres/repository/genres_repository.dart';
import '../domain/genres/usecase/genres_usecase.dart';
import '../domain/image_movie/repository/image_repository.dart';
import '../domain/image_movie/usecase/image_detail_usecase.dart';
import '../domain/keyword/repository/key_word_repository.dart';
import '../domain/keyword/usecase/local/keyword_local_usecase.dart';
import '../domain/keyword/usecase/remote/keyword_remote_usecase.dart';
import '../domain/like_post/repository/like_post_repository.dart';
import '../domain/like_post/usecase/like_post_use_case.dart';
import '../domain/movie/repository/movie_reponsitory.dart';
import '../domain/movie/usecase/movie_usecase.dart';
import '../domain/people/repository/people_repository.dart';
import '../domain/people/usecase/people_usecase.dart';
import '../domain/review/repository/review_repository.dart';
import '../domain/review/usecase/review_usecase.dart';
import '../domain/search/repository/search_repository.dart';
import '../domain/search/usecase/search_usecase.dart';
import '../domain/shared/repository/shared_repository.dart';
import '../domain/shared/usecase/shared_usecase.dart';
import '../domain/trailer/repository/trailer_repository.dart';
import '../domain/trailer/usecase/trailer_usecase.dart';
import '../domain/tv_show/repository/tv_show_repository.dart';
import '../domain/tv_show/usecase/tv_show_usecase.dart';
import '../domain/tv_show_detail/repository/tv_detail_repository.dart';
import '../domain/tv_show_detail/usecase/tv_detail_usecase.dart';
import '../presentation/auth/bloc/auth_bloc.dart';
import '../presentation/commment/bloc/comeent/comment_bloc.dart';
import '../presentation/credit/bloc/credit_detail_bloc/credit_detail_bloc.dart';
import '../presentation/detail_movie/bloc/cast/cast_bloc.dart';
import '../presentation/detail_movie/bloc/detail_movie/detail_of_movie_bloc.dart';
import '../presentation/detail_movie/bloc/image/image_bloc.dart';
import '../presentation/detail_movie/bloc/review/review_bloc.dart';
import '../presentation/detail_movie/bloc/similar_movie/similar_movie_bloc.dart';
import '../presentation/detail_people/bloc/detail_persion/detail_person_bloc.dart';
import '../presentation/detail_tv/bloc/cast_tv/cast_tv_bloc.dart';
import '../presentation/detail_tv/bloc/detail_tv/detail_tv_bloc.dart';
import '../presentation/detail_tv/bloc/review/review_tv_bloc.dart';
import '../presentation/detail_tv/bloc/similar_tv_show/similar_tv_show_bloc.dart';
import '../presentation/downloaded_video/bloc/saved_video/saved_video_bloc.dart';
import '../presentation/explore/bloc/local/bloc/keyword/keyword_local_bloc.dart';
import '../presentation/explore/bloc/remote/keywordBloc/keyword_bloc.dart';
import '../presentation/explore/bloc/remote/search/search_bloc.dart';
import '../presentation/explore/bloc/remote/searchMovieBloc/search_movie_bloc.dart';
import '../presentation/explore/bloc/remote/tvShowBloc/tvshow_bloc.dart';
import '../presentation/explore/bloc/remote/tvShowPopularBloc/tv_show_popular_bloc.dart';
import '../presentation/fab_screen/bloc/favourite_bloc/favourite_bloc.dart';
import '../presentation/feed/bloc/like/like_post_bloc.dart';
import '../presentation/feed/bloc/shared_bloc/shared_bloc.dart';
import '../presentation/feed/bloc/shared_persion/shared_persion_bloc.dart';
import '../presentation/home/bloc/movie/movie_bloc.dart';
import '../presentation/home/bloc/people/people_bloc.dart';
import '../presentation/see_all_new_movie/bloc/new_movie/new_movie_bloc.dart';
import '../presentation/see_all_top_rated/bloc/top_rated/top_rated_movie_bloc.dart';
import '../presentation/see_all_trending/bloc/trending_movie/trending_movie_bloc.dart';
import '../presentation/setting/bloc/setting/setting_bloc.dart';
import '../presentation/stat/bloc/stat_bloc.dart';
import '../presentation/trailer/bloc/trailer/trailer_bloc.dart';

final sl = GetIt.instance;

void _initDio() {
  final dio = Dio()
    ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      error: true,
      compact: true,
      maxWidth: 90,
      logPrint: (object) {
        if (object.toString().contains('ERROR')) {
          if (kDebugMode) {
            print('\x1B[31m$object\x1B[0m');
          } // Red color for errors
        } else if (object.toString().contains('Request')) {
          if (kDebugMode) {
            print('\x1B[34m$object\x1B[0m');
          } // Blue color for requests
        } else if (object.toString().contains('Response')) {
          if (kDebugMode) {
            print('\x1B[32m$object\x1B[0m');
          } // Green color for responses
        } else {
          if (kDebugMode) {
            print(object);
          } // Default color for other logs
        }
      },
    ))
    ..interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (options.extra['requiresApiKey'] == true) {
          options.queryParameters.putIfAbsent('api_key', () => AppConstant.apiKey);
        }
        return handler.next(options);
      },
    ));
  sl.registerLazySingleton<Dio>(() => dio);
}

void _initFirebase() {
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  sl.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  sl.registerSingleton<FirebaseStorage>(FirebaseStorage.instance);
}

void _initRepository() async {
  // Đăng ký Box trong GetIt
  sl.registerSingleton<FirebaseAuthRepository>(
    FirebaseAuthRepository(
      firebaseAuth: sl<FirebaseAuth>(),
      firestore: sl<FirebaseFirestore>(),
      firebaseStorage: sl<FirebaseStorage>(),
    ),
  );

  sl.registerLazySingleton<MovieApiService>(() => MovieApiService(sl<Dio>()));
  sl.registerLazySingleton<PeopleApiService>(() => PeopleApiService(sl<Dio>()));
  sl.registerLazySingleton<SearchApiService>(() => SearchApiService(sl<Dio>()));
  sl.registerLazySingleton<TVShowApiService>(() => TVShowApiService(sl<Dio>()));
  sl.registerLazySingleton<KeywordApiService>(() => KeywordApiService(sl<Dio>()));
  sl.registerLazySingleton<MovieDetailApiService>(() => MovieDetailApiService(sl<Dio>()));
  sl.registerLazySingleton<CastApiService>(() => CastApiService(sl<Dio>()));
  sl.registerLazySingleton<ReviewApiService>(() => ReviewApiService(sl<Dio>()));
  sl.registerLazySingleton<ImageApiService>(() => ImageApiService(sl<Dio>()));
  sl.registerLazySingleton<CreditApiService>(() => CreditApiService(sl<Dio>()));
  sl.registerLazySingleton<TrailerApiService>(() => TrailerApiService(sl<Dio>()));
  sl.registerLazySingleton<SharedApiService>(() => SharedApiService(sl<Dio>()));
  sl.registerLazySingleton<DetailPersonApiService>(() => DetailPersonApiService(sl<Dio>()));
  sl.registerLazySingleton<TvDetailApiService>(() => TvDetailApiService(sl<Dio>()));

  sl.registerLazySingleton<GenresApiService>(() => GenresApiService(sl<Dio>()));
  sl.registerLazySingleton<LikePostApiService>(
    () => LikePostApiService(sl<Dio>()),
  );
  sl.registerLazySingleton<CommentApiService>(() => CommentApiService(sl<Dio>()));

  sl.registerLazySingleton<TimeTracker>(() => TimeTracker());

// Init Local Database
  sl.registerLazySingleton<KeywordDbHelper>(() => KeywordDbHelper());

  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  sl.registerLazySingleton<CachedFeedDatabase>(() => CachedFeedDatabase());
  sl.registerLazySingleton<CachedDetailMovieDatabase>(() => CachedDetailMovieDatabase());
  sl.registerLazySingleton<DatabaseTvShowCachedHelper>(() => DatabaseTvShowCachedHelper());

  // sl.registerLazySingleton<CachedMovieRepository>(
  //   () => CachedMovieRepository(databaseHelper: sl<DatabaseHelper>()),
  // );

// Register Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(sl(), sl<DatabaseHelper>()),
  );
  sl.registerLazySingleton<PeopleRepository>(() => PeopleRepositoryImpl(sl(), sl<DatabaseHelper>()));
  sl.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl(sl()));
  sl.registerLazySingleton<KeyWordRepository>(() => KeywordRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<TVShowRepository>(() => TVShowRepositoryImpl(sl(), sl<DatabaseTvShowCachedHelper>()));
  sl.registerLazySingleton<MovieDetailRepository>(() => MovieDetailRepositoryImpl(sl()));
  sl.registerLazySingleton<CastRepository>(() => CastRepositoryImpl(sl()));
  sl.registerLazySingleton<ReviewRepository>(() => ReviewRepositoryImpl(sl()));
  sl.registerLazySingleton<ImageRepository>(() => ImageRepositoryImpl(sl()));
  sl.registerLazySingleton<CreditRepository>(() => CreditRepositoryImpl(sl()));
  sl.registerLazySingleton<TrailerRepository>(() => TrailerRepositoryImpl(sl()));
  sl.registerLazySingleton<FavouriteRepository>(() => FavouriteRepositoryImpl(
        firestore: sl<FirebaseFirestore>(),
      ));

  sl.registerLazySingleton<SharedRepository>(() => SharedRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => FirebaseAuthRepository(firebaseAuth: sl(), firestore: sl(), firebaseStorage: sl()));

  sl.registerLazySingleton<PersonDetailRepository>(() => DetailPersonRepositoryImpl(sl()));
  sl.registerLazySingleton<TVDetailRepository>(() => TVDetailRepositoryImpl(sl()));

  sl.registerLazySingleton<GenresRepository>(() => GenresRepositoryImpl(sl()));
  sl.registerLazySingleton<LikePostRepository>(() => LikePostRepositoryImpl(sl()));
  sl.registerLazySingleton<CommentRepository>(() => CommentRepositoryImpl(sl()));
}

void _initUseCase() {
  // Auth Use Cases
  sl.registerLazySingleton<AuthUseCase>(() => AuthUseCase(sl<AuthRepository>()));

  // Movie Use Cases
  sl.registerLazySingleton<MovieUseCase>(() => MovieUseCase(sl<MovieRepository>()));

  // People Use Case
  sl.registerLazySingleton<PeopleUseCase>(() => PeopleUseCase(sl<PeopleRepository>()));

  // Search Use Cases
  sl.registerLazySingleton<SearchUseCase>(() => SearchUseCase(sl<SearchRepository>()));

  sl.registerLazySingleton<KeywordRemoteUseCase>(() => KeywordRemoteUseCase(sl<KeyWordRepository>()));

  // Keyword Local Use Cases
  sl.registerLazySingleton<KeyWordLocalUseCase>(() => KeyWordLocalUseCase(sl<KeyWordRepository>()));

  // TV Show Use Cases
  sl.registerLazySingleton<TVShowUseCase>(() => TVShowUseCase(sl<TVShowRepository>()));

  // Detail Movie Use Cases
  sl.registerLazySingleton<DetailMovieUseCase>(() => DetailMovieUseCase(sl<MovieDetailRepository>()));
  sl.registerLazySingleton<CastUseCase>(() => CastUseCase(sl<CastRepository>()));
  sl.registerLazySingleton<ReviewUseCase>(() => ReviewUseCase(sl<ReviewRepository>()));
  sl.registerLazySingleton<ImageDetailUseCase>(() => ImageDetailUseCase(sl<ImageRepository>()));

  // Credit Use Cases
  sl.registerLazySingleton<CreditUseCase>(() => CreditUseCase(sl<CreditRepository>()));

  // Trailer Use Cases
  sl.registerLazySingleton<TrailerUseCase>(() => TrailerUseCase(sl<TrailerRepository>()));

  sl.registerLazySingleton<FavouriteUseCase>(() => FavouriteUseCase(sl<FavouriteRepository>()));

  ///// Shared Use Cases

  sl.registerLazySingleton<SharedPostUseCase>(() => SharedPostUseCase(sl<SharedRepository>()));

  sl.registerLazySingleton<DetailPersonUsecase>(() => DetailPersonUsecase(sl<PersonDetailRepository>()));
  sl.registerLazySingleton<TVDetailUseCase>(() => TVDetailUseCase(sl<TVDetailRepository>()));

  sl.registerLazySingleton<GenresUseCase>(() => GenresUseCase(sl<GenresRepository>()));

  sl.registerLazySingleton<LikePostUseCase>(() => LikePostUseCase(sl<LikePostRepository>()));

  sl.registerLazySingleton<CommentUseCase>(() => CommentUseCase(sl<CommentRepository>()));
}

void _registerBloc() {
  sl.registerFactory<AuthBloc>(() => AuthBloc(
        sl(),
      ));

  // Movie bloc
  sl.registerFactory<MovieBloc>(() => MovieBloc(
        sl(),
      ));

  sl.registerFactory<SimilarMovieBloc>(() => SimilarMovieBloc(sl()));

  // People Bloc
  sl.registerFactory<PeopleBloc>(() => PeopleBloc(
        sl(),
      ));

  // Search Bloc
  sl.registerFactory<SearchMovieBloc>(() => SearchMovieBloc(sl()));

  sl.registerFactory<KeywordBloc>(() => KeywordBloc(
        sl(),
      ));

  sl.registerFactory<KeywordLocalBloc>(() => KeywordLocalBloc(
        sl(),
      ));

  //TV Show Bloc
  sl.registerFactory<TvshowBloc>(() => TvshowBloc(
        sl(),
      ));

  sl.registerFactory<TvShowPopularBloc>(() => TvShowPopularBloc(
        sl(),
      ));

  //Detail of movie default bloc
  sl.registerFactory<DetailOfMovieBloc>(() => DetailOfMovieBloc(
        sl(),
      ));

  sl.registerFactory<CastBloc>(() => CastBloc(sl()));

  sl.registerFactory<ReviewBloc>(() => ReviewBloc(sl()));

  sl.registerFactory<ImageBloc>(() => ImageBloc(sl()));

  sl.registerFactory<CreditDetailBloc>(() => CreditDetailBloc(sl()));

  sl.registerFactory<TrailerBloc>(() => TrailerBloc(sl()));

  // Theme Bloc
  sl.registerFactory<ThemeBloc>(() => ThemeBloc());

  sl.registerFactory<FavouriteBloc>(() => FavouriteBloc(sl()));

  sl.registerFactory<SharedBloc>(() => SharedBloc(sl()));
  sl.registerFactory<SharedPersonBloc>(() => SharedPersonBloc(sl()));
  sl.registerFactory<DetailPersonBloc>(() => DetailPersonBloc(sl()));
  sl.registerFactory<DetailTvBloc>(() => DetailTvBloc(sl()));
  sl.registerFactory<CastTvBloc>(() => CastTvBloc(sl()));
  sl.registerFactory<SimilarTvShowBloc>(() => SimilarTvShowBloc(sl()));
  sl.registerFactory<ReviewTvBloc>(() => ReviewTvBloc(sl()));
  sl.registerFactory<SettingBloc>(() => SettingBloc());
  sl.registerFactory<SearchBloc>(() => SearchBloc(sl()));
  sl.registerFactory<SavedVideosBloc>(() => SavedVideosBloc());
  sl.registerFactory<TrendingMovieBloc>(() => TrendingMovieBloc(sl()));
  sl.registerFactory<NewMovieBloc>(() => NewMovieBloc(sl()));
  sl.registerFactory<TopRatedMovieBloc>(() => TopRatedMovieBloc(sl()));
  sl.registerFactory<LikePostBloc>(() => LikePostBloc(sl()));
  sl.registerFactory<CommentBloc>(() => CommentBloc(sl()));
  sl.registerFactory<StatBloc>(() => StatBloc(sl()));
  sl.registerFactory<InternetBloc>(() => InternetBloc(sl<Connectivity>()));
}

Future<void> initializeDependencies() async {
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  // Initialize Dio
  _initDio();

  // Initialize Firebase
  _initFirebase();

  // Initialize Repositories
  _initRepository();

  // Initialize UseCase
  _initUseCase();

  // Register Blocs
  _registerBloc();
}
