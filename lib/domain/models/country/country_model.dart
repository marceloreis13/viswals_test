import 'package:viswals/app/constants/constant.dart';

class Name {
  String? name;

  Name({this.name});

  factory Name.fromJson(JSON json) {
    return Name(
      name: json['common'],
    );
  }
}

class Country {
  String? id;
  String? name;

  Country({
    this.id,
    this.name,
  });

  factory Country.fromJson(JSON json) {
    Name? objName;

    // Check if name come from API
    if (json['name'] is Map) {
      objName = Name.fromJson(json['name']);
    }

    // Check if name come from userDefault
    if (json['name'] is String) {
      objName = Name(name: json['name']);
    }

    return Country(
      name: "${objName?.name}",
      id: json['ccn3'],
    );
  }

  JSON toJson({bool relationship = true}) {
    final JSON data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;

    return data;
  }
}
