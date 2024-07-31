import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helmet/features/dash/data/failure.dart';
import 'package:helmet/features/dash/domain/helmet_model.dart';
import 'package:http/http.dart' as http;

final helmetRemoteDatasourceProvider = Provider<HelmetRemoteDatasource>((ref) {
  return HelmetRemoteDatasource();
});

class HelmetRemoteDatasource {
  final storage = FlutterSecureStorage();

  Future<Either<Failure, List<HelmetModel>>> getHelmet() async {
    try {
      final url = 'http://10.0.2.2:5500/api/getallHelmet';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true) {
          final List<dynamic> busListJson = responseData['getAllHelmet'];
          final List<HelmetModel> busList =
              busListJson.map((json) => HelmetModel.fromJson(json)).toList();
          return Right(busList);
        } else {
          return Left(Failure(error: responseData['message']));
        }
      } else {
        return Left(Failure(
          error: 'Failed to fetch data',
          statusCode: response.statusCode.toString(),
        ));
      }
    } catch (e) {
      return Left(Failure(
        error: 'An error occurred: $e',
      ));
    }
  }

}
