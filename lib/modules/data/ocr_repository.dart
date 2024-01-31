import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/config/client_http.dart';
import '../../core/config/logger_custom.dart';
import '../../core/utils/either.dart';
import '../domain/a_i_s_table.dart';

part 'ocr_repository.g.dart';

@riverpod
OcrRepository ocrRepository(OcrRepositoryRef ref) {
  return OcrRepository(ref.read(clientHttpProvider));
}

class OcrRepository {
  OcrRepository(this._client);

  final ClientHttp _client;

  Future<Either<String, List<AISTable>>> applyOcr({
    required String pdfPath,
    required String coordinatesPath,
    required String payloadOptionsPath,
  }) async {
    try {
      final response = await _client.post(
        '/process_pdf_txt',
        data: {
          'pdf_path': pdfPath,
          'roi_payload': coordinatesPath,
          'payload_options': payloadOptionsPath,
          "parent_directory": "Architekt IS",
          "sub_directory": "AIS Test Folder 1"
        },
      );

      switch (response) {
        case Left(:final value):
          return Left(value.message);
        case Right(:final value):
          final data = value['data'] as Map<String, dynamic>;
          final tables = data.entries.map((e) {
            return AISTable.fromJson({
              'name': e.key,
              'data': e.value,
            });
          }).toList();

          return Right(tables);
      }
    } catch (e, stack) {
      logger.e('Failed to apply ocr', error: e, stackTrace: stack);
      return Left(e.toString());
    }
  }
}
