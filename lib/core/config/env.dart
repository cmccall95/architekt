abstract class Env {
  static const baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: '',
  );

  static const inputPathDocker = String.fromEnvironment(
    'INPUT_PATH_DOCKER',
    defaultValue: '',
  );

  static const outputPathDocker = String.fromEnvironment(
    'OUTPUT_PATH_DOCKER',
    defaultValue: '',
  );
}
