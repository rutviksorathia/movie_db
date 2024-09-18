part of 'movie.dart';

class ApiMovieCreditGetByIdV1RequestQuery {
  String apiKey;

  ApiMovieCreditGetByIdV1RequestQuery({
    this.apiKey = '55903b004b65252bf433fb4218601d2c',
  });

  Map<String, dynamic> toMap() {
    return {
      'api_key': apiKey,
    };
  }
}

Future<MovieCredit> apiMovieCreditGetByIdV1({
  required int movieId,
  required ApiMovieCreditGetByIdV1RequestQuery query,
}) async {
  final response = await sendRequest.get(
    'movie/$movieId/credits',
    query: query.toMap(),
  );

  return MovieCredit.fromMap(jsonDecode(response.body));
}
