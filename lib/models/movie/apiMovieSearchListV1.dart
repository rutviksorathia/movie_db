part of 'movie.dart';

class ApiMovieSearchListV1RequestQuery {
  int page;
  String apiKey;
  String query;

  ApiMovieSearchListV1RequestQuery({
    this.page = 1,
    this.apiKey = '55903b004b65252bf433fb4218601d2c',
    this.query = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'api_key': apiKey,
      'query': query,
    };
  }
}

Future<ApiMovieSearchV1ResponseBody> apiMovieSearchV1({
  required ApiMovieSearchListV1RequestQuery query,
}) async {
  final response = await sendRequest.get(
    'search/movie',
    query: query.toMap(),
  );

  return ApiMovieSearchV1ResponseBody.fromMap(jsonDecode(response.body));
}

class ApiMovieSearchV1ResponseBody {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  ApiMovieSearchV1ResponseBody({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory ApiMovieSearchV1ResponseBody.fromMap(Map<String, dynamic> map) {
    return ApiMovieSearchV1ResponseBody(
      page: map['page'],
      totalPages: map['total_pages'],
      totalResults: map['total_results'],
      results: (map['results'] as List).map((e) => Movie.fromMap(e)).toList(),
    );
  }
}
