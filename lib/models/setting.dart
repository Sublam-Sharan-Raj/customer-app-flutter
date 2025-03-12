class Setting {
  String title;
  String description;
  bool isSwitch;
  dynamic value;

  Setting({
    required this.title,
    required this.description,
    this.isSwitch = false,
    this.value,
  });
}
