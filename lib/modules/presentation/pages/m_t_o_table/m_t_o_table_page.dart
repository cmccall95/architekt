import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../../../../core/utils/extensions/string.dart';
import '../../../application/get_table_rows_controller.dart';
import '../../../application/load_table_controller.dart';
import '../../../domain/a_i_s_data.dart';
import '../../../domain/a_i_s_field.dart';
import '../../../domain/a_i_s_table.dart';
import '../../widgets/table_custom.dart';

part 'widgets/_table.dart';
part 'widgets/_table_loader.dart';

class MTOTablePage extends ConsumerStatefulWidget {
  const MTOTablePage({super.key});

  @override
  ConsumerState<MTOTablePage> createState() => _MTOTablePageState();
}

class _MTOTablePageState extends ConsumerState<MTOTablePage> {
  late final List<AISTable> tables;

  @override
  void initState() {
    super.initState();

    tables = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MTO Table'),
      ),
      body: DefaultTabController(
        length: tables.length,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: tables.map((e) {
                  return _TableLoader(table: e);
                }).toList(),
              ),
            ),
            _Tabs(tables: tables),
          ],
        ),
      ),
    );
  }
}

class _Tabs extends StatelessWidget {
  const _Tabs({
    required this.tables,
  });

  final List<AISTable> tables;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: kToolbarHeight - 8.0,
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TabBar(
        isScrollable: true,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black,
        indicator: BoxDecoration(
          color: theme.canvasColor,
        ),
        tabs: tables.map((table) {
          return Tab(text: table.name.toSentenceCase);
        }).toList(),
      ),
    );
  }
}
