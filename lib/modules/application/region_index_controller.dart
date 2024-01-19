import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'region_index_controller.g.dart';

@riverpod
class RegionIndexController extends _$RegionIndexController {
  @override
  int? build() {
    return null;
  }

  void select(int index) {
    state = index;
  }

  void unselect() {
    state = null;
  }
}
