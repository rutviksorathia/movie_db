part of 'movie.dart';

class ApiMovieGetByIdV1RequestQuery {
  String apiKey;

  ApiMovieGetByIdV1RequestQuery({
    this.apiKey = '55903b004b65252bf433fb4218601d2c',
  });

  Map<String, dynamic> toMap() {
    return {
      'api_key': apiKey,
    };
  }
}

Future<Movie> apiMovieGetByIdV1({
  required int movieId,
  required ApiMovieGetByIdV1RequestQuery query,
}) async {
  final response = await sendRequest.get(
    'movie/$movieId',
    query: query.toMap(),
  );

  return Movie.fromMap(jsonDecode(response.body));
}
