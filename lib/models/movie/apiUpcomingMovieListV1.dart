part of 'movie.dart';

class ApiUpcomingMovieListV1RequestQuery {
  int page;
  String apiKey;

  ApiUpcomingMovieListV1RequestQuery({
    this.page = 1,
    this.apiKey = '55903b004b65252bf433fb4218601d2c',
  });

  Map<String, dynamic> toMap() {
    return {'page': page, 'api_key': apiKey};
  }
}

Future<ApiUpcomingMovieListV1ResponseBody> apiUpcomingMovieListV1({
  required ApiUpcomingMovieListV1RequestQuery query,
}) async {
  final response = await sendRequest.get(
    'movie/upcoming',
    query: query.toMap(),
  );

  return ApiUpcomingMovieListV1ResponseBody.fromMap(jsonDecode(response.body));
}

class ApiUpcomingMovieListV1ResponseBody {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  ApiUpcomingMovieListV1ResponseBody({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory ApiUpcomingMovieListV1ResponseBody.fromMap(Map<String, dynamic> map) {
    return ApiUpcomingMovieListV1ResponseBody(
      page: map['page'],
      totalPages: map['total_pages'],
      totalResults: map['total_results'],
      results: (map['results'] as List).map((e) => Movie.fromMap(e)).toList(),
    );
  }
}
