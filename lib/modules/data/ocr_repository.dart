import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/config/client_http.dart';
import '../../core/config/logger_custom.dart';
import '../../core/utils/either.dart';

part 'ocr_repository.g.dart';

@riverpod
OcrRepository ocrRepository(OcrRepositoryRef ref) {
  return OcrRepository(ref.read(clientHttpProvider));
}

class OcrRepository {
  OcrRepository(this._client);

  final ClientHttp _client;

  Future<Either<String, void>> applyOcr({
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

      return response.fold(
        left: (l) => Left(l.message),
        right: (r) => const Right(null),
      );
    } catch (e, stack) {
      logger.e('Failed to apply ocr', error: e, stackTrace: stack);
      return Left(e.toString());
    }
  }
}
