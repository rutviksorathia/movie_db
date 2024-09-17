part of 'movie.dart';

class ApiTopRatedMovieListV1RequestQuery {
  int page;
  String apiKey;

  ApiTopRatedMovieListV1RequestQuery({
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

Future<ApiTopRatedMovieListV1ResponseBody> apiTopRatedMovieListV1({
  required ApiTopRatedMovieListV1RequestQuery query,
}) async {
  final response = await sendRequest.get(
    'movie/top_rated',
    query: query.toMap(),
  );

  return ApiTopRatedMovieListV1ResponseBody.fromMap(jsonDecode(response.body));
}

class ApiTopRatedMovieListV1ResponseBody {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  ApiTopRatedMovieListV1ResponseBody({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory ApiTopRatedMovieListV1ResponseBody.fromMap(Map<String, dynamic> map) {
    return ApiTopRatedMovieListV1ResponseBody(
      page: map['page'],
      totalPages: map['total_pages'],
      totalResults: map['total_results'],
      results: (map['results'] as List).map((e) => Movie.fromMap(e)).toList(),
    );
  }
}
