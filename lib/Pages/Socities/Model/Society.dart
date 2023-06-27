class Society {
  Society({
    required this.socitiesdata,
  });
  late final List<Socitiesdata> socitiesdata;
  
  Society.fromJson(Map<String, dynamic> json){
    socitiesdata = List.from(json['socitiesdata']).map((e)=>Socitiesdata.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['socitiesdata'] = socitiesdata.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Socitiesdata {
  Socitiesdata({
    required this.id,
    required this.country,
    required this.state,
    required this.city,
    required this.area,
    required this.type,
    required this.name,
    required this.address,
    required this.superadminid,
    required this.structuretype,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String country;
  late final String state;
  late final String city;
  late final String area;
  late final String type;
  late final String name;
  late final String address;
  late final int superadminid;
  late final int structuretype;
  late final String createdAt;
  late final String updatedAt;
  
  Socitiesdata.fromJson(Map<String, dynamic> json){
    id = json['id'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    area = json['area'];
    type = json['type'];
    name = json['name'];
    address = json['address'];
    superadminid = json['superadminid'];
    structuretype = json['structuretype'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['country'] = country;
    _data['state'] = state;
    _data['city'] = city;
    _data['area'] = area;
    _data['type'] = type;
    _data['name'] = name;
    _data['address'] = address;
    _data['superadminid'] = superadminid;
    _data['structuretype'] = structuretype;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}