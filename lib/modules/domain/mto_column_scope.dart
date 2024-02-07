enum MtoFieldScope {
  general('General'),
  bom('BOM'),
  fab('Fab'),
  spec('Spec'),
  piping('Piping'),
  ;

  const MtoFieldScope(this.value);
  final String value;
}
