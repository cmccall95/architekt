enum ColumnName {
  column1('column1'),
  column2('column2'),
  column3('column3'),
  column4('column4'),
  column5('column5');

  const ColumnName(this.value);
  final String value;

  String get name {
    return switch (this) {
      ColumnName.column1 => 'column1',
      ColumnName.column2 => 'column2',
      ColumnName.column3 => 'column3',
      ColumnName.column4 => 'column4',
      ColumnName.column5 => 'column5',
    };
  }
}
