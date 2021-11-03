class Account {
  final String id;
  final String? city;
  final String name;

  Account(this.id, this.city, this.name);

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        json["id"] as String,
        json["city"] as String?,
        json["name"] as String,
      );
}
