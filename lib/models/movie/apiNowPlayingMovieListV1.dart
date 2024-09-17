part of 'movie.dart';

class ApiNowPlayingMovieListV1RequestQuery {
  int page;
  String apiKey;

  ApiNowPlayingMovieListV1RequestQuery({
    this.page = 1,
    this.apiKey = '55903b004b65252bf433fb4218601d2c',
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'api_key': apiKey,
    };
  }
}

Future<ApiNowPlayingMovieListV1ResponseBody> apiNowPlayingMovieListV1({
  required ApiNowPlayingMovieListV1RequestQuery query,
}) async {
  final response = await sendRequest.get(
    'movie/now_playing',
    query: query.toMap(),
  );

  return ApiNowPlayingMovieListV1ResponseBody.fromMap(
      jsonDecode(response.body));
}

class ApiNowPlayingMovieListV1ResponseBody {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  ApiNowPlayingMovieListV1ResponseBody({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory ApiNowPlayingMovieListV1ResponseBody.fromMap(
      Map<String, dynamic> map) {
    return ApiNowPlayingMovieListV1ResponseBody(
      page: map['page'],
      totalPages: map['total_pages'],
      totalResults: map['total_results'],
      results: (map['results'] as List).map((e) => Movie.fromMap(e)).toList(),
    );
  }
}
