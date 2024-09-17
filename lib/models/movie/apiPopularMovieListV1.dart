part of 'movie.dart';

class ApiPopularMovieListV1RequestQuery {
  int page;
  String apiKey;

  ApiPopularMovieListV1RequestQuery({
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

Future<ApiPopularMovieListV1ResponseBody> apiPopularMovieListV1({
  required ApiPopularMovieListV1RequestQuery query,
}) async {
  final response = await sendRequest.get(
    'movie/popular',
    query: query.toMap(),
  );

  return ApiPopularMovieListV1ResponseBody.fromMap(jsonDecode(response.body));
}

class ApiPopularMovieListV1ResponseBody {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  ApiPopularMovieListV1ResponseBody({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory ApiPopularMovieListV1ResponseBody.fromMap(Map<String, dynamic> map) {
    return ApiPopularMovieListV1ResponseBody(
      page: map['page'],
      totalPages: map['total_pages'],
      totalResults: map['total_results'],
      results: (map['results'] as List).map((e) => Movie.fromMap(e)).toList(),
    );
  }
}
