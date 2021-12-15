import 'dart:typed_data';

import 'package:flutter/material.dart';

class BlueprintOcrViewer extends StatefulWidget {
  const BlueprintOcrViewer({
    Key? key,
    required this.page,
    required this.data,
    required this.image,
    required this.pdfName,
  }) : super(key: key);

  final int page;
  final String pdfName;
  final Uint8List image;
  final List<dynamic> data;

  @override
  _BlueprintOcrViewerState createState() => _BlueprintOcrViewerState();
}

class _BlueprintOcrViewerState extends State<BlueprintOcrViewer> {
  final tables = <List<String>>[];

  @override
  void initState() {
    super.initState();

    for (final item in widget.data) {
      if (item.isNotEmpty) {
        tables.add(item.first.keys.toList());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.pdfName} (Page Number: ${widget.page})'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Output Data'),
              Tab(text: 'Input Image'),
            ],
          ),
        ),
        body: TabBarView(children: [
          ListView.separated(
            itemCount: tables.length,
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, i) {
              return Card(
                elevation: 5,
                child: DataTable(
                  dataRowHeight: 60,
                  columns:
                      tables[i].map((e) => DataColumn(label: Text(e))).toList(),
                  rows: [
                    for (final item in widget.data[i])
                      DataRow(cells: [
                        for (final col in tables[i])
                          DataCell(
                            TextFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero),
                              style: const TextStyle(fontSize: 12),
                              initialValue: item[col],
                              maxLines: null,
                            ),
                          )
                      ]),
                  ],
                ),
              );
            },
            separatorBuilder: (context, _) {
              return const Divider(
                height: 50,
                indent: 20,
                thickness: 2,
                endIndent: 20,
              );
            },
          ),
          // Column(children: [
          //   for (final table in tables)
          //     Card()
          // ]),
          InteractiveViewer(child: Image.memory(widget.image)),
        ]),
      ),
    );
  }
}
