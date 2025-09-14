class MenuItem {
  final String id;
  final String name;
  final String route;
  final List<MenuItem> subcategory; // 👈 added

  MenuItem({
    required this.id,
    required this.name,
    required this.route,
    this.subcategory = const [],
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      route: json['route'] ?? '',
      subcategory:
          (json['subcategory'] as List<dynamic>?)
              ?.map((item) => MenuItem.fromJson(item))
              .toList() ??
          [],
    );
  }
}
