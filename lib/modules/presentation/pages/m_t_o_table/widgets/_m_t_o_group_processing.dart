part of '../m_t_o_table_page.dart';

class _MTOGroupProcessing extends StatelessWidget {
  const _MTOGroupProcessing({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final state = Get.find<GenerateMTOGroupedController>().state;
      if (state.isLoading) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text('Grouping MTOs...'),
            ],
          ),
        );
      }

      if (state.hasError) {
        return Center(
          child: Text(state.asError.message),
        );
      }

      return builder(context);
    });
  }
}
