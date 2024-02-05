enum MtoFieldScope {
  general('General'),
  bom('BOM'),
  fab('Fab'),
  spec('Spec'),
  ;

  const MtoFieldScope(this.value);
  final String value;
}
