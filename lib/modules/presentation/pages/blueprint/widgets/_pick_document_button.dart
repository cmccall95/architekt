part of '../blueprint_page.dart';

class PickDocumentButton extends ConsumerWidget {
  const PickDocumentButton({super.key});

  void _loadTestRegions(WidgetRef ref) {
    final json = [
      {
        "columnName": "line_number",
        "relativeX0": 0.8434020292999054,
        "relativeX1": 0.9881214559334368,
        "relativeY0": 0.9283236994219654,
        "relativeY1": 0.9491329479768786
      },
      {
        "columnName": "drawing",
        "relativeX0": 0.5302520835335631,
        "relativeX1": 0.6578014087020994,
        "relativeY0": 0.730635838150289,
        "relativeY1": 0.7722543352601156
      },
      {
        "columnName": "area",
        "relativeX0": 0.9357935276591656,
        "relativeX1": 0.9881214559334368,
        "relativeY0": 0.8265895953757225,
        "relativeY1": 0.8531791907514451
      },
      {
        "columnName": "sheet",
        "relativeX0": 0.8916418381777492,
        "relativeX1": 0.9202586739527413,
        "relativeY0": 0.8277456647398844,
        "relativeY1": 0.8543352601156069
      },
      {
        "columnName": "p_and_id",
        "relativeX0": 0.9129000590391719,
        "relativeX1": 0.9873038320541514,
        "relativeY0": 0.7861271676300579,
        "relativeY1": 0.8115606936416185
      },
      {
        "columnName": "rev",
        "relativeX0": 0.0879175648401137,
        "relativeX1": 0.11326390509796386,
        "relativeY0": 0.8867052023121387,
        "relativeY1": 0.9745664739884393
      },
      {
        "columnName": "medium_code",
        "relativeX0": 0.7812626144742081,
        "relativeX1": 0.8172380651627696,
        "relativeY0": 0.8312138728323699,
        "relativeY1": 0.8543352601156069
      },
      {
        "columnName": "process_unit",
        "relativeX0": 0.8172380651627696,
        "relativeX1": 0.8523958919720457,
        "relativeY0": 0.8312138728323699,
        "relativeY1": 0.853179190751445
      },
      {
        "columnName": "sequence_number",
        "relativeX0": 0.8515782680927603,
        "relativeX1": 0.8867360949020363,
        "relativeY0": 0.8323699421965318,
        "relativeY1": 0.8554913294797688
      },
      {
        "columnName": "BOM",
        "tableCoordinates": {
          "relativeX0": 0.6659776474949543,
          "relativeX1": 0.9913919514505789,
          "relativeY0": 0.04277456647398844,
          "relativeY1": 0.5768786127167631
        },
        "tableColumns": [
          {
            "columnName": "pos",
            "relativeX0": 0.6684305191328107,
            "relativeX1": 0.6872358683563768,
            "relativeY0": 0.04508670520231214,
            "relativeY1": 0.5768786127167631
          },
          {
            "columnName": "ident",
            "relativeX0": 0.687235868356377,
            "relativeX1": 0.7199408235277964,
            "relativeY0": 0.04508670520231214,
            "relativeY1": 0.5745664739884394
          },
          {
            "columnName": "nps",
            "relativeX0": 0.7199408235277964,
            "relativeX1": 0.7550986503370725,
            "relativeY0": 0.04508670520231214,
            "relativeY1": 0.5757225433526012
          },
          {
            "columnName": "material_description",
            "relativeX0": 0.7550986503370725,
            "relativeX1": 0.9521460052448754,
            "relativeY0": 0.04508670520231214,
            "relativeY1": 0.576878612716763
          },
          {
            "columnName": "quantity",
            "relativeX0": 0.9505107574863043,
            "relativeX1": 0.9889390798127222,
            "relativeY0": 0.046242774566473986,
            "relativeY1": 0.5722543352601156
          }
        ]
      }
    ];

    final regions = json.map((e) => Roi.fromJson(e)).toList();

    final notifier = ref.read(regionListControllerProvider.notifier);
    notifier.clear();
    notifier.addRegions(regions);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: OutlinedButton.icon(
        onPressed: () async {
          final notifier = ref.read(blueprintPdfControllerProvider.notifier);
          await notifier.pickDocument();

          _loadTestRegions(ref);
        },
        label: const Text('Pick File'),
        icon: const Icon(Icons.upload_rounded),
        style: OutlinedButton.styleFrom(
          foregroundColor: context.theme.appBarTheme.iconTheme?.color,
        ),
      ),
    );
  }
}
