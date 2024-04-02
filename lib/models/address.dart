class Address {
  final String postalCode;
  final String city;
  final String state;
  final String neighborhood;
  final String? complement;

  Address({
    required this.postalCode,
    required this.city,
    required this.state,
    required this.neighborhood,
    required this.complement,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
      postalCode: json['postalCode'],
      city: json['city'],
      state: json['state'],
      neighborhood: json['neighborhood'],
      complement: json['complement']);

  Map<String, dynamic> toJson() => {
        "postalCode": postalCode,
        "city": city,
        "state": state,
        "neighborhood": neighborhood,
        "complement": complement,
      };
}
