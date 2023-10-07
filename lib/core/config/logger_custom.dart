import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  filter: _Filter(),
);

class _Filter extends DevelopmentFilter {
  @override
  bool shouldLog(LogEvent event) {
    if (!kDebugMode && event.level == Level.error) {
      registerProductionError(event);
    }

    return super.shouldLog(event);
  }

  Future<void> registerProductionError(LogEvent event) async {
    // Register the error any analytics service (firebase, sentry, etc).
  }
}
