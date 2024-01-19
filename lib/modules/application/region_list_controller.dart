import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/region.dart';

part 'region_list_controller.g.dart';

@riverpod
class RegionListController extends _$RegionListController {
  @override
  List<Region> build() {
    return [];
  }

  void addRegion(Region region) {
    state = [...state, region];
  }

  void removeRegion(Region region) {
    final indexOf = state.indexOf(region);
    if (indexOf == -1) return;

    final regions = state.toList();
    regions.removeAt(indexOf);
    state = regions;
  }

  void updateRegion(Region oldRegion, Region newRegion) {
    final indexOf = state.indexOf(oldRegion);
    if (indexOf == -1) return;

    final regions = state.toList();
    regions[indexOf] = newRegion;
    state = regions;
  }

  void clear() {
    state = [];
  }
}
