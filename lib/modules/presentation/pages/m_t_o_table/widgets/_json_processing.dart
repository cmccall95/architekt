part of '../m_t_o_table_page.dart';

class _JsonProcessing extends StatelessWidget {
  const _JsonProcessing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final state = Get.find<MapJsonToDatabaseController>().state;
      if (state.isLoading) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text('Building database...'),
            ],
          ),
        );
      }

      if (state.hasError) {
        return Center(
          child: Text(state.asError.message),
        );
      }

      return const _TableTabs();
    });
  }
}
