enum AISFieldScope {
  general('General'),
  bom('BOM'),
  fab('Fab'),
  spec('Spec'),
  ;

  const AISFieldScope(this.value);
  final String value;
}
