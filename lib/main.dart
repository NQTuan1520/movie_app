import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/core/internet/bloc/internet/internet_bloc.dart';
import 'package:tuannq_movie/core/service/storage_service.dart';
import 'package:tuannq_movie/core/theme/bloc/theme_bloc.dart';
import 'package:tuannq_movie/core/theme/bloc/theme_event.dart';
import 'package:tuannq_movie/core/theme/bloc/theme_state.dart';
import 'package:tuannq_movie/core/theme/theme.dart';
import 'package:tuannq_movie/core/time_tracking/time_tracker.dart';
import 'package:tuannq_movie/di/injection.dart';
import 'package:tuannq_movie/domain/comment/usecase/comment_use_case.dart';
import 'package:tuannq_movie/domain/favourite/usecase/favourite_usecase.dart';
import 'package:tuannq_movie/domain/genres/usecase/genres_usecase.dart';
import 'package:tuannq_movie/domain/keyword/usecase/local/keyword_local_usecase.dart';
import 'package:tuannq_movie/domain/keyword/usecase/remote/keyword_remote_usecase.dart';
import 'package:tuannq_movie/domain/like_post/usecase/like_post_use_case.dart';
import 'package:tuannq_movie/domain/movie/usecase/movie_usecase.dart';
import 'package:tuannq_movie/domain/people/usecase/people_usecase.dart';
import 'package:tuannq_movie/domain/search/usecase/search_usecase.dart';
import 'package:tuannq_movie/domain/shared/usecase/shared_usecase.dart';
import 'package:tuannq_movie/domain/trailer/usecase/trailer_usecase.dart';
import 'package:tuannq_movie/domain/tv_show/usecase/tv_show_usecase.dart';

import 'package:tuannq_movie/manager/router/routes.dart';
import 'package:tuannq_movie/manager/router/routes_name.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_bloc.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_event.dart';
import 'package:tuannq_movie/presentation/commment/bloc/comeent/comment_bloc.dart';
import 'package:tuannq_movie/presentation/downloaded_video/bloc/saved_video/saved_video_bloc.dart';
import 'package:tuannq_movie/presentation/explore/bloc/local/bloc/keyword/keyword_local_bloc.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/search/search_bloc.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/searchMovieBloc/search_movie_bloc.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/tvShowBloc/tvshow_bloc.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/tvShowPopularBloc/tv_show_popular_bloc.dart';
import 'package:tuannq_movie/presentation/fab_screen/bloc/favourite_bloc/favourite_bloc.dart';
import 'package:tuannq_movie/presentation/feed/bloc/like/like_post_bloc.dart';
import 'package:tuannq_movie/presentation/feed/bloc/shared_bloc/shared_bloc.dart';
import 'package:tuannq_movie/presentation/feed/bloc/shared_bloc/shared_event.dart';
import 'package:tuannq_movie/presentation/home/bloc/genres/genres_bloc.dart';
import 'package:tuannq_movie/presentation/home/bloc/genres/genres_event.dart';
import 'package:tuannq_movie/presentation/home/bloc/movie/movie_bloc.dart';
import 'package:tuannq_movie/presentation/home/bloc/people/people_bloc.dart';
import 'package:tuannq_movie/presentation/setting/bloc/setting/setting_bloc.dart';
import 'package:tuannq_movie/presentation/stat/bloc/stat_bloc.dart';
import 'package:tuannq_movie/presentation/trailer/bloc/trailer/trailer_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'presentation/explore/bloc/remote/keywordBloc/keyword_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // bool isAllowSendNotification = await AwesomeNotifications().isNotificationAllowed();
  // if (!isAllowSendNotification) {
  //   await AwesomeNotifications().requestPermissionToSendNotifications();
  // }
  await Firebase.initializeApp();

  await EasyLocalization.ensureInitialized();
  await initializeDependencies();

  String uid = '';
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    uid = user.uid;
  } else {
    uid = 'default';
  }

  final isDarkMode = await StorageService().getBool("theme_$uid") ?? false;
  final TimeTracker timeTracker = TimeTracker();
  await timeTracker.init(uid);

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('vi', 'VN'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: MyApp(isDarkMode: isDarkMode, uid: uid),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isDarkMode;
  final String uid;

  const MyApp({super.key, required this.isDarkMode, required this.uid});

  @override
  Widget build(BuildContext context) {
    return RegisterBlocProviderWidget(
      isDarkMode: isDarkMode,
      uid: uid,
    );
  }
}

