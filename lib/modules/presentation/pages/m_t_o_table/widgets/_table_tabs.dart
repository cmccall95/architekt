part of '../m_t_o_table_page.dart';

class _TableTabs extends StatelessWidget {
  const _TableTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                _MTOTab(),
                _MTOGroupedTab(),
              ],
            ),
          ),
          _Tabs(),
        ],
      ),
    );
  }
}

class _Tabs extends StatelessWidget {
  const _Tabs({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 300,
      height: kToolbarHeight - 8.0,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TabBar(
        indicator: BoxDecoration(
          color: theme.canvasColor,
        ),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black,
        tabs: const [
          Tab(text: 'MTO'),
          Tab(text: 'MTO Grouped'),
        ],
      ),
    );
  }
}
