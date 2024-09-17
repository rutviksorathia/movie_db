part of 'movie.dart';

class ApiMovieListV1RequestQuery {
  int page;
  String sortBy;
  String apiKey;

  ApiMovieListV1RequestQuery({
    this.page = 1,
    this.apiKey = '55903b004b65252bf433fb4218601d2c',
    this.sortBy = 'popularity.desc',
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'api_key': apiKey,
      'sort_by': sortBy,
    };
  }
}

Future<ApiMovieListV1ResponseBody> apiMovieListV1({
  required ApiMovieListV1RequestQuery query,
}) async {
  final response = await sendRequest.get(
    'discover/movie',
    query: query.toMap(),
  );

  return ApiMovieListV1ResponseBody.fromMap(jsonDecode(response.body));
}

class ApiMovieListV1ResponseBody {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  ApiMovieListV1ResponseBody({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory ApiMovieListV1ResponseBody.fromMap(Map<String, dynamic> map) {
    return ApiMovieListV1ResponseBody(
      page: map['page'],
      totalPages: map['total_pages'],
      totalResults: map['total_results'],
      results: (map['results'] as List).map((e) => Movie.fromMap(e)).toList(),
    );
  }
}