class RegisterBlocProviderWidget extends StatelessWidget {
  const RegisterBlocProviderWidget({
    super.key,
    required this.isDarkMode,
    required this.uid,
  });

  final bool isDarkMode;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => sl<AuthBloc>()
            ..add(AuthCheckStatus())
            ..add(GetInformationEvent()),
        ),
        BlocProvider(
          create: (_) => MovieBloc(
            sl<MovieUseCase>(),
          ),
        ),
        BlocProvider(
          create: (_) => PeopleBloc(
            sl<PeopleUseCase>(),
          ),
        ),
        BlocProvider(
          create: (_) => SearchMovieBloc(
            sl<SearchUseCase>(),
          ),
        ),
        BlocProvider(
          create: (_) => TvshowBloc(
            sl<TVShowUseCase>(),
          ),
        ),
        BlocProvider(
          create: (_) => TvShowPopularBloc(
            sl<TVShowUseCase>(),
          ),
        ),
        BlocProvider(
          create: (_) => KeywordBloc(
            sl<KeywordRemoteUseCase>(),
          ),
        ),
        BlocProvider(
          create: (_) => KeywordLocalBloc(
            sl<KeyWordLocalUseCase>(),
          ),
        ),
        BlocProvider(
          create: (_) => TrailerBloc(
            sl<TrailerUseCase>(),
          ),
        ),
        BlocProvider(
          create: (_) => FavouriteBloc(sl<FavouriteUseCase>()),
        ),
        BlocProvider(
          create: (_) => SharedBloc(
            sl<SharedPostUseCase>(),
          )..add(const GetAllSharedEvent()),
        ),
        BlocProvider(
          create: (_) => SettingBloc(),
        ),
        BlocProvider(create: (_) => SearchBloc(sl())),
        BlocProvider(
          create: (_) => SavedVideosBloc(),
        ),
        BlocProvider(
          create: (context) => GenresBloc(sl<GenresUseCase>())..add(const GetGenres()),
        ),
        BlocProvider(
          create: (_) => LikePostBloc(sl<LikePostUseCase>()),
        ),
        BlocProvider(
          create: (_) => CommentBloc(sl<CommentUseCase>()),
        ),
        BlocProvider(
          create: (_) => StatBloc(
            sl<TimeTracker>(),
          ),
        ),
        BlocProvider(
          create: (_) => InternetBloc(sl<Connectivity>()),
        )
      ],
      child: MainAppWidget(isDarkMode: isDarkMode),
    );
  }
}

class MainAppWidget extends StatelessWidget {
  const MainAppWidget({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themState) {
        if (themState is ThemeInitial) {
          if (isDarkMode == true) {
            context.read<ThemeBloc>().add(ThemeChangeEvent(themeData: TAppTheme.darkTheme.themeData));
          } else if (isDarkMode == false) {
            context.read<ThemeBloc>().add(ThemeChangeEvent(themeData: TAppTheme.lightTheme.themeData));
          }
        }
        if (themState is ThemeSuccess) {
          return RefreshConfiguration(
            headerBuilder: () => const WaterDropMaterialHeader(),
            footerBuilder: () => const ClassicFooter(),
            headerTriggerDistance: 80.0,
            springDescription: const SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
            maxOverScrollExtent: 100,
            maxUnderScrollExtent: 0,
            enableScrollWhenRefreshCompleted: true,
            enableLoadingWhenFailed: true,
            hideFooterWhenNotFull: false,
            enableBallisticLoad: true,
            child: ScreenUtilInit(
                designSize: const Size(375, 812),
                minTextAdapt: true,
                splitScreenMode: true,
                child: MaterialApp(
                  title: 'Flutter Demo',
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  theme: themState.themeData,
                  darkTheme: TAppTheme.darkTheme.themeData, // Dark theme
                  initialRoute: RoutesName.splash,
                  onGenerateRoute: Routes.generateRoutes,
                  debugShowCheckedModeBanner: false,
                )),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
