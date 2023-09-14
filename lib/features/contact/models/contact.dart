class Contact {
  final String id;
  final String name;
  final String phoneNumber;
  final String address;
  final String email;

  Contact({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.email,
  });
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      email: map['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'email': email,
    };
  }
}
