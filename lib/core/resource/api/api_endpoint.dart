class ApiEndPoint {
  const ApiEndPoint();

  static const String baseApiUrl = "https://api.themoviedb.org/3";

  // List Movie

  // Now playing end point
  static const String nowPlayingMovieEndpoint = "/movie/now_playing";

  // Popular movie
  static const String popularMovieEndpoint = "/movie/popular";

  //Top rated movie
  static const String topRatedMovieEndpoint = "/movie/top_rated";

  // Upcoming movie
  static const String upcomingMovieEndpoint = "/movie/upcoming";

  //Search

  static const String searchMovieEndPoint = "/search/movie";

  // Search Keyword

  static const String searchKeywordEndPoint = "/search/keyword";

  // TV shows

  // Airing today
  static const String tvAiringTodayEndPoint = "/tv/airing_today";

  // Popular TV show
  static const String tvPopularEndPoint = "/tv/popular";

  //Cast api endpoint
  static const getCastByMovieID = "/movie/{movie_id}/credits";

  static const getCastByTVId = "/tv/{series_id}/credits";

  // comment api endpoint
  static const String commentEndPoint = "/comments";

  static const String commentDeleteEndPoint = "/comments/{id}";

  static const String commentUpdateEndPoint = "/comments/{id}";

  static const String commentGetEndPoint = "/comments/";

  static const String commentGetRepliesEndPoint = "/comments/";

  // Credit api endpoint
  static const String creditEndPoint = "/credit/{credit_id}";

  // Movie detail api endpoint
  static const String movieDetailEndPoint = '/movie/{movie_id}';

  // Genres api endpoint
  static const String genresEndPoint = '/genre/movie/list';

  // image endpoint
  static const String imageEndPoint = "/movie/{movie_id}/images";

  // like post api endpoint
  static const String likePostEndPoint = "/likes";

    static const String unlikePostEndPoint = "/likes/{id}?postId={postId}&uid={uid}";

  static const String getLikesEndPoint = "/likes";

  static const String getLikesByPostIdEndPoint = "/likes";

  // movie timewindown api endpoint
  static const String movieTimeWindowEndPoint = "/trending/movie/{time_window}";

  // similar movie api endpoint
  static const String similarMovieEndPoint = "/movie/{movie_id}/similar";

  // people api endpoint
  static const String peopleEndPoint = "/person/popular";

  static const String peopleDetailEndPoint = "/person/{person_id}";

  // review api endpoint
  static const String reviewEndPoint = "/movie/{movie_id}/reviews";

  static const String reviewTvEndPoint = "/tv/{series_id}/reviews";

  //share api endpoint
  static const String shareEndPoint = '/shared';

  static const String shareDeleteEndPoint = '/shared/{id}';

  static const String shareUpdateEndPoint = '/shared/{id}';

  // trailer api endpoint
  static const String trailerEndPoint = '/movie/{movie_id}/videos';

  // tv detail api endpoint
  static const String tvDetailEndPoint = '/tv/{series_id}';

  // tv season api endpoint
  static const String tvSimilarEndPoint = '/tv/{series_id}/similar';



}
