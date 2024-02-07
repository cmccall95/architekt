part of '../m_t_o_table_page.dart';

class _Tabs extends StatelessWidget {
  const _Tabs();

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
        tabs: const [
          Tab(text: 'MTO'),
          Tab(text: 'BOM Summary'),
          Tab(text: 'General'),
        ],
      ),
    );
  }
}
