import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/roi.dart';

part 'region_list_controller.g.dart';

@riverpod
class RegionListController extends _$RegionListController {
  @override
  List<Roi> build() {
    return [];
  }

  void addRegions(List<Roi> regions) {
    state = [...state, ...regions];
  }

  void addRegion(Roi region) {
    state = [...state, region];
  }

  void removeRegion(Roi region) {
    final indexOf = state.indexOf(region);
    if (indexOf == -1) return;

    final regions = state.toList();
    regions.removeAt(indexOf);
    state = regions;
  }

  void updateRegion(Roi oldRegion, Roi newRegion) {
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
